public class DemoApex {
    
    public DemoApex(){
         String nameFirst= 'Rahul';
 String nameSecond= 'Sharma';
 system.debug('The value 1 is'+nameFirst);
 system.debug('The value 2 is'+nameSecond);
    }
 public String testingMethodOne(){
 system.debug('testing');
     integer a=12;
     integer b=17;
     string c='testing2';
     string abc= string.valueOf(a);
     testingMethodTwo(c);
     return abc;

 }
    public void testingMethodTwo(string var1){
        
        if(var1 =='testing'){
            system.debug('Match found');
            
        }
        else if(var1=='testing2')
        {
           system.debug('Match diff found'); 
        }
        else
        {
            system.debug('Match diff Not found'); 

        }
        
    }
    

}