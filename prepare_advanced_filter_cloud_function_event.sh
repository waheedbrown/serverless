# Run after the App Engine service account is created
# The App Engine service account is created when you create a Cloud Function
TEMP_FILE=$(mktemp);
sed 's/$PROJECT_ID/'"$PROJECT_ID"'/g' advanced_filter_cloud_function_event.txt > $TEMP_FILE;
cat $TEMP_FILE > advanced_filter_cloud_function_event.txt;
rm -f $TEMP_FILE;
