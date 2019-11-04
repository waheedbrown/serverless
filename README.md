# serverless
Google Cloud Platform (GCP) serverless computing example

# Summary
This repository contains resources for tracking static IP changes on a Google Cloud Platform (GCP) virtual machine VM. When a static IP change is detected, the affected VM is migrated within the GCP environment. The practical purpose of this is to repair a VM that is failing to register its new static IP address.

# Installation
1. Login to your GCP environment
2. Open Cloud Shell terminal
3. Clone this repo into your Cloud Shell terminal
4. Execute the gcloud_script.sh shell script
5. Check that your Pub/Sub topic and Cloud Function were created correctly

# Usage
1. Create one or more VMs and several static IP addresses in GCP
2. Manually attach a different static IP to one of the VMs
3. This static IP change should generate a Stackdriver event, which is captured by the Cloud Function
4. The Cloud Function will perform a VM migration event, which in turn is tracked by Stackdriver
