# Akana Docker Images

## Introduction

Pre-baked akana docker container images for deployment.

## Images

### Base
Base image sitting on-top of CentOS and include the necessary binaries and packages to run Akana docker container

### Control Plane (Init) 
Image for Akana's Policy Manager and Community Manager. This is meant for a fresh installaing as a new database will be created without any existing configs or policies. Additionally, a tenant will be created.

### Control Plane 
Run this image subsequently if you need to rebuilt your PM/CM. This will reuse the existing database with the current configs or policies

### ND (Network Director)
ND , are processing units meant to powered API transactions. Run this image to spin up a ND and also register a ND to a specific tenant.