TOPIC_NAME=serverless-topic;
SINK_NAME=serverless-sink;
PROJECT_ID=wwb-assets-serverless;

gcloud config set project $PROJECT_ID;

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
