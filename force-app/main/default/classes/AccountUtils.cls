public class AccountUtils 
{

public static List<Account> accountsByState(string state)
{

return[select id,Name from Account where BillingState=:state];

}


}