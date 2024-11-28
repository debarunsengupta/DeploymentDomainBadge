import { LightningElement } from 'lwc';
import {emailValidator } from 'c/lwcUtility';

export default class ValidateEmail extends LightningElement {

    validateEmail() {
        //Get email address
    
        let input = this.template.querySelector(".input").value;
        let emailResult = emailValidator(input);
        if(emailResult)
            alert(input +" is valid Email.");
        else
            alert(input +" is not a valid Email.");
    }
   
}