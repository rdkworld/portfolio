resource "aws_glue_data_quality_ruleset" "songs_dq_ruleset" {
  name    = "songs_dq_ruleset"
  ruleset = "Rules = [ IsComplete \"track_id\", ColumnLength \"track_id\" = 18, IsComplete \"song_id\", ColumnLength \"song_id\" = 18, IsComplete \"artist_id\"]"
  target_table {
    database_name = var.catalog_database
    table_name    = "songs"
  }
}

resource "aws_glue_data_quality_ruleset" "sessions_dq_ruleset" {
  name    = "sessions_dq_ruleset"
  ruleset = "Rules = [<RULESET_HERE>]"
  target_table {
    database_name = var.catalog_database
    table_name    = "sessions"
  }
}

resource "aws_glue_data_quality_ruleset" "users_dq_ruleset" {
  name    = "users_dq_ruleset"
  ruleset = "Rules = [<RULESET_HERE>]"
  target_table {
    database_name = var.catalog_database
    table_name    = "users"
  }
}