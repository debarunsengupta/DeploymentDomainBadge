@isTest 
public class MMRAGStatusSchedularTest
{
    static testMethod void testMethodRed() 
    {
        
        Test.startTest();

            //MMRAGStatusSchedular m=new MMRAGStatusSchedular();
            //MMRAGStatusSchedular.execute();
            MMRAGStatusSchedular sh1 = new MMRAGStatusSchedular();      
           String sch = '0  00 1 3 * ?';
           system.schedule('Test',sch,sh1);
            
        Test.stopTest();
    }
    }