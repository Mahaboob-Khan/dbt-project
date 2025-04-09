{% macro limit_data_in_dev(date_column, dev_data_in_days=3) %}
{% if target.name == 'dev' %}
where {{ date_column }} >= dateadd('day', -{{ dev_data_in_days }}, current_date)
{% endif %}
{% endmacro %}