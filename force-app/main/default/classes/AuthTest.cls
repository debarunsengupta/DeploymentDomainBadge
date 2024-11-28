global with sharing class AuthTest extends Auth.AuthProviderPluginClass {

    private String customMetadataTypeApiName = 'Integration_EndPoint_Setting_Details__mdt';
    public  String redirectUrl; 
    private String key;
    private String secret;
    private String authUrl;  
    private String accessTokenUrl; 
    private String userInfoUrl; 
    private String scope;
    
    global String getCustomMetadataType(){
        return customMetadataTypeApiName;
    }
    
    /* Step 1 */
    global PageReference initiate(Map<string,string> authProviderConfiguration, String stateToPropagate) { 
            system.debug('1');
    
        /*key         = authProviderConfiguration.get('Consumer_Key__c');
        authUrl     = authProviderConfiguration.get('Auth_URL__c');
        scope       = authProviderConfiguration.get('Scope__c');
        redirectUrl = authProviderConfiguration.get('Callback_URL__c');
        String urlToRedirect = authUrl+'?client_id='+key+'&redirect_uri='+redirectUrl+'&scope='+scope+
                               '&state='+stateToPropagate+'&allow_signup=false';*/
                               
        PageReference pageRef = null;
        return pageRef; 
    } 
    
    /* Step 2 */
    global Auth.AuthProviderTokenResponse handleCallback(Map<string,string> authProviderConfiguration, Auth.AuthProviderCallbackState state ) { 
        
            system.debug('2');
        
        return new Auth.AuthProviderTokenResponse('AuthTest', null, 'refreshToken', null); 
        
    } 
   
               
    global Auth.UserData getUserInfo(Map<string,string> authProviderConfiguration, Auth.AuthProviderTokenResponse response) { 
        
        system.debug('3');
        Auth.UserData userdata = new Auth.UserData(null,null,null,null,null,null,null,null,null,null,null);
        
        //System.debug('### userInfo '+userInfo);
        
        /*
            UserData(String identifier, String firstName, String lastName, String fullName, String email, 
                     String link, String userName, String locale, String provider, String siteLoginUrl, 
                     Map<String,String> attributeMap
            )
        */
        
        return userdata;
    } 
    }