import { LightningElement, track, wire, api } from 'lwc';
import AvailableRecType from '@salesforce/label/c.AvailableRecType';
import SelectObject from '@salesforce/label/c.SelectObject';
import AvailableOptions from '@salesforce/label/c.AvailableOptions';
import getPiklistValues from '@salesforce/apex/DLWC_MultiSelectControllerClassicStyle.getPiklistValues';
import fetchRecordTypeValues from '@salesforce/apex/DLWC_MultiSelectControllerClassicStyle.fetchRecordTypeValues';
import getRecTypeId from '@salesforce/apex/DLWC_MultiSelectControllerClassicStyle.getRecTypeId';
import ApiCallout from '@salesforce/apex/DLWC_MultiSelectControllerClassicStyle.ApiCallout';
import filteredPiklistValues from '@salesforce/apex/DLWC_MultiSelectControllerClassicStyle.filteredPiklistValues';
const DELAY = 350;
export default class DLWC_multiSelectClassicStyle extends LightningElement {
 label = {
	 AvailableRecType,
	 SelectObject,
	 AvailableOptions
 };
 @track GenreList = '';
 @track lstOfRecordType = '';
 @track selectedGenreList = '';
 @track error;
 @api objectname = 'Account';
 @api objectfieldapi = 'AccountSource';
 @api FilterValues = 'Web,Phone Inquiry';
 
 @wire(getPiklistValues, { objname: '$objectname', fieldapiname: '$objectfieldapi' })
 
 wiredDetails(result) {
 let plValues=[];
 
     if (result.data) {
     let fetched = result.data;
         for (var key in fetched) {
             plValues.push({
                 label: fetched[key],
                 value: fetched[key]
             });
         }
         this.GenreList = plValues; // pass it to the @tracked details
         } 
 }
 
 @wire(fetchRecordTypeValues, { objname: '$objectname' })
 
 wiredDetailsRecordType(result) {
 let recordtype=[];
     if (result.data) {
      let fetched = result.data;
         recordtype.push({
             class: "optionClass",
             label: "--- None ---",
             value: "--- None ---"
         });
         for (var key in fetched) {
 
             recordtype.push({
                 label: fetched[key],
                 value: fetched[key]
             });
         }
         this.lstOfRecordType = recordtype; 
     }
 }
 handleGenreChange(evt) {
     
     this.selectedGenreList = evt.target.value;
 }
 fetchfilteredpicklistVal(evt) {
 let objectname1 = evt.target.dataset.object;
  let objectfieldapi1 = evt.target.dataset.fieldapi;
  let FilterValues1 = evt.target.dataset.filter;
    window.clearTimeout(this.delayTimeout);
    this.delayTimeout = setTimeout(() => {
 
         filteredPiklistValues({ objname: objectname1, filter: FilterValues1, fieldapiname: objectfieldapi1 })
             .then(result => {
                 
                 let picklistfilter=[];
                 picklistfilter = [];
                 for (var key in result) {
 
                     picklistfilter.push({
                         label: result[key],
                         value: result[key]
                     });
                 }
                 this.GenreList = picklistfilter;
             })
             .catch(error => {
             this.error = error;
             });
     }, DELAY);
 }
 onChangeFunction(evt) {
     
     let objectname1 = evt.target.dataset.object;
     let objectfieldapi1 = evt.target.dataset.fieldapi;
     let selectedrectypeval = evt.target.value;
     let rectypeid='';
     
     if (selectedrectypeval == '--- None ---') {
         this.GenreList = '';
         return;
     }
     window.clearTimeout(this.delayTimeout);
  
     this.delayTimeout = setTimeout(() => {
         getRecTypeId({ recordTypeLabel: selectedrectypeval, objname: objectname1 })
             .then(result => {
              rectypeid = result;
             this.fetchRecTypeBasedPicklistVal(result, objectname1, objectfieldapi1);
 
             })
             .catch(error => {
             this.error = error;
                 
             });
     }, DELAY);
 
 }
 
 fetchRecTypeBasedPicklistVal(param, paramobjname, paramfieldapi) {
     let  apicalloutval = [];
 this.delayTimeout = setTimeout(() => {
 
         ApiCallout({ objname: paramobjname, recordtypeid: param, fieldapiname: paramfieldapi })
             .then(result => {
                 apicalloutval = [];
                 for (var key in result) {
                     if (result[key].label != '--None--') {
                         apicalloutval.push({
                             label: result[key].label,
                             value: result[key].value
                         });
                     }
                 }
                 this.GenreList = apicalloutval;
 
             })
             .catch(error => {
              this.error = error;
                 
             });
     }, DELAY);
 
 }
}