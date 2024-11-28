public class callbyref
{
public static void abc()
{
string s=null;
string b=null;

  List<string> arrLst=new List<string>();
  arrLst.add('1');
  arrLst.add('2');
  abc1(arrLst);
  system.debug('aaa'+arrLst);
  }
  
public static void abc1(List<string>arrLst)
{
arrLst=null;
}

}