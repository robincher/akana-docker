#!/bin/bash
sed -i "s/{hostname}/cm-$HOSTNAME/g" /opt/installer/pm-cm-all.properties
sed -i "s/{hostname}/cm-$HOSTNAME/g" /opt/installer/add-to-local-cluster.properties
sed -i "s/{clustername}/cmcluster/g" /opt/installer/add-to-local-cluster.properties
/opt/akana/bin/jython.sh -Dorg.slf4j.simpleLogger.logFile=System.out -m akana.container --recipe /opt/akana/recipes/pm-cm-all-existing-db.json --props /opt/installer/pm-cm-all.properties
ps -ef | grep [j]ava | awk '{print $2}' | xargs kill -9
sleep 10
# /opt/akana/bin/jython.sh -Dorg.slf4j.simpleLogger.logFile=System.out -m akana.container --recipe /opt/akana/recipes/add-to-local-cluster.json --props /opt/installer/add-to-local-cluster.properties
/opt/akana/bin/startup.sh cm-`echo $HOSTNAME`