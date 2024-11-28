import { LightningElement,api,track,wire } from 'lwc';
import fetchRecords from '@salesforce/apex/GenericChildObjectRecController.fetchRecords';
import { NavigationMixin } from 'lightning/navigation';
export default class OptyBusProcessLWC extends NavigationMixin(LightningElement) {


    @api objectName;
@api parentObjectName;
@api fieldName;
@api fieldValue;
@api parentFieldAPIName;
@api recordId;
@api strTitle;
@api filterType;
@api operator;
@api fieldsList;
@api relationshipApiName;
@track field1;
@track field2;
@track field3;
@track field4;
@track listRecords;

connectedCallback() {

    var listFields = this.fieldsList.split(',');
   //console.log( ‘Fields are ‘ + listFields );
    this.field1 = listFields[ 0 ].trim();
    this.field2 = listFields[ 1 ].trim();
    this.field3 = listFields[ 2 ].trim();
    this.field4 = listFields[ 3 ].trim();
    //console.log( ‘Field 1 is ‘ + this.field1 );
   //console.log( ‘Field 2 is ‘ + this.field2 );
    //console.log( ‘Field 3 is ‘ + this.field3 );
   // console.log( ‘Field 4 is ‘ + this.field4 );

}

get vals() { 

    return this.recordId + '-' + this.objectName + '-' +  
           this.parentFieldAPIName + '-' + this.fieldName + '-' +  
           this.fieldValue + '-' + this.filterType + '-' + this.operator + '-' + this.fieldsList; 

} 
 
@wire(fetchRecords, { listValues: '$vals' }) 
accountData( { error, data } ) { if ( data ) {
          
    this.listRecords = data.listRecords;
    this.countBool = true;
    /*if ( data.recordCount ) {
       
        if ( data.recordCount > 3 ) {

            this.titleWithCount = this.strTitle + '(3+)';
            this.countBool = true;
       
        } else {

            this.countBool = false;
            this.titleWithCount = this.strTitle + '(' + data.recordCount + ')';

        }
    }*/

}

}

createNew() {

this[NavigationMixin.Navigate]({
    type: 'standard__objectPage',
    attributes: {
        objectApiName: this.objectName,
        actionName: 'new'
    }
});

}
editClicked(event){
    const d=event.currentTarget.dataset.item
    const config = {
        type: "standard__recordPage",
        attributes: {
          recordId: d,
          objectApiName: this.objectName,
          actionName: "edit"
        }
      };
      this[NavigationMixin.Navigate](config);
}

}