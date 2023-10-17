import json
import urllib3

def lambda_handler(event, context):
    #TODO implement
    test_accept_url = "https://api.ciscospark.com/v1/webhooks/incoming/Y2lzY29zcGFyazovL3VzL1dFQkhPT0svNjJlYzAzYjQtNzU0Ni00YmI1LWE2OWEtNWJlMjk2NDdhMmM2"
    headers2 = {"Content-Type": "application/json"}
    data2 = '{"markdown":"Response after Rally was updated"}'
    http = urllib3.PoolManager()
    r = http.request('POST', test_accept_url, body=data2, headers=headers2)
    print('Printing Log')
    #print(event['body']["message"])
    data = json.loads(event['body'])
    #print(data['message']['object_id'])
    for r, record in enumerate(data['message']['changes']):
        print(record)
        print(r)
        print(data['message']['changes'][r])
        #print(data['message']['changes']['record'])

       #print(data['message']['changes'][r])
        #for i, idata in enumerate(record):
        #    print(idata)
       
    return {
        'statusCode':200,
        'body': json.dumps('Hi There')
    }
