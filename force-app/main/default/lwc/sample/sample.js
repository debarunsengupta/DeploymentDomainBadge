import { LightningElement,track,api } from 'lwc';

export default class Sample extends LightningElement {
    @track
    itemName;
    @track dummyFieldValue='abc';
    @track abc={};
   
renderedCallback()
{
    console.log('TEST');
}

get methodtest()
{
    debugger;
 let fetched=this.getAttribute('value');
 console.log('fetched-->'+fetched);
    return ((this.dummyFieldValue == fetched ? 'selected' : false));

}
handlechange(event)
{
   debugger;
    console.log('handler called');
    toggleClass(this.template.querySelector('#dropdownValues'), 'showDropdown');

    //let classtype=this.template.querySelector('#test').classList;
    const element = this.template.querySelector('[data-id="overview"]');
    const val=element.getAttribute('data-id');
    let classtype=event.target.classList;
  
    console.log('classtype:'+classtype);
//this.itemName=event.target.value;
}
    


}