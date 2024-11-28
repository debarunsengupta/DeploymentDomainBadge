import { LightningElement,api } from 'lwc';
import WelcomeLabel from '@salesforce/label/c.WelcomeLabel';
export default class ClosedWonForm extends LightningElement {

   
    Name;
    City;
    label = {
        WelcomeLabel
    };

    @api 
    callFromParent(paremt1, paremt2) {
        debugger;
        this.Name = paremt1;
        this.City = paremt2;
      //  this.ShowToast('Success', 'Successfully Called Aura to LWC', 'success', 'dismissable');
    }
 
}