from datetime import datetime, timedelta

from airflow import DAG
from airflow.decorators import dag, task
from airflow.operators.dummy import DummyOperator
from airflow.providers.amazon.aws.operators.glue import (
    GlueDataQualityRuleSetEvaluationRunOperator,
    GlueJobOperator,
)
from airflow.providers.docker.operators.docker import DockerOperator
from docker.types import Mount

default_args = {
    "owner": "airflow",
    "description": "Demo for usage of the DockerOperator for DBT",
    "depends_on_past": False,
    "email_on_failure": False,
    "email_on_retry": False,
    "retries": 1,
    "retry_delay": timedelta(minutes=5),
}


DATA_BUCKET_NAME = "<YOUR-DATA-LAKE-BUCKET>"
SCRIPTS_BUCKET_NAME = "<YOUR-SCRIPTS-BUCKET>"


@dag(
    default_args=default_args,
    schedule_interval="0 0 1 * *",  # Runs at midnight on the first day of every month
    start_date=datetime(2020, 2, 1),
    end_date=datetime(2020, 3, 1),
    catchup=True,
    max_active_runs=1,
    dag_id="deftunes_songs_pipeline_dag",
)
def deftunes_songs_pipeline():

    start = DummyOperator(task_id="start")

    rds_extract_glue_job = GlueJobOperator(
        task_id="rds_extract_glue_job",
        job_name="de-c4w4a2-rds-extract-job",
        script_location=f"s3://{SCRIPTS_BUCKET_NAME}/de-c4w4a2-extract-songs-job.py",
        job_desc="Glue Job to extract data from RDS",
        iam_role_name="Cloud9-de-c4w4a2-glue-role",
        s3_bucket=f"{SCRIPTS_BUCKET_NAME}",
        region_name="us-east-1",
        create_job_kwargs={
            "GlueVersion": "3.0",
            "NumberOfWorkers": 2,
            "WorkerType": "G.1X",
        },
        script_args={
            "--data_lake_bucket": f"{DATA_BUCKET_NAME}",
            "--rds_connection": "de-c4w4a2-connection-rds",
            "--ingest_date": "{{ next_ds }}",
        },
    )

    songs_transform_glue_job = GlueJobOperator(
        task_id="songs_transform_glue_job",
        job_name="de-c4w4a2-songs-transform-job",
        script_location=f"s3://{SCRIPTS_BUCKET_NAME}/de-c4w4a2-transform-songs-job.py",
        job_desc="Glue Job to extract data from RDS",
        iam_role_name="Cloud9-de-c4w4a2-glue-role",
        s3_bucket=f"{SCRIPTS_BUCKET_NAME}",
        region_name="us-east-1",
        create_job_kwargs={
            "GlueVersion": "3.0",
            "NumberOfWorkers": 2,
            "WorkerType": "G.1X",
        },
        script_args={
            "--catalog_database": "de_c4w4a2_transform_db",
            "--ingest_date": "{{ next_ds }}",
            "--songs_table": "songs",
            "--source_bucket_path": f"{DATA_BUCKET_NAME}",
            "--target_bucket_path": f"{DATA_BUCKET_NAME}",
        },
    )

    dq_check_songs_job = GlueDataQualityRuleSetEvaluationRunOperator(
        task_id="dq_check_songs",
        role="<YOUR-GLUE-EXECUTION-ROLE>",
        rule_set_names=["songs_dq_ruleset"],
        number_of_workers=2,
        wait_for_completion=True,
        region_name="us-east-1",
        datasource={
            "GlueTable": {
                "TableName": "songs",
                "DatabaseName": "de_c4w4a2_transform_db",
            }
        },
    )

    task_dbt = DockerOperator(
        task_id="docker_dbt_command",
        image="dbt_custom_image",
        api_version="auto",
        auto_remove=True,
        docker_url="unix://var/run/docker.sock",
        command='bash -c "dbt --version && dbt debug --profiles-dir /usr/app/.dbt --project-dir /usr/app/dbt_modeling  && dbt run --profiles-dir /usr/app/.dbt --project-dir /usr/app/dbt_modeling"',
        mounts=[
            Mount(
                source="/docker_dbt/dbt_project/dbt_modeling/dbt_project.yml",
                target="/usr/app/dbt_modeling/dbt_project.yml",
                type="bind",
            ),
            Mount(
                source="/docker_dbt/dbt_project/dbt_modeling/models",
                target="/usr/app/dbt_modeling/models",
                type="bind",
            ),
            Mount(
                source="/docker_dbt/dbt_project/.dbt",
                target="/usr/app/.dbt",
                type="bind",
            ),
        ],
        network_mode="container:dbt",
    )

    end = DummyOperator(task_id="end")

    (
        start
        >> rds_extract_glue_job
        >> songs_transform_glue_job
        >> dq_check_songs_job
        >> task_dbt
        >> end
    )


deftunes_songs_pipeline()
