import { LightningElement,wire,track } from 'lwc';

export default class Childtest extends LightningElement {


//wire,track(private reactive property),api(public reactive property)

handleCustomEvent(event){
  debugger;
  const textVal = event.detail;
console.log('textVal--->'+textVal);
}


      
}