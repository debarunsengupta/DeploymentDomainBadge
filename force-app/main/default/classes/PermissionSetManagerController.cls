public with sharing class PermissionSetManagerController {

    private static Map<Id, PermissionSet> permissionSetMap {
        get {
            if (permissionSetMap == null) {
                permissionSetMap = new Map<Id, PermissionSet> ([SELECT Id, HasActivationRequired, IsCustom, IsOwnedByProfile, Label, LicenseId, License.Name, Name, ProfileId, Type 
                                                                FROM PermissionSet
                                                                WHERE IsOwnedByProfile = false
                                                                ORDER BY Label]);
            }
            return permissionSetMap;
        }
        set;
    }

    private static Map<Id, User> usersMap {
        get {
            if (usersMap == null) {
                usersMap = new Map<Id, User> ([SELECT Id, Name, Profile.UserLicense.Name FROM User WHERE IsActive = TRUE ORDER BY Name]);
            }
            return usersMap;
        }
        set;
    }

    @AuraEnabled
    public static List<User> getAllActiveUsers() {
        return usersMap.values();
    }

    @AuraEnabled
    public static List<PermissionSet> getAllPermissionSets(){
        return permissionSetMap.values();
    }

    @AuraEnabled
    public static List<PermissionSetAssignmentWrapper> getPermissionSetAssignments(String tabType, String recordId){
        List<PermissionSetAssignmentWrapper> assignmentWrapper = new List<PermissionSetAssignmentWrapper>();
        if (tabType == 'PermissionSet') {
            Map<Id, PermissionSetAssignment> userIdToPermissionSetAssignmentMap = new Map<Id, PermissionSetAssignment>();
            List<PermissionSetAssignment> permissionSetAssignments = [SELECT Id, AssigneeId, PermissionSetId FROM PermissionSetAssignment WHERE PermissionSetId = :recordId];
            for (PermissionSetAssignment assignment : permissionSetAssignments) {
                userIdToPermissionSetAssignmentMap.put(assignment.AssigneeId, assignment);
            }

            for (User userDetail : getAllActiveUsers()) {
                String assignmentId = '';
                if (userIdToPermissionSetAssignmentMap.containsKey(userDetail.Id)) {
                    assignmentId = userIdToPermissionSetAssignmentMap.get(userDetail.Id).Id;
                }
                assignmentWrapper.add(new PermissionSetAssignmentWrapper(
                    assignmentId,
                    userDetail,
                    permissionSetMap.get(recordId)
                ));
            }
        } else if (tabType == 'User') {
            Map<Id, PermissionSetAssignment> permissionSetIdToPermissionSetAssignmentMap = new Map<Id, PermissionSetAssignment>();
            List<PermissionSetAssignment> permissionSetAssignments = [SELECT Id, AssigneeId, PermissionSetId FROM PermissionSetAssignment WHERE AssigneeId = :recordId];
            for (PermissionSetAssignment assignment : permissionSetAssignments) {
                permissionSetIdToPermissionSetAssignmentMap.put(assignment.PermissionSetId, assignment);
            }

            for (PermissionSet permissionSetDetail : getAllPermissionSets()) {
                String assignmentId = '';
                if (permissionSetIdToPermissionSetAssignmentMap.containsKey(permissionSetDetail.Id)) {
                    assignmentId = permissionSetIdToPermissionSetAssignmentMap.get(permissionSetDetail.Id).Id;
                }
                assignmentWrapper.add(new PermissionSetAssignmentWrapper(
                    assignmentId,
                    usersMap.get(recordId),
                    permissionSetDetail
                ));
            }
        }

        return assignmentWrapper;
    }
    
    @AuraEnabled
    public static PermissionSetAssignmentResultWrapper saveChanges(List<PermissionSetAssignmentWrapper> assignmentWrapper) {
        Integer insertSucceses = 0;
        Integer insertFailures = 0;
        List<PermissionSetAssignmentResultWrapper.DmlError> insertErrors = new List<PermissionSetAssignmentResultWrapper.DmlError>();
        Integer deleteSucceses = 0;
        Integer deleteFailures = 0;
        List<PermissionSetAssignmentResultWrapper.DmlError> deleteErrors = new List<PermissionSetAssignmentResultWrapper.DmlError>();

        List<PermissionSetAssignment> permissionSetAssignmentsToInsert = new List<PermissionSetAssignment>();
        List<PermissionSetAssignment> permissionSetAssignmentsToDelete = new List<PermissionSetAssignment>();
        for (PermissionSetAssignmentWrapper assignmentWrapperRecord : assignmentWrapper) {
            if (assignmentWrapperRecord.existInDatabase != assignmentWrapperRecord.checked) {
                if (assignmentWrapperRecord.checked) {
                    permissionSetAssignmentsToInsert.add(new PermissionSetAssignment (
                        AssigneeId = assignmentWrapperRecord.assigneeId,
                        PermissionSetId = assignmentWrapperRecord.permissionSetId
                    ));
                } else {
                    permissionSetAssignmentsToDelete.add(new PermissionSetAssignment (
                        Id = assignmentWrapperRecord.assignmentId,
                        AssigneeId = assignmentWrapperRecord.assigneeId,
                        PermissionSetId = assignmentWrapperRecord.permissionSetId
                    ));
                }                
            }
        }

        //Insert new records
        if (!permissionSetAssignmentsToInsert.isEmpty()) {
            List<Database.SaveResult> insertResults = Database.insert(permissionSetAssignmentsToInsert, false);
            for (Integer i = 0; i < insertResults.size(); i++) {
                Database.SaveResult insertResult = insertResults.get(i);
                if (insertResult.isSuccess()) {
                    insertSucceses++;
                } else {
                    insertFailures++;
                    PermissionSetAssignment assignmenRecord = permissionSetAssignmentsToInsert.get(i);
                    insertErrors.add(new PermissionSetAssignmentResultWrapper.DmlError(
                        'Error : ' + insertResult.getErrors().get(0).getMessage() + '. Permission Set(' + permissionSetMap.get(assignmenRecord.PermissionSetId).Label + ') & User(' + usersMap.get(assignmenRecord.AssigneeId).Name + ')'
                    ));
                }
            }
        }

        //Delete old records
        if (!permissionSetAssignmentsToDelete.isEmpty()) {
            List<Database.DeleteResult> deleteResults = Database.delete(permissionSetAssignmentsToDelete, false);
            for (Integer i = 0; i < deleteResults.size(); i++) {
                Database.DeleteResult deleteResult = deleteResults.get(i);
                if (deleteResult.isSuccess()) {
                    deleteSucceses++;
                } else {
                    deleteFailures++;
                    PermissionSetAssignment assignmenRecord = permissionSetAssignmentsToDelete.get(i);
                    deleteErrors.add(new PermissionSetAssignmentResultWrapper.DmlError(
                        'Error : ' + deleteResult.getErrors().get(0).getMessage() + '. Permission Set(' + permissionSetMap.get(assignmenRecord.PermissionSetId).Label + ') & User(' + usersMap.get(assignmenRecord.AssigneeId).Name + ')'
                    ));
                }
            }
        }
        return new PermissionSetAssignmentResultWrapper(insertSucceses, insertFailures, insertErrors, deleteSucceses, deleteFailures, deleteErrors);
    }

}