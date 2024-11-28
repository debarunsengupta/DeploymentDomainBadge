global with sharing class PermissionSetAssignmentWrapper {
    @AuraEnabled public String assignmentId {get; set;}
    @AuraEnabled public String assigneeId {get; set;}
    @AuraEnabled public String assigneeName {get; set;}
    @AuraEnabled public String assigneeUserLicenseName {get; set;}
    @AuraEnabled public String permissionSetId {get; set;}
    @AuraEnabled public String permissionSetName {get; set;}
    @AuraEnabled public String permissionSetLicenseName {get; set;}
    @AuraEnabled public Boolean existInDatabase {get; set;}
    @AuraEnabled public Boolean checked {get; set;}

    public PermissionSetAssignmentWrapper(){
    }

    public PermissionSetAssignmentWrapper(String assignmentId, User userDetails, PermissionSet permissionSeDetail) {
        this.assignmentId = assignmentId;
        this.assigneeId = userDetails.Id;
        this.assigneeName = userDetails.Name;
        this.assigneeUserLicenseName = userDetails.Profile.UserLicense.Name;
        
        this.permissionSetId = permissionSeDetail.Id;
        this.permissionSetName = permissionSeDetail.Label;
        this.permissionSetLicenseName = permissionSeDetail.License.Name;

        if (String.isNotBlank(assignmentId)) {
            this.existInDatabase = true;
        } else {
            this.existInDatabase = false;
        }
        this.checked = this.existInDatabase;
    }
}