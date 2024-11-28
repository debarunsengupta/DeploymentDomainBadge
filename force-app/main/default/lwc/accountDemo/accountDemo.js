import { LightningElement,wire,track } from 'lwc';

import accountRetrieve from '@salesforce/apex/AccountFetch.accountRetrieve';

export default class AccountDemo extends LightningElement {

    //@wire(accountRetrieve) accounts;
     @track accounts;
     @track error;
     @track selectedVal='';
    @wire(accountRetrieve, {rating: '$selectedVal'})
    wiredAccounts({ error, data }) {
        if (data) {
            this.accounts = data;
            this.error = undefined;

        } else if (error) {
            this.error = error;
            this.accounts = undefined;
           
            
        }
    }

    value = 'Hot';

    get options() {
        return [
            { label: 'Hot', value: 'Hot' },
            { label: 'Warm', value: 'Warm' },
            { label: 'Cold', value: 'Cold' },
        ];
    }
    handleChange(event){
        this.selectedVal=event.target.value;

    }
}