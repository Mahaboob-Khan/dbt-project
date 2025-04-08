{# jinja basics #}

{%- set test_string = "Hello there! I am learning jinja" -%}

{{ test_string }}

{{ test_string[0:5] }}

{{ test_string * 2 }}

{{ test_string | title }}

{{ test_string | capitalize }}

{{ test_string | length }}

{{ test_string.split(' ') }}

{{ test_string | replace('jinja' , 'dbt') }}

{{ test_string | upper }}

{{ my_string | default("default string") }}

{{ my_string is defined }}

{{ my_string is none }}

{% set my_num = 210 -%}

{{ my_num }}

{% set my_skills = ['Python', 'SQL', 'Snowflake', 'dbt', 'Astronomer', 'github', 'Mainframe'] -%}

{{ my_skills[3] }}

{% for skill in my_skills %}
    {%- if loop.first -%}
        'first skill: '{{ loop.index }} {{ skill }}
    {%- elif loop.last -%}
        'last skill: '{{ loop.index }} {{ skill }}
    {%- else -%}
        'other skill: '{{ loop.index }} {{ skill }}
    {%- endif %}
{% endfor %}


{%- for skill in my_skills -%}
    {%- if skill == 'Snowflake' or skill == 'dbt' or skill == 'Astronomer' -%}
        {% set type = 'Trending' %}
    {%- elif skill in ['SQL', 'Power BI', 'Python', 'github'] -%}
        {% set type = 'Advanced' %}
    {%- else -%}
        {% set type = 'Legacy' %}
    {%- endif -%}

    The {{ type }} skill that I know is {{ skill }}
{% endfor %}


{% set skill_dictionary = {'emp_id': 12345, 'emp_name': 'Data Engineer', 'emp_skills': ['Snowflake', 'dbt', 'Astronomer', 'Power BI']} -%}
{{ skill_dictionary['emp_name'] }}
{{ skill_dictionary['emp_skills'][0] }}

{% if skill_dictionary is mapping %}
    {{ skill_dictionary.keys() }}
    {{ skill_dictionary.values() }}
    {{ skill_dictionary.items() }}
{% endif %}

{%- for key in skill_dictionary.keys() %}
    key - {{ key }} => value - {{ skill_dictionary[key] }}
    {% if skill_dictionary[key] is sequence and not skill_dictionary[key] is string %}
        {% for each_skill in skill_dictionary[key] %}
            {{ each_skill }}
        {% endfor %}
    {% endif %}
{%- endfor %}


{% set skill_dictionary = {
    'emp_id': 12345, 
    'emp_name': 'Data Engineer', 
    'emp_skills': ['Snowflake', 'dbt', 'Astronomer', 'Power BI'],
    'contact_info': {'primary': '1234567890', 'secondary': '0987654321' } } -%}

{% for key, val in skill_dictionary.items() %}
    {% if val is number %}
        number: {{ val }}
    {% elif val is string %} 
        string: {{ val }}
    {% elif val is mapping %}
        'Dictionary Data'
        {% for key2, val2 in val.items() %}
            {{ key2 }}: {{ val2 }}
        {% endfor %}
    {% elif val is sequence %}
        'List Data'
        {% for item in val %}
            {{ item }}
        {% endfor %}
    {% endif %}
{% endfor %}

{% set test_num = '546.55' %}
{{ test_num is string }}
{{ test_num is integer }}
{{ test_num is number }}

{{ test_num | int is string }}

{{ test_num | int is integer }}

{{ test_num | float is integer }}

{{ test_num | float }}

{{ test_num | int }}

{{ test_num | float | round(1) }}

{{ test_num | float | round(1, method='ceil') }}

{{ test_num | float | round(method='floor') }}

