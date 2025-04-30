{% macro aws_s3_to_snowflake_copy_into(s3_bucket='dbt-tutorial-public', csv_file='jaffle_shop_customers.csv') %}

    {{ log("COPY INTO start", True) }}

    {% set copy_statement %}
    copy into raw.public.customers (id, first_name, last_name)
    from 's3://{{s3_bucket}}/{{csv_file}}'
    file_format = (
        type = 'CSV'
        field_delimiter = ','
        skip_header = 1
        )
    {% endset %}

    {% do run_query(copy_statement) %}

    {{ log("COPY INTO end", True) }}
{% endmacro %}