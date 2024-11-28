@RestResource(urlMapping='/assignPermSet/*')
global with sharing class AssignPermSet{            
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
            return 'This permission set is already assigned to the User';
        }
        else{
            PermissionSetAssignment permAssignment = new PermissionSetAssignment();
            permAssignment.PermissionSetId = permSetList[0].Id;
            permAssignment.AssigneeId = userList[0].Id;
            Database.SaveResult sr =  Database.insert(permAssignment, false);
            if (!sr.isSuccess()){
                retStr = sr.getErrors().get(0).getMessage();
            }else{
                retStr = 'Permission Set Successfully Assigned';
            }
        }
        return retStr;
    }
}