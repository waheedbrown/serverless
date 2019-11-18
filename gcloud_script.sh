# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

TOPIC_NAME=serverless-topic;
SINK_NAME=serverless-sink;
PROJECT_ID=wwb-assets-serverless;
REGION=us-central1;
ZONE=us-central1-a;
SUBNET=wwb-assets-serverless-subnet;

# Set Environment
gcloud config set project $PROJECT_ID;
gcloud config set compute/region $REGION;
gcloud config set compute/zone $ZONE;

# Create VMs
gcloud compute instances create instance-1 --subnet=$SUBNET;
gcloud compute instances create instance-2 --subnet=$SUBNET;

# Create Static IPs
gcloud compute addresses create static-ip-1 --region $REGION;
gcloud compute addresses create static-ip-2 --region $REGION;

# Create Pub/Sub Topic
gcloud pubsub topics create $TOPIC_NAME;

# Create Stackdriver Logging Sink
gcloud logging sinks create $SINK_NAME \
pubsub.googleapis.com/projects/$PROJECT_ID/topics/$TOPIC_NAME \
--log-filter "resource.type="gce_instance" AND ("addAccessConfig") AND (NOT protoPayload.request.name="*")" \
2> /tmp/sink_created.out;

LOGGING_SERVICE_ACCOUNT=$(awk -F '`' '{print $2}' /tmp/sink_created.out);

# Grant Pub/Sub Publisher role on the above topic, to the logging service account
gcloud projects add-iam-policy-binding $PROJECT_ID \
--member ${LOGGING_SERVICE_ACCOUNT} \
--role roles/pubsub.publisher;

# Create Cloud Function
# main.py must be in the directory where this gcloud command is run
gcloud --quiet functions deploy live_migrate_vm --runtime python37 \
--trigger-topic $TOPIC_NAME;
