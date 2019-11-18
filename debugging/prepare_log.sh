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

PROJECT_ID=wwb-assets-serverless;
ZONE=us-central1-a;
REGION=us-central1;
SUBNET=wwb-assets-serverless-subnet;
INSTANCE_ID=5608139878076087787;

sed 's/$PROJECT_ID/'"$PROJECT_ID"'/g;s/$ZONE/'"$ZONE"'/g;s/$REGION/'"$REGION"'/g;s/$SUBNET/'"$SUBNET"'/g;s/$INSTANCE_ID/'"$INSTANCE_ID"'/g' sample_log.json > prepared_log.json;
