public with sharing class testingowd
{
  @AuraEnabled
  public static void testing()
  {
  try
  {
     List<Account> acc=[select id from Account where id='0010K00002QcNGi' with security_enforced];
     system.debug('acc-->'+acc);
  }
  catch(exception ex)
  {
       system.debug('ex-->'+ex.getmessage());

  }
  }

}