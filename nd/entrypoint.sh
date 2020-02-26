#!/bin/bash
CURRENT=$(date +%s)
sed -i "s/{hostname}/$HOSTNAME-$CURRENT/g" /opt/installer/nd-all.properties
sed -i "s/{pm_host}/$PM_HOST/g" /opt/installer/nd-all.properties
sed -i "s/{hostname}/$HOSTNAME-$CURRENT/g" /opt/installer/register-container.properties
sed -i "s/{pm_host}/$PM_HOST/g" /opt/installer/register-container.properties
sed -i "s/{tenantid}/$TENANTID/g" /opt/installer/register-container.properties
cp /opt/installer/slf4j-simple-1.7.19.jar /opt/akana/lib/script/slf4j-simple-1.7.19.jar
/opt/akana/bin/jython.sh -Dorg.slf4j.simpleLogger.logFile=System.out -m akana.container --recipe /opt/akana/recipes/nd-all.json --props /opt/installer/nd-all.properties
/opt/akana/bin/jython.sh -Dorg.slf4j.simpleLogger.logFile=System.out -m akana.container --recipe /opt/akana/recipes/register-container.json --props /opt/installer/register-container.properties
OLD_CONTAINER=$(curl  -H "Accept: application/json" -u administrator:password http://`echo $PM_HOST`:9900/rest/containers/?orgKey=uddi:soa.com:atmosphere:tenant:`echo $TENANTID` -k | jq '.containers[].ContainerName' | grep "$HOSTNAME" | grep -v "$HOSTNAME-$CURRENT")
OLD_CONTAINER_NAME=$(echo $OLD_CONTAINER | awk '{gsub("\"",""); print}')
curl -X DELETE -u administrator:password http://`echo $PM_HOST`:9900/rest/containers/`echo $OLD_CONTAINER_NAME`
ps -ef | grep [j]ava | awk '{print $2}' | xargs kill -9
sleep 10
/opt/akana/bin/startup.sh `echo $HOSTNAME-$CURRENT`