# Akana Docker Images

## Introduction

Pre-baked akana docker container images for deployment.

## akana
Check list prior to running the images
1. MySql DB
2. ElasticSearch

## Images

### Base
Base image sitting on-top of CentOS and include the necessary binaries and packages to run Akana docker container

### Control Plane (Init) 
Image for Akana's Policy Manager and Community Manager. This is meant for a fresh installaing as a new database will be created without any existing configs or policies. Additionally, a tenant will be created.

```docker run -d -p 9900:9900 -e CLUSTERNAME=<clustername> -e DOMAINNAME=<domainname> -e ES_HOST=<es_host_url> -e DB_HOST=<db_host_url> ronaldkan/akana-controlplane-init:latest```

### Control Plane 
Run this image subsequently if you need to rebuilt your PM/CM. This will reuse the existing database with the current configs or policies

```docker run -d -p 9900:9900 -e CLUSTERNAME=<clustername> -e DOMAINNAME=<domainname> -e ES_HOST=<es_host_url> -e DB_HOST=<db_host_url> ronaldkan/akana-controlplane:latest```

### ND (Network Director)
ND , are processing units meant to powered API transactions. Run this image to spin up a ND and also register a ND to a specific tenant.

```docker run -d -p 9991:9991 -e TENANTID=<tenant_id> -e PM_HOST=<pm_host_url> ronaldkan/akana-nd:latest```
