PROJECT_ID=wwb-assets-serverless;
ZONE=us-central1-a;
REGION=us-central1;
SUBNET=wwb-assets-serverless-subnet;
INSTANCE_ID=5608139878076087787;

sed 's/$PROJECT_ID/'"$PROJECT_ID"'/g;s/$ZONE/'"$ZONE"'/g;s/$REGION/'"$REGION"'/g;s/$SUBNET/'"$SUBNET"'/g;s/$INSTANCE_ID/'"$INSTANCE_ID"'/g' sample_log.json > prepared_log.json;
