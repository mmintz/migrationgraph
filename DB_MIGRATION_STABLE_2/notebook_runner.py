import nbformat
import os
from nbclient import NotebookClient

def run_notebook_and_print_output(path, env_vars=None):
    # Set environment variables if provided
    if env_vars:
        os.environ.update(env_vars)

    nb = nbformat.read(path, as_version=4)
    client = NotebookClient(nb, kernel_name='python3')
    client.execute()

    # Loop through each cell to find print outputs
    for cell in nb.cells:
        if cell.cell_type == 'code':
            for output in cell.outputs:
                if output.output_type == 'stream' and output.name == 'stdout':
                    print(output.text)

# Define environment variables for each database configuration
env_db1 = {
    "DB_HOST": os.getenv("DB1_HOST"),
    "DB_PORT": os.getenv("DB1_PORT"),
    "DB_NAME": os.getenv("DB1_NAME"),
    "DB_USER": os.getenv("DB1_USER"),
    "DB_PASSWORD": os.getenv("DB1_PASSWORD"),
    "DB_SCHEMA": os.getenv("DB1_SCHEMA")
}

env_db2 = {
    "DB_HOST": os.getenv("DB2_HOST"),
    "DB_PORT": os.getenv("DB2_PORT"),
    "DB_NAME": os.getenv("DB2_NAME"),
    "DB_USER": os.getenv("DB2_USER"),
    "DB_PASSWORD": os.getenv("DB2_PASSWORD"),
    "DB_SCHEMA": os.getenv("DB2_SCHEMA")
}

env_db_to = {
    "DB_HOST": os.getenv("DB_TO_HOST"),
    "DB_PORT": os.getenv("DB_TO_PORT"),
    "DB_NAME": os.getenv("DB_TO_NAME"),
    "DB_USER": os.getenv("DB_TO_USER"),
    "DB_PASSWORD": os.getenv("DB_TO_PASSWORD"),
    "DB_SCHEMA": os.getenv("DB_TO_SCHEMA")
}

# Execute notebooks with appropriate environment variables
if os.getenv("DB_CHOICE_FROM") == "db1":
    run_notebook_and_print_output("bfstraversal.ipynb", env_db1)
    run_notebook_and_print_output("queries_to_csv.ipynb", env_db1)
else:
    run_notebook_and_print_output("bfstraversal.ipynb", env_db2)
    run_notebook_and_print_output("queries_to_csv.ipynb", env_db2)
# The importing_final notebook uses a different set of environment variables
run_notebook_and_print_output("importing_final.ipynb", env_db_to)
run_notebook_and_print_output("all_tenants_sum.ipynb", env_db2)

    

