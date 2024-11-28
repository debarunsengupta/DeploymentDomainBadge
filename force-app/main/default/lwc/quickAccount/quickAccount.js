import { LightningElement,wire,track ,api} from 'lwc';
import createAccount from '@salesforce/apex/QuickActionController.createAccount';
import createAccount1 from '@salesforce/apex/QuickActionController.createAccount1';


export default class QuickAccount extends LightningElement {
@track accounts;
    @api recordId;

@wire(createAccount1,{recId: '$recordId'}) createAccount1 ({ error, data }) {
    
       if (data) {
          console.log(JSON.stringify(data));
          this.accounts=data;
       } else if (error) {
       }
   }

}