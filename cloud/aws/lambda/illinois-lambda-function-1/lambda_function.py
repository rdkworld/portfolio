import json
import urllib3

def lambda_handler(event, context):
    #TODO implement
    
    data1 = json.loads(event['body']) 

    #Function
    def get_data(json_file, name):
        for dict in json_file['message']['state']:
            if json_file['message']['state'][dict]['name'] == name:
                return json_file['message']['state'][dict]['value']
    
    changedby = data1['message']['transaction']['user']['username']
    storyname = get_data(data1, "Name")
    storyno = get_data(data1, "FormattedID")
    lastupdatedate = get_data(data1, "LastUpdateDate")
    
    append = ''
    for r, record in enumerate(data1['message']['changes']):
        change_name = ''
        change_name = data1['message']['changes'][record]['display_name']
        if append != '':
            append = append + ', '
        append = append + change_name

    message = 'User story **' +  storyno + '** *' + storyname + '* ' + 'updated with changes to' \
              + ' **' + append + '** by ' + changedby + ' on ' + lastupdatedate
  
    test_accept_url = "https://api.ciscospark.com/v1/webhooks/incoming/Y2lzY29zcGFyazovL3VzL1dFQkhPT0svNjJlYzAzYjQtNzU0Ni00YmI1LWE2OWEtNWJlMjk2NDdhMmM2"
    headers2 = {"Content-Type": "application/json"}
    data2 = '{"markdown":"' + message + '"}'
    http = urllib3.PoolManager()
    r = http.request('POST', test_accept_url, body=data2, headers=headers2)

    return {
        'statusCode':200,
        'body': json.dumps('Hi There')
    }
