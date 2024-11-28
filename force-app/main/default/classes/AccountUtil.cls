global class AccountUtil

{
public static void AccountMap()
{
Map<string,Integer> m=new Map<string,Integer>();
List<Account > a=new List<Account>();
a=[select BillingCity from Account LIMIT 100];

for(Account c : a)
{
Integer b;
b=[select COUNT() from Account where BillingCity=:c.BillingCity];
m.put(c.BillingCity,b);
String formatted=String.format('City {0} belongs to Account{1}', new String[]{c.BillingCity, string.valueof(b)});
system.debug(formatted); 
    }
}
}