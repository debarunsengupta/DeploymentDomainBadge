//Section 4 Scenario BedRock Badge
import { LightningElement,api,track } from 'lwc';
import getIndirectContactsToAccount from "@salesforce/apex/IndirectRelationshipController.getIndirectContactsToAccount";

export default class IndirectRelationshipLWC extends LightningElement {

@api recordId;
error;
contactData;
sortBy='AccountName'
@api noOfRecToDisplay=1;
@track sortDirection='asc';
contactColumns = [
    { label: 'Account Name', fieldName: 'AccountName' ,sortable: 'true'},
    { label: 'Contact FirstName', fieldName: 'FirstName',sortable: 'true'},
    { label: 'Contact LastName', fieldName: 'LastName' ,sortable: 'true'},
];


connectedCallback(){
    console.log('this.noOfRecToDisplay-->'+this.noOfRecToDisplay);
    let cloneData = [];

    getIndirectContactsToAccount({acctid: this.recordId, recDisplay: this.noOfRecToDisplay})
    .then((result) => {

        for (let row of result) {
            let newrow = Object.assign({}, row); // Shallow copy (level 2 refers to original)
            newrow = {
              ...newrow, 
              FirstName: row.Contact.FirstName,
              LastName: row.Contact.LastName,
              Phone: row.Contact.Phone,
              Title: row.Contact.Title,
              Email: row.Contact.Email,
              AccountName: row.Contact.Account.Name
            };                
            cloneData.push(newrow);
          } 
          this.contactData= cloneData;
          console.log('28-->'+JSON.stringify(cloneData));
     
    })
    .catch((error) => {
      this.error = error;
    });

}

doSorting(event) {
    this.sortBy = event.detail.fieldName;
    this.sortDirection = event.detail.sortDirection;
    this.sortData(this.sortBy, this.sortDirection);
}
sortData(fieldname, direction) {
    let parseData = JSON.parse(JSON.stringify(this.contactData));
    // Return the value stored in the field
    let keyValue = (a) => {
        return a[fieldname];
    };
    // cheking reverse direction
    let isReverse = direction === 'asc' ? 1: -1;
    // sorting data
    parseData.sort((x, y) => {
        x = keyValue(x) ? keyValue(x) : ''; // handling null values
        y = keyValue(y) ? keyValue(y) : '';
        // sorting values based on direction
        return isReverse * ((x > y) - (y > x));
    });
    this.contactData = parseData;
}   
}