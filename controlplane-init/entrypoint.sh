#!/bin/bash
sed -i "s/{hostname}/cp-$HOSTNAME/g" /opt/installer/pm-cm-all.properties
sed -i "s/{hostname}/cp-$HOSTNAME/g" /opt/installer/add-to-local-cluster.properties
sed -i "s/{clustername}/cpcluster/g" /opt/installer/add-to-local-cluster.properties
/opt/akana/bin/jython.sh -Dorg.slf4j.simpleLogger.logFile=System.out -m akana.container --recipe /opt/akana/recipes/pm-cm-all.json --props /opt/installer/pm-cm-all.properties
/opt/akana/bin/jython.sh -Dorg.slf4j.simpleLogger.logFile=System.out -m akana.container --recipe /opt/akana/recipes/cm-tenant.json --props /opt/installer/cm-tenant.properties
ps -ef | grep [j]ava | awk '{print $2}' | xargs kill -9
sleep 10
# /opt/akana/bin/jython.sh -Dorg.slf4j.simpleLogger.logFile=System.out -m akana.container --recipe /opt/akana/recipes/add-to-local-cluster.json --props /opt/installer/add-to-local-cluster.properties
/opt/akana/bin/startup.sh cm-`echo $HOSTNAME`