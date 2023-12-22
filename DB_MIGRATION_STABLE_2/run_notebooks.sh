#!/bin/bash
# ANSI color codes
RED='\033[1;31m'    # Bold Red
CYAN='\033[1;36m'   # Bold Cyan
YELLOW='\033[0;33m' # Normal Yellow (not bold to make it 'smaller')
GREEN='\033[1;32m' # Green color, bold
GREY='\033[1;30m'    # Bold Grey
NC='\033[0m' # No Color
# Convert Jupyter notebooks to Python scripts
echo -e "${CYAN}Docker: Initializing the Database Graph Representation and Data Migration Docker Container.\n"
echo -e "${GREY}[Docker: This Docker container is equipped with advanced scripts designed for dynamic and seamless interaction with various databases. It is highly configurable, ensuring easy adaptability to different database schemas. The core functionality includes creating state-of-the-art graph representations of database schemas, traversing relationships, copying relevant data, and importing it into a destination database. This process is optimized for efficiency and accuracy, making it a robust solution for database management and data migration tasks.]${NC}\n"
echo -e "${GREEN}Docker: MOST IMPORTANTLY IT IS NOT OPENSOURCED ! :) \n${NC}"
echo -e "${YELLOW}Docker: Converting jupyter notebooks to python scripts...${NC}"
# Trap CTRL+C (SIGINT) and exit the script
trap "echo -e '\n${RED}Script interrupted by user. Exiting...${NC}'; exit 1" SIGINT
jupyter nbconvert --to script bfstraversal_copy.ipynb
jupyter nbconvert --to script queries_to_csv.ipynb
jupyter nbconvert --to script importing_final.ipynb
jupyter nbconvert --to script rollback.ipynb
jupyter nbconvert --to script all_tenants_sum.ipynb

# Set initial environment variables based on DB_CHOICE
if [ "$DB_CHOICE_FROM" = "db1" ]; then
    export DB_HOST=$DB1_HOST_2 \
    DB_PORT=$DB1_PORT_2 \
    DB_NAME=$DB1_NAME_2 \
    DB_USER=$DB1_USER_2 \
    DB_PASSWORD=$DB1_PASSWORD_2 \
    DB_SCHEMA=$DB1_SCHEMA_2 \
    STARTING_TABLE=$APP_BRANDS_STARTING_TABLE_2 \
    STARTING_KEY_COLUMN=$APP_BRANDS_STARTING_KEY_COLUMN_2 \
    KEY_VALUE=$APP_BRANDS_KEY_VALUE_2 \
    EXCLUDED_TABLES=$APP_BRANDS_EXCLUDED_TABLES_2
else
    export DB_HOST=$DB2_HOST \
    DB_PORT=$DB2_PORT \
    DB_NAME=$DB2_NAME \
    DB_USER=$DB2_USER \
    DB_PASSWORD=$DB2_PASSWORD \
    DB_SCHEMA=$DB2_SCHEMA \
    STARTING_TABLE=$TENANT_STARTING_TABLE \
    STARTING_KEY_COLUMN=$TENANT_STARTING_KEY_COLUMN \
    KEY_VALUE=$TENANT_KEY_VALUE \
    EXCLUDED_TABLES=$TENANT_EXCLUDED_TABLES
fi

echo -e "${CYAN}Docker: Successfully converted all notebooks!!!\n${NC}"

# Echo environment variables for bfstraversal_copy.py
echo "Docker: Setting environment variables for Migration-Graph-DB"

# Optional: Echo the environment variables (be cautious with sensitive data)
echo -e "${RED}DB_HOST: $DB_HOST\nDB_PORT: $DB_PORT\nDB_NAME: $DB_NAME\nDB_USER: $DB_USER\nDB_SCHEMA: $DB_SCHEMA\n${NC}"
echo -e "${YELLOW}Docker: Be carefull . . .${NC}"
# Function to prompt user to continue
prompt_to_continue() {
    echo -ne "${YELLOW}Docker: Do you want to proceed with the next script? Press Enter to continue or Ctrl+C to exit:${NC} "
    read -r
}

ask_to_skip_script() {
    local script_name=$1 # $1 is the first argument to the function
    echo -ne "${YELLOW}Docker: Do you want to SKIP running $script_name? (yes/no): ${NC} "
    read -r user_input
    if [ "$user_input" = "yes" ]; then
        return 0 # 0 means 'true' in shell script
    else
        return 1 # 1 means 'false' in shell script
    fi
}

ask_to_skip_script "bfstraversal_copy.py"
if [ $? -eq 1 ]; then
    echo -e "${YELLOW}Docker: Running Migration-Graph-DB traversal...${NC}"
    python bfstraversal_copy.py
    echo -e "${CYAN}Docker: Successfully Generated Queries and Tables!!${NC}"
else
    echo -e "${RED}Docker: Skipping bfstraversal_copy.py as per user request.${NC}"
fi
# # Function to prompt user to continue
# echo -e "${GREEN}Docker: About to run bfstraversal_copy.py${NC}"
# prompt_to_continue
# echo -e "${YELLOW}Docker: Perfect! Proceeding to generate Queries and Tables...${NC}"


# Execute the Jupyter notebooks
# python bfstraversal_copy.py

echo -e "${CYAN}Docker: Successfully Generated Queries and Tables!!${NC}"

ask_to_skip_script "queries_to_csv.py"
if [ $? -eq 1 ]; then
    echo -e "${YELLOW}Docker: Running queries_to_csv.py...${NC}"
    python queries_to_csv.py
    echo -e "${CYAN}Docker: Succesfully Generated csv files for Tables and Queries!!!${NC}"
else
    echo -e "${RED}Docker: Skipping queries_to_csv.py as per user request.${NC}"
fi


# echo -e "${GREEN}Docker: About to run queries_to_csv.py${NC}"
# prompt_to_continue
# echo -e "${YELLOW}Docker: Perfect ! Proceeding to generate csv files for Tables and Queries...${NC}"



# Set environment variables for importing_final
echo -e "${YELLOW}Docker: Setting environment variables for importing_final.py AND rollback.py${NC}"
    export DB_HOST=$DB2_HOST_2 \
    DB_PORT=$DB2_PORT_2 \
    DB_NAME=$DB2_NAME_2 \
    DB_USER=$DB2_USER_2 \
    DB_PASSWORD=$DB2_PASSWORD_2 \
    DB_SCHEMA=$DB2_SCHEMA_2
#import to tenant

# Optional: Echo the environment variables (be cautious with sensitive data)
# Optional: Echo the environment variables for importing_final.py (be cautious with sensitive data)
echo -e "${RED}DB_HOST: $DB_HOST\nDB_PORT: $DB_PORT\nDB_NAME: $DB_NAME\nDB_USER: $DB_USER\nDB_SCHEMA: $DB_SCHEMA\n${NC}"
echo -e "${GREEN}Docker: About to run importing_final.py${NC}"

ask_to_skip_script "importing_final.py"
if [ $? -eq 1 ]; then
    echo -e "${YELLOW}Docker: Running importing_final.py...${NC}"
    python importing_final.py
    echo -e "${CYAN}Docker: Succesfully Imported csv files for on target DB!!!${NC}"
else
    echo -e "${RED}Docker: Skipping importing_final.py as per user request.${NC}"
fi

echo -e "${RED}DB_HOST: $DB_HOST\nDB_PORT: $DB_PORT\nDB_NAME: $DB_NAME\nDB_USER: $DB_USER\nDB_SCHEMA: $DB_SCHEMA\n{NC}"
echo -e "${RED}Docker: Be carefull . . .${NC}"
echo -e "${GREEN}Docker: About to run rollback.py${NC}"

ask_to_skip_script "rollback.py"
if [ $? -eq 1 ]; then
    echo -e "${YELLOW}Docker: Running rollback.py...${NC}"
    python rollback.py
    echo -e "${CYAN}Docker: Succesfully Roolled-back all related data from the target DB!!!${NC}"
else
    echo -e "${RED}Docker: Skipping rollback.py as per user request.${NC}"
fi



# prompt_to_continue
# echo -e "${YELLOW}Docker: Perfectoo!! Running importing_final.py...${NC}"
# python importing_final.py
# echo -e "${CYAN}Docker: importing_final.py finished!!!${NC}"
# echo -e "${GREEN}Docker: About to run all_tenants_sum.py${NC}"
prompt_to_continue
echo -e "${YELLOW}Docker: Perfectoo !! Running all_tenants_sum.py...${NC}"
python all_tenants_sum.py
echo -e "${CYAN}Docker: all_tenants_sum.py finished!!!${NC}"

# # Keep the script running (you can remove this line if you don't want the container to keep running after the script completes)
tail -f /dev/null