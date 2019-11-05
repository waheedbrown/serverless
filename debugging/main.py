from googleapiclient import discovery
import base64
import json

#def live_migrate_vm(data, context):
def test_migrate_vm(data, context):

    # Authenticate
    service = discovery.build('compute', 'beta')

    # Parse log
    #data_buffer = base64.b64decode(data['data'])
    #log_entry = json.loads(data_buffer)['resource']
    log_entry = data['resource']
    
    # Capture required variables
    project_id = log_entry['labels']['project_id']
    zone = log_entry['labels']['zone']
    instance_id = log_entry['labels']['instance_id']

    # Make VM migration API call
    request = service.instances().simulateMaintenanceEvent(project=project_id, zone=zone, instance=instance_id)
    response = request.execute()

    # Capture result
    print(response)