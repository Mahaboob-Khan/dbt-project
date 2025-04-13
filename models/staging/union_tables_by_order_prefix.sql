{{
    config(
        required_tests = None
    )
}}


{{ union_tables_by_prefix(

      database='analytics',
      schema='analytics', 
      prefix='orders__'       
      )
}}