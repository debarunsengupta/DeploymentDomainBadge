@RestResource(urlMapping='/AccountService/*')
global class AccountService {

 @HttpGet
 global static List<Account> getAccounts() {
   List<Account> Accounts = [SELECT Id,Name from Account LIMIT 10];
   return Accounts;
 }

 @HttpPost 
 global static String createNewAccount(String Name) {
   Account a = new Account();
   a.Name = Name;
   insert a;

   return 'Account Created';
 }

 @HttpDelete
 global static String deleteAccountById() {
 
   RestRequest req = RestContext.request;
   String Id = req.params.get('Id');

   List<Account> a = [ Select ID from Account where Id= :Id];

   delete a;

   return 'Account Deleted';
 }

 @HttpPut
 global static String updateAccount(String Id, String NewName) {
   Account a = [ Select ID, Name from Account where Id= :Id];
   a.Name = NewName;
   update a;

   return 'Account Updated';
 }
}