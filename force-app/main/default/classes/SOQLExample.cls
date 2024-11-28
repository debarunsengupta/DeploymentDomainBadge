public class SOQLExample {
    
    public static void testing(){

    
    Savepoint sp = Database.setSavepoint();
Account a = new Account();
a.Name='1';
a.AccountNumber = '2';
insert a;
          
        Contact c=new contact(accountid=a.id);
      
/*Contact c=new Contact();
 c.AccountId=[select id from ACCOUNT where id=:a.id].id;*/

try
{
    insert c;
}
catch(Exception e)
{
    Database.RollBack(sp);
}

    }
}