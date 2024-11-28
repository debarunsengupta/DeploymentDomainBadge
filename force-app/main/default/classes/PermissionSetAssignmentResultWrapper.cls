public with sharing class PermissionSetAssignmentResultWrapper {
    @AuraEnabled public Boolean isSuccess;
    @AuraEnabled public Integer totalInserts;
    @AuraEnabled public Integer insertSucceses;
    @AuraEnabled public Integer insertFailures;
    @AuraEnabled public List<DmlError> insertErrors;
    @AuraEnabled public Integer totalDeletes;
    @AuraEnabled public Integer deleteSucceses;
    @AuraEnabled public Integer deleteFailures;
    @AuraEnabled public List<DmlError> deleteErrors;
    
    public PermissionSetAssignmentResultWrapper(Integer insertSucceses, Integer insertFailures, List<DmlError> insertErrors, Integer deleteSucceses, Integer deleteFailures, List<DmlError> deleteErrors) {
        this.isSuccess = true;
        if (insertFailures > 0 || deleteFailures > 0) {
            this.isSuccess = false;
        }
        this.isSuccess = isSuccess;
        this.totalInserts = insertSucceses + insertFailures;
        this.insertSucceses = insertSucceses;
        this.insertFailures = insertFailures;
        this.insertErrors = insertErrors;
        this.totalDeletes = deleteSucceses + deleteFailures;
        this.deleteSucceses = deleteSucceses;
        this.deleteFailures = deleteFailures;
        this.deleteErrors = deleteErrors;
    }

    public with sharing class DmlError {
        @AuraEnabled public String errorMessage;
        public DmlError(String errorMessage) {
            this.errorMessage = errorMessage;
        }
    }
}