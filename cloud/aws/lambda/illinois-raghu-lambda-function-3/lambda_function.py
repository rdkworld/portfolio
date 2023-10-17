'''
Test Data
{
  "body": "value1",
  "key2": "value2",
  "key3": "value3"
}
'''
import json
import urllib3

def lambda_handler(event, context):
    # TODO implement
    #print(event['locationReportCriteria'])
    #data1 = event['body']
    #print(data1)
    
    data2 = json.loads(event['body']) 
    #print(data2)
    longitude = data2['locationReportCriteria']['riskAddress']['coordinates']['longitude']
    latitude = data2['locationReportCriteria']['riskAddress']['coordinates']['latitude']
    print(longitude)
    print(latitude)
    
    token_url = "https://farmersuwwdev.spatialkey.com/SpatialKeyFramework/api/v2/oauth.json?grant_type=urn:ietf:params:oauth:grant-type:jwt-bearer&assertion="
    headers2 = {"Content-Type": "application/json"}
    data2 = '{}'
    http = urllib3.PoolManager()
    r = http.request('POST', token_url, body=data2, headers=headers2)
    print(r)
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
