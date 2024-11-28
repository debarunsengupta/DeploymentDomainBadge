//custom exception class
global class futureCreateErrorLog {

public static void createErrorRecord(string exceptionMessage){
         myError__c newErrorRecord = new myError__c();
         newErrorRecord.Details__c = exceptionMessage;
        Database.insert(newErrorRecord, false); //provide more flexibility to insert dml method
       //  insert newErrorRecord;
         }
    }