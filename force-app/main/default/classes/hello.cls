public class hello
{
public void uploadPDF(String binaryPdfString, String key, String secret){
        String Date1 = Datetime.now().formatGMT('EEE,   dd MMM yyyy HH:mm:ss z');
        String bucketname = 'rtawebserviceip';
        String method = 'PUT';
        String filename = 'FileName';
        HttpRequest req = new HttpRequest();
        req.setMethod(method);
        req.setHeader('Host','s3-us-east-1.amazonaws.com');
        req.setEndpoint('https://s3-us-east-1.amazonaws.com' + '/'+ bucketname + '/' + filename);
        req.setHeader('Content-Length', string.valueOf(binaryPdfString.length()));
        req.setHeader('Content-Encoding', 'base64');
        req.setHeader('Content-Type', 'pdf');
        req.setHeader('Date', Date1);

        //get signature string
        String stringToSign = 'PUT\n\n\n'+Date1+'\n\n/'+bucketname+'/'+filename;
        String signed = createSignature(stringToSign,secret);
        String authHeader = 'AWS' + ' ' + key + ':' + signed;
        req.setHeader('Authorization',authHeader);
        Blob PDF = EncodingUtil.base64Decode(binaryPdfString);
        req.setBodyAsBlob(PDF);
        Http http = new Http();

        try {
            //Execute web service call
            HTTPResponse res = http.send(req);
            System.debug('RESPONSE STRING: ' + res.toString());
            System.debug('RESPONSE STATUS: '+res.getStatus());
            System.debug('STATUS_CODE: '+res.getStatusCode());

        } catch(System.CalloutException e) {
            system.debug('AWS Service Callout Exception: ' + e.getMessage());
        }

}

public string createSignature(string canonicalBuffer,String secret){
        string sig;
        Blob mac = Crypto.generateMac('HMACSHA1', blob.valueof(canonicalBuffer),blob.valueof(secret));
        sig = EncodingUtil.base64Encode(mac);

        return sig;

}
}