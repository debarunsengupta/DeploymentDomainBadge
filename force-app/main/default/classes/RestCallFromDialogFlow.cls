@RestResource(urlMapping='/DialogFlow')
global class RestCallFromDialogFlow
{
@HTTPPost
global static string createRecords()
{
system.debug('Invoked');
string req=Restcontext.request.requestbody.tostring();
return '{"fulfillmentText":"Success", "fulfillmentMessages": [{"simpleResponses": {"simpleResponses": [{"textToSpeech": "response text","displayText": "response text"}]}}]';
}


}