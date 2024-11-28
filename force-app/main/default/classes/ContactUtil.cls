global class ContactUtil

{
public static void swapNames()
{
List<Contact> a=new List<Contact>();
a=[select FirstName,LastName from Contact where SystemModStamp= LAST_N_DAYS:7 ORDER BY SystemModStamp DESC];

for(Contact c : a)
{
string tempVariable=c.FirstName;
c.FirstName=c.LastName;
c.LastName=tempVariable;
update c;
    

}
}
}