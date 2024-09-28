SELECT
date_part('year', fs.session_start_time) as session_year,
da.artist_name,
SUM(fs.price) as total_sales
FROM {{var("target_schema")}}.fact_session fs
LEFT JOIN {{var("target_schema")}}.dim_artists da
ON fs.artist_id = da.artist_id
GROUP BY 1,2