import { LightningElement,track } from 'lwc';
import {label1 } from 'c/modularity';
export default class Recipy extends LightningElement {

    connectedCallback()
    {
        //console.log('Test-->' + JSON.stringify(moduletesting));
        console.log('Test 1-->' + label1.header);
      // console.log('Test 2-->' + moduletesting.label1);
        
    }

    @track fetchedCustomLabel=label1.header;

}