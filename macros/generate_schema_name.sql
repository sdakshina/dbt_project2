{%macro generate_schema_name(custom_schema_name,node)%}
{%set default_schmea=target.schema%}
{%if custom_schema_name is none%}
{{default_schmea}}
{%else%}
{{custom_schema_name|trim}}
{%endif%}
{%endmacro%}