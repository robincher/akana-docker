#!/bin/bash
sed -i "s/{hostname}/nd-$HOSTNAME/g" /opt/installer/nd-all.properties
sed -i "s/{hostname}/nd-$HOSTNAME/g" /opt/installer/register-container.properties
/opt/akana/bin/jython.sh -Dorg.slf4j.simpleLogger.logFile=System.out -m akana.container --recipe /opt/akana/recipes/nd-all.json --props /opt/installer/nd-all.properties
ps -ef | grep [j]ava | awk '{print $2}' | xargs kill -9
sleep 10
/opt/akana/bin/jython.sh -Dorg.slf4j.simpleLogger.logFile=System.out -m akana.container --recipe /opt/akana/recipes/register-container.json --props /opt/installer/register-container.properties
/opt/akana/bin/startup.sh nd-`echo $HOSTNAME`