global class OppurtunityUtil  

{
public static void customCalculation()
{
List<Opportunity> a=new List<Opportunity>();
a=[select Amount from Opportunity LIMIT 100];

for(Opportunity o : a)
{

if(o.Amount < 1000)
{
o.Amount=o.Amount+(o.Amount*0.3);
update o;     

}
}
}
}