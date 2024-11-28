public class testing
{

public static void testnow()
{
contact con;
List<contact > a=new List<contact >();
List<Account> a5=new List<Account>();
con=[select id,name,Account.SLASerialNumber__c from contact where id='0032800000YWELT'];

con.Account.SLASerialNumber__c='Hi5';
a5.add(con.Account);
//update con.Account;
update a5;
}

}