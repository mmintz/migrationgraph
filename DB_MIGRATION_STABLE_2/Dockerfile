# Use an official Jupyter notebook image as a parent image
FROM jupyter/base-notebook

# Set the working directory in the container
WORKDIR /app

# Install PostgreSQL client
USER root
RUN apt-get update && apt-get install -y postgresql-client && rm -rf /var/lib/apt/lists/*

# Copy the script into the container and make it executable
COPY run_notebooks.sh /app/run_notebooks.sh
RUN chmod +x /app/run_notebooks.sh

# Switch back to the jovyan user for Jupyter
USER jovyan

# Create directories for outputs and exports
RUN mkdir -p /app/outputs /app/exports

#RUN echo "YOUR_TEMPLATE_CONTENT_HERE" > /app/output_only.tpl
# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
# Add psycopg2 or psycopg2-binary if you're interacting with PostgreSQL
RUN pip install --no-cache-dir psycopg2-binary
RUN pip install pandas sqlalchemy networkx matplotlib psycopg2-binary
# Environment Variables for the First Database
ENV DB1_HOST demo.cpkkdlk5qmn8.eu-west-2.rds.amazonaws.com
ENV DB1_PORT '5432'
ENV DB1_NAME pspdb
ENV DB1_USER postgres
ENV DB1_PASSWORD P!GJ79&!DjhlPsqP
ENV DB1_SCHEMA psp
ENV APP_BRANDS_STARTING_TABLE="app_brands"
ENV APP_BRANDS_STARTING_KEY_COLUMN="id"
ENV APP_BRANDS_KEY_VALUE="263"
ENV APP_BRANDS_EXCLUDED_TABLES="users"

# Environment Variables for the Second Database
ENV DB2_HOST postgresql-server-partner-production.postgres.database.azure.com
ENV DB2_PORT '5432'
ENV DB2_NAME impactpartners
ENV DB2_USER partnerproductionpsqlmanager@postgresql-server-partner-production
ENV DB2_PASSWORD uH1fSuHsnUnF44GD?5t/6zOQ
ENV DB2_SCHEMA partner
ENV TENANT_STARTING_TABLE="tenant"
ENV TENANT_STARTING_KEY_COLUMN="id"
ENV TENANT_KEY_VALUE="1c05648d-07f9-48e4-a1c7-6807ba99046d"
ENV TENANT_EXCLUDED_TABLES="object_field_relation,object,deposit_type,wallet_platform_type,status,server_type,role,payment_period_definition,organization_unit,offer_type,object_field_type,object_field,marketing_tool_type,flyway_schema_history,calculation_type"

# Environment Variables for the Second Database
ENV DB_TO_HOST demo.cpkkdlk5qmn8.eu-west-2.rds.amazonaws.com
ENV DB_TO_PORT '5432'
ENV DB_TO_NAME impactpartnerstest
ENV DB_TO_USER postgres
ENV DB_TO_PASSWORD P!GJ79&!DjhlPsqP
ENV DB_TO_SCHEMA partner

#psp
ENV DB1_HOST_2 psp-temp-prod.postgres.database.azure.com
ENV DB1_PORT_2 '5432'
ENV DB1_NAME_2 pspdb
ENV DB1_USER_2 psqlmanagerprodnortheurope02
ENV DB1_PASSWORD_2 'Y!pX$rTXCdEeQd9I>e$5w(>e_dDs!U%%'
ENV DB1_SCHEMA_2 psp
ENV APP_BRANDS_STARTING_TABLE_2="app_brands"
ENV APP_BRANDS_STARTING_KEY_COLUMN_2="id"
ENV APP_BRANDS_KEY_VALUE_2="205"
ENV APP_BRANDS_EXCLUDED_TABLES_2="users"

# ENV DB2_HOST_2 demo-2.cpkkdlk5qmn8.eu-west-2.rds.amazonaws.com
# ENV DB2_PORT_2 '5432'
# ENV DB2_NAME_2 impactpartnerstest
# ENV DB2_USER_2 postgres
# ENV DB2_PASSWORD_2 'P!GJ79&!DjhlPsqP'
# ENV DB2_SCHEMA_2 partner
# ENV TENANT_STARTING_TABLE="tenant"
# ENV TENANT_STARTING_KEY_COLUMN="id"
# ENV TENANT_KEY_VALUE="1c05648d-07f9-48e4-a1c7-6807ba99046d"
# ENV TENANT_EXCLUDED_TABLES="object_field_relation,object,deposit_type,wallet_platform_type,status,server_type,role,payment_period_definition,organization_unit,offer_type,object_field_type,object_field,marketing_tool_type,flyway_schema_history,calculation_type"
#import to tenant


# ENV DB2_HOST_2 postgresql-25c5c830-o62020061.database.cloud.ovh.net
# ENV DB2_PORT_2 '20184'
# ENV DB2_NAME_2 partners
# ENV DB2_USER_2 avnadmin
# ENV DB2_PASSWORD_2 'A7cu4l0qHimD2YK6Fpgd'
# ENV DB2_SCHEMA_2 partner
# ENV TENANT_STARTING_TABLE="tenant"
# ENV TENANT_STARTING_KEY_COLUMN="id"
# ENV TENANT_KEY_VALUE="1c05648d-07f9-48e4-a1c7-6807ba99046d"
# ENV TENANT_EXCLUDED_TABLES="object_field_relation,object,deposit_type,wallet_platform_type,status,server_type,role,payment_period_definition,organization_unit,offer_type,object_field_type,object_field,marketing_tool_type,flyway_schema_history,calculation_type"



# ENV DB2_HOST_2 partner-prod-temp.postgres.database.azure.com
# ENV DB2_PORT_2 '5432'
# ENV DB2_NAME_2 impactpartners
# ENV DB2_USER_2 partnerproductionpsqlmanager@partner-prod-temp
# ENV DB2_PASSWORD_2 uH1fSuHsnUnF44GD?5t/6zOQ
# ENV DB2_SCHEMA_2 partner
# ENV TENANT_STARTING_TABLE="tenant"
# ENV TENANT_STARTING_KEY_COLUMN="id"
# ENV TENANT_KEY_VALUE="1c05648d-07f9-48e4-a1c7-6807ba99046d"
# ENV TENANT_EXCLUDED_TABLES="object_field_relation,object,deposit_type,wallet_platform_type,status,server_type,role,payment_period_definition,organization_unit,offer_type,object_field_type,object_field,marketing_tool_type,flyway_schema_history,calculation_type"

# ENV DB2_HOST_2 psp-temp-prod.postgres.database.azure.com
# ENV DB2_PORT_2 '5432'
# ENV DB2_NAME_2 partners
# ENV DB2_USER_2 psqlmanagerprodnortheurope02
# ENV DB2_PASSWORD_2 'Y!pX$rTXCdEeQd9I>e$5w(>e_dDs!U%%'
# ENV DB2_SCHEMA_2 partner
# ENV TENANT_STARTING_TABLE="tenant"
# ENV TENANT_STARTING_KEY_COLUMN="id"
# ENV TENANT_KEY_VALUE="1c05648d-07f9-48e4-a1c7-6807ba99046d"
# ENV TENANT_EXCLUDED_TABLES="object_field_relation,object,deposit_type,wallet_platform_type,status,server_type,role,payment_period_definition,organization_unit,offer_type,object_field_type,object_field,marketing_tool_type,flyway_schema_history,calculation_type"

ENV DB2_HOST_2 postgresql-25c5c830-o62020061.database.cloud.ovh.net
ENV DB2_PORT_2 '20184'
ENV DB2_NAME_2 partners
ENV DB2_USER_2 avnadmin
ENV DB2_PASSWORD_2 'A7cu4l0qHimD2YK6Fpgd'
ENV DB2_SCHEMA_2 partner
ENV TENANT_STARTING_TABLE="tenant"
ENV TENANT_STARTING_KEY_COLUMN="id"
ENV TENANT_KEY_VALUE="1c05648d-07f9-48e4-a1c7-6807ba99046d"
ENV TENANT_EXCLUDED_TABLES="object_field_relation,object,deposit_type,wallet_platform_type,status,server_type,role,payment_period_definition,organization_unit,offer_type,object_field_type,object_field,marketing_tool_type,flyway_schema_history,calculation_type"



#http://demo-2.cpkkdlk5qmn8.eu-west-2.rds.amazonaws.com
#5432
#usr name ->postgres
#pass P!GJ79&!DjhlPsqP


# Define argument for database choice (DB_CHOICE)
ARG DB_CHOICE=db1
ENV DB_CHOICE_FROM=${DB_CHOICE}
# Set the script as the entry point
ENTRYPOINT ["/app/run_notebooks.sh"]

# Keep the container running (optional, remove if not needed)
CMD ["tail", "-f", "/dev/null"]