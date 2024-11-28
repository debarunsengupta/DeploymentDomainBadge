import { LightningElement, api } from 'lwc';

export default class AccountDetailList extends LightningElement {
    
    handleInChild = () =>{
        console.log('Inside child');
    }

    handleInChildEmbed = () =>{
        console.log('Inside child embedded ');
    }

    
}