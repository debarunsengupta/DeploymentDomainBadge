Public class AccountFetch{

@AuraEnabled(cacheable=true)
public static List<Account> accountRetrieve(string rating){

if(rating==''){
return [select id,Name,industry, Rating from Account limit 5];
}
return [select id,Name,industry, Rating from Account where Rating =:rating limit 5];

}
}