#!/bin/sh

# Check if java is available
which java

# Display config files for debugging purposes
cat config*

# Display the environment variables being used
echo $CW_EXPORTER_CONFIG_FILE $CW_EXPORTER_PORT

# List of variables to replace in the YAML files
VARIABLES_TO_REPLACE="
    APP_LOADBALANCERNAME_REGEX
    APP_LOADBALANCERTG_REGEX
    DMS_REPL_INSTANCES_REGEX
    DMS_REPL_TASK_REGEX
    ES_DOMAIN_CLIENT_ID
    ES_DOMAIN_NAME_REGEX
    LOADBALANCERNAME_REGEX
    RDS_DB_INSTANCES_REGEX
"

# Path to the configuration file
CONFIG_FILE=${CW_EXPORTER_CONFIG_FILE:-config}.yml

# Loop through the variables and replace them in the configuration file
for VAR in $VARIABLES_TO_REPLACE; do
    # Use eval to get the value of the variable stored in VAR and replace it in the config file
    eval VALUE=\$$VAR
    sed -i "s|\${$VAR}|$VALUE|g" $CONFIG_FILE
done

# Show the modified configuration file to verify the changes
echo "Modified configuration file:"
cat $CONFIG_FILE

# Run the CloudWatch exporter with the updated configuration
java -jar /cloudwatch_exporter.jar ${CW_EXPORTER_PORT:-9106} /$CONFIG_FILE

