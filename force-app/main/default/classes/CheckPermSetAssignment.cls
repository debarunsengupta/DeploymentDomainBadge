@RestResource(urlMapping='/checkPermSetAssignment/*')
global with sharing class CheckPermSetAssignment{            
    @HttpGet
    global static String doGet(){
        String retStr;
        RestRequest request = RestContext.request;
        String permSetName = RestContext.request.params.get('permSetName');
        String userName = RestContext.request.params.get('userName');
        List<PermissionSet> permSetList = [SELECT Id, Name from PermissionSet WHERE Label =: permSetName];
        if (permSetList.isEmpty()){
            return 'Sorry no such permission set available';
        }
        List<User> userList = [SELECT Id, Name FROM User WHERE FirstName =: userName OR
                               LastName =: userName OR Name =: userName];
        if (userList.isEmpty()){
            return 'Sorry no such user in the Org';
        }
        List<PermissionSetAssignment> permSetAsgnment = [SELECT Id FROM PermissionSetAssignment 
                                                        WHERE PermissionSet.Label =: permSetName 
                                                        AND AssigneeId =: userList[0].Id];
        if(!permSetAsgnment.isEmpty()){
            retStr = 'Yes' + ',' + ' this permission set is assigned to the user';
        }
        else{
            retStr = 'No' + ',' + ' this permission set is not assigned to the user';
        }
        return retStr;
    }
}