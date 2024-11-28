import { LightningElement } from 'lwc';

export default class AccountGrandChild extends LightningElement {
    handleClick(event) {
        // Prevents the anchor element from navigating to a URL.
        event.preventDefault();
        // Create & Dispatch Event
        this.template.querySelector('div')
        .dispatchEvent(new CustomEvent('clickgrand', {bubbles : true,composed : true}));
    }
    
    handleBtnClick = () =>{
        console.log('inside same granchild');
    }

}