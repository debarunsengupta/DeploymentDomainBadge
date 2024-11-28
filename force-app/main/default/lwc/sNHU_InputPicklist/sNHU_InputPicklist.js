import {
    LightningElement,
    track,
    wire
} from 'lwc';
import getPicklistValues from '@salesforce/apex/SNHU_InputPicklistController.getPicklistValues';
import getDependentMap from '@salesforce/apex/SNHU_InputPicklistController.getDependentMap';
import {
    CurrentPageReference
} from 'lightning/navigation';
import {
    registerListener,
    unregisterAllListeners,
    fireEvent
} from 'c/pubsub';


export default class SNHU_InputPicklist extends LightningElement {
    @track fieldLabel = '';
    @track fieldAPIName = '';
    @track associatedObjName = '';
    @track dummyFieldValue = '';
    @track multiSelectFieldValue = '';
    @track lstOfPicklistValues = [];
    @track setFieldValue = '{!c.setField}';
    @track required = '';
    @track multiSelect = false;
    @track isControllingPicklist = false;
    @track isDependentPicklist = false;
    @track dependentPicklistField = '';
    @track controllingPicklistField = '';
    @track newPicklistValue = '';
    @track controllingField = '';
    @track mapOfPicklistValues = '';
    @track disabled = false;
    @track initData = {};
    @track readOnly = false;
    @wire(CurrentPageReference) pageRef;



    get retexp1() {
        return ((this.dummyFieldValue == '' || this.dummyFieldValue == null || this.dummyFieldValue == undefined ? 'selected' : false));
    }
    retexp2_counter = -1;
    get retexp2() {
        if (this.retexp2_counter < this.lstOfPicklistValues.length - 1) {
            this.retexp2_counter = this.retexp2_counter + 1;
            var curval = this.lstOfPicklistValues[this.retexp2_counter];
            if (this.dummyFieldValue == curval.picklistValue) {
                return ('selected');
            } else {
                return (false);
            }
        } else {
            this.retexp2_counter = -1;
            this.retexp2_counter = this.retexp2_counter + 1;
        }
    }



    connectedCallback() {
        registerListener('dependentPicklistChange', this.updateDependentList, this);



        if ((this.lstOfPicklistValues == null || this.lstOfPicklistValues == undefined || this.lstOfPicklistValues.length == 0) &&
            (this.isDependentPicklist == undefined || !this.isDependentPicklist)) {
            getPicklistValues({
                    associatedObjName: this.associatedObjName,
                    fieldAPIName: this.fieldAPIName
                })
                .then((result) => {
                    this.lstOfPicklistValues = result;
                })
                .catch((error) => {
                    console.log('Error received: code' + error.errorCode + ', ' + 'message ' + error.body.message);
                });

        }

        if ((this.lstOfPicklistValues == null || this.lstOfPicklistValues == undefined || this.lstOfPicklistValues.length == 0) &&
            this.isDependentPicklist) {
            var controllingField = this.controllingPicklistField;
            var objectName = controllingField.split('.')[0];
            var controllingFieldVal = controllingField.split('.')[1];
            var initData = this.initData;
            getDependentMap({
                    objDetail: objectName,
                    contrfieldApiName: controllingFieldVal,
                    depfieldApiName: this.fieldAPIName
                })
                .then((result) => {
                    var res = result;
                    this.mapOfPicklistValues = res;
                    if (this.initData[objectName] && this.initData[objectName][0][controllingFieldVal]) {
                        var finalMap = this.mapOfPicklistValues;
                        var parentVal = this.initData;
                        if (parentVal in finalMap) {
                            this.lstOfPicklistValues = finalMap[parentVal];
                        }
                    }
                })
                .catch((error) => {
                    console.log('Error received: code' + error.errorCode + ', ' + 'message ' + error.body.message);
                });

        }


    }
    setValue(event) {

        var classList = event.target.classList;
        if (!classList.contains('slds-has-focus')) {
            event.target.classList.add('slds-has-focus');
        } else {
            event.target.classList.remove('slds-has-focus');
        }
        var selectedVal = event.target.title;
        var valueList = this.dummyFieldValue;
        if (valueList && valueList.length > 0) {
            if (valueList.indexOf(selectedVal) == -1) {
                valueList += ';';
                valueList += selectedVal;
            } else if (valueList.indexOf(selectedVal) >= 0) {
                if (valueList.indexOf(selectedVal) == 0) {
                    valueList = valueList.replace(selectedVal, '');
                    if (valueList.indexOf(';') == 0) {
                        valueList = valueList.replace(';', '');
                    }
                } else {
                    valueList = valueList.replace(';' + selectedVal, '');
                }
            }
        } else {
            valueList = selectedVal;
        }
        this.dummyFieldValue = valueList;
        updatedContVal(this.dummyFieldValue);

        this.multiSelectFieldValue = valueList;
        setField();



    }
    toggledropdownList() {
        toggleClass(this.template.querySelector('[data-id="dropdownValues"]'), 'showDropdown');

    }
    setField() {


    }
    updatedContVal(event) {

        if (this.isControllingPicklist) {
            var newSelectValue = event
            var contAPIName = this.fieldAPIName;
            fireEvent(this.pageRef, "dependentPicklistChange", {
                "newControllingValue": newSelectValue,
                "controllingAPIName": contAPIName
            });

        }


    }
    updateDependentList(event) {

        if (this.isDependentPicklist) {
            var picklistMap = this.mapOfPicklistValues;
            var contPickVal = event.detail.newControllingValue;
            var controllingFieldFromParent = event.detail.controllingAPIName;
            var controllingField = this.controllingPicklistField;
            var controllingFieldVal = controllingField.split('.')[1];
            if (controllingFieldVal == controllingFieldFromParent && picklistMap != null && contPickVal in picklistMap) {
                this.lstOfPicklistValues = picklistMap[contPickVal];
            }
        }


    }
    disconnectedCallback() {
        unregisterAllListeners(this);
    }
    toggleClass(elem, classval) {
        elem.classList.toggle(classval);
    }

}