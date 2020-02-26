#!/bin/bash
CURRENT=$(date +%s)
sed -i "s/{hostname}/$HOSTNAME-$CURRENT/g" /opt/installer/add-to-local-cluster.properties
sed -i "s/{clustername}/$CLUSTERNAME/g" /opt/installer/add-to-local-cluster.properties
sed -i "s/{hostname}/$HOSTNAME-$CURRENT/g" /opt/installer/pm-cm-all.properties
sed -i "s/{db_host}/$DB_HOST/g" /opt/installer/pm-cm-all.properties
sed -i "s/{es_host}/$ES_HOST/g" /opt/installer/pm-cm-all.properties
cp /opt/installer/slf4j-simple-1.7.19.jar /opt/akana/lib/script/slf4j-simple-1.7.19.jar
/opt/akana/bin/jython.sh -Dorg.slf4j.simpleLogger.logFile=System.out -m akana.container --recipe /opt/akana/recipes/pm-cm-all-existing-db.json --props /opt/installer/pm-cm-all.properties
/opt/akana/bin/jython.sh -Dorg.slf4j.simpleLogger.logFile=System.out -m akana.container --recipe /opt/akana/recipes/add-to-local-cluster.json --props /opt/installer/add-to-local-cluster.properties
OLD_CONTAINER=$(curl  -H "Accept: application/json" -u administrator:password http://`echo $PM_HOST`:9900/rest/containers/?orgKey=uddi:soa.com:managementconfigurationbusinesskey -k | jq '.containers[].ContainerName' | grep "$HOSTNAME" | grep -v "$HOSTNAME-$CURRENT")
OLD_CONTAINER_NAME=$(echo $OLD_CONTAINER | awk '{gsub("\"",""); print}')
curl -X DELETE -u administrator:password http://`echo $PM_HOST`:9900/rest/containers/`echo $OLD_CONTAINER_NAME`
ps -ef | grep [j]ava | awk '{print $2}' | xargs kill -9
sleep 10
/opt/akana/bin/startup.sh `echo $HOSTNAME-$CURRENT`