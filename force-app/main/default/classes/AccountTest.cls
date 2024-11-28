public class AccountTest{

public static void Sample1(List<Account> acc){
for(Account account : acc){
          if(account.rating =='Hot'){
          system.debug('1');
                account.NumberOfEmployees.addError('Please enter atleast one employee');
            }
          
    }
}

public static void Sample2(List<Account> acc){

for(Account account : acc){
          if(account.rating =='Hot'){
            system.debug('2');
                account.NumberOfEmployees.addError('Please enter atleast two employee');
            }
    }

}


}