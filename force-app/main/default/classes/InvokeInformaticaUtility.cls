Public class InvokeInformaticaUtility
{
@AuraEnabled
public static Response InvokeInformaticautil(string recid)
{

Response r=InformaticaUtility.InvokeInformaticaJob(recid);
return r;
}
@AuraEnabled
public static Account RecordEdited(string recid)
{

Account acc=[select id,Record_Processed__c,Record_Changed__c from Account where id=:recid];
    return acc;
}
}