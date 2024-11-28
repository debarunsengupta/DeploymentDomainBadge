import { LightningElement,wire } from 'lwc';
import accountRetrieve from '@salesforce/apex/AccountFetch.accountRetrieve';
export default class POC extends LightningElement {
		value = '';
    accounts;
		error;
    @wire(accountRetrieve, {industry: '$value'} )
    wiredAccounts({data, error}){
            if(data){
                this.accounts = data;
								console.log("account",this.accounts)
                this.error = undefined;
            }
            else if (error) {
                this.error = error;
                this.accounts = undefined;
            }
        }
    get options() {
        return [
            { label: 'Agriculture', value: 'Agriculture' },
            { label: 'Banking', value: 'Banking' },
            { label: 'Biotechnology', value: 'Biotechnology' },
        ];
    }
    handleChange(event) {
        this.value = event.detail.value;
    }
}