@RestResource(urlMapping='/crudINFO/*')
global with sharing class crudInfo{
   private
   static final Map<String,String> profileNameMappings = new Map<String,String>{'Admin' => 'System Administrator'};

    @HttpGet
    global static String doGet(){
    
        String retStr = '';
    
        Map<String,String> apiVsLabelMap = new Map<String,String>(); 
        Map<String,Schema.SObjectType> gd = Schema.getGlobalDescribe();
        System.debug(gd);
        System.debug(gd.values());
        for(Schema.SObjectType obj:gd.values()){
            apiVsLabelMap.put(obj.getDescribe().getLabel(),obj.getDescribe().getName());
        }
        
        String objLabel = RestContext.request.params.get('objectName');
        String profileName = RestContext.request.params.get('profileName');

        if(profileName == 'Admin')
        {
           profileName = profileNameMappings.get('Admin');
        }
        /*String s= objLabel;
        String target = s.substring(0,1);
        String replacement = target.toUpperCase();
        String s2 = s.replace(s.substring(0,1), replacement);*/
        System.debug(objLabel.capitalize());
        
        //system.debug = apiVsLabelMap.get('Account');
        
        String objApi = apiVsLabelMap.get(objLabel.capitalize());
        
        List<Profile> p = [SELECT Id FROM Profile WHERE Name =: profileName LIMIT 1];
        
        if(!p.isEmpty() && objApi!=null){
            List<ObjectPermissions> objPerms = [SELECT PermissionsRead,PermissionsCreate,PermissionsEdit,PermissionsDelete 
                                                FROM ObjectPermissions 
                                                WHERE SObjectType =: objApi AND parent.profile.name =: profileName];
            retStr = 'CRUD permission for ' + objLabel + ' on ' + profileName + ' is ' + 'Create - ' + objPerms[0].PermissionsCreate + ',' + 'Read - ' + objPerms[0].PermissionsRead + ',' + 'Edit - ' + objPerms[0].PermissionsEdit + 
                           + ' and Delete - ' + objPerms[0].PermissionsDelete + ' respectively.';
        }
        
        
        
        if(p.isEmpty()){
            retStr = 'There is no profile named ' + profileName + '. Are you sure this is the correct profile name?';
        }
        else if(objApi == null){
            retStr = 'There is no object named ' + objLabel + '. Are you sure this is the correct object name?';
        }
        else if(objApi == null && p.isEmpty()){
            retStr = 'There is no object and no profile named ' +  objLabel + ' and ' + profileName + ' respectively.';
        }
        
        System.debug(retStr);
                           
        return retStr; 
    }
}