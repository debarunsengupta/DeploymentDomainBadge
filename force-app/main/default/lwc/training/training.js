import { LightningElement,track } from 'lwc';

export default class Training extends LightningElement {

    num1 = 10
     num2 = 20
  
 
     get multiply(){
         return this.num1*this.num2
     }

 
      
}