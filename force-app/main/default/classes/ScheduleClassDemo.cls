global class ScheduleClassDemo implements Schedulable {
   global void execute(SchedulableContext SC) {
       for(integer i=0; i< 102;i++){
           List<Account> acc=[select id from Account];
       }
   }
}