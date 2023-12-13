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

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
# Add psycopg2 or psycopg2-binary if you're interacting with PostgreSQL
RUN pip install --no-cache-dir psycopg2-binary

# Environment Variables for the First Database
ENV DB1_HOST demo.cpkkdlk5qmn8.eu-west-2.rds.amazonaws.com
ENV DB1_PORT 5432
ENV DB1_NAME pspdb
ENV DB1_USER postgres
ENV DB1_PASSWORD P!GJ79&!DjhlPsqP
ENV DB1_SCHEMA psp
ENV APP_BRANDS_STARTING_TABLE="app_brands"
ENV APP_BRANDS_STARTING_KEY_COLUMN="id"
ENV APP_BRANDS_KEY_VALUE="263"
ENV APP_BRANDS_EXCLUDED_TABLES="users"

# Environment Variables for the Second Database
ENV DB2_HOST demo.cpkkdlk5qmn8.eu-west-2.rds.amazonaws.com
ENV DB2_PORT 5432
ENV DB2_NAME impactpartners
ENV DB2_USER postgres
ENV DB2_PASSWORD P!GJ79&!DjhlPsqP
ENV DB2_SCHEMA partner
ENV TENANT_STARTING_TABLE="tenant"
ENV TENANT_STARTING_KEY_COLUMN="id"
ENV TENANT_KEY_VALUE="ae2b9779-ae3c-4c31-9a71-f5042e3df35d"
ENV TENANT_EXCLUDED_TABLES="wallet_platform_type,status,server_type,role,payment_period_definition,organization_unit,offer_type,object_field_type,object_field,marketing_tool_type,flyway_schema_history,calculation_type"

# Define argument for database choice (DB_CHOICE)
ARG DB_CHOICE=psp

# Set the script as the entry point
ENTRYPOINT ["/app/run_notebooks.sh"]

# Keep the container running (optional, remove if not needed)
CMD ["tail", "-f", "/dev/null"]