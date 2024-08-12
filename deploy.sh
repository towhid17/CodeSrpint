#!/bin/bash

TOMCAT_HOME="/usr/local/tomcat9"

# Check if Tomcat is running
if ps -ef | grep -v grep | grep "$TOMCAT_HOME/bin/bootstrap.jar" > /dev/null; then
    echo "Stopping Tomcat..."
    if sudo $TOMCAT_HOME/bin/shutdown.sh; then
        echo "Tomcat stopped."
    else
        echo "Failed to stop Tomcat."
        exit 1
    fi
else
    echo "Tomcat is not running."
fi

gradle clean build

for war_file in build/libs/*.war; do
    app_name=$(basename "$war_file" .war)
    echo "Deploying $app_name..."

    if sudo rm -f $TOMCAT_HOME/webapps/$app_name.war &&
       sudo rm -rf $TOMCAT_HOME/webapps/$app_name/ &&
       sudo cp $war_file $TOMCAT_HOME/webapps/; then
        echo "Deployment of $app_name successful."
    else
        echo "Deployment of $app_name failed."
        exit 1
    fi
done

echo "Starting Tomcat..."
if sudo $TOMCAT_HOME/bin/startup.sh; then
    echo "Running..."
else
    echo "Failed to start Tomcat."
    exit 1
fi

