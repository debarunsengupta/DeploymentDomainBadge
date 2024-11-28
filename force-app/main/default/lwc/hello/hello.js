import { LightningElement,track } from 'lwc';
import getPiklistValues from '@salesforce/apex/LRC_MultiSelectControllerClassicStyle.getPiklistValues';
import fetchRecordTypeValues from '@salesforce/apex/LRC_MultiSelectControllerClassicStyle.fetchRecordTypeValues';
import getRecTypeId from '@salesforce/apex/LRC_MultiSelectControllerClassicStyle.getRecTypeId';
import ApiCallout from '@salesforce/apex/LRC_MultiSelectControllerClassicStyle.ApiCallout';
import filteredPiklistValues from '@salesforce/apex/LRC_MultiSelectControllerClassicStyle.filteredPiklistValues';
export default class Hello extends LightningElement {

    @track lstOfRecordType = [];
    @track GenreList = [];
    @track selectedGenreList = [];
    @track objectname = '';
    @track FilterValues = '';
    @track retresult = {};
    @track objectfieldapi = '';






    connectedCallback() {


        getPiklistValues({
                objname: this.objectname,
                fieldapiname: this.objectfieldapi

            })
            .then((result) => {
                if (1 === 1) {
                    var result = result;
                    var plValues = [];
                    for (var i = 0; i < result.length; i++) {
                        plValues.push({
                            label: result[i],
                            value: result[i]
                        });
                    }
                    this.GenreList = plValues;
                }
            })
            .catch((error) => {
                console.log('Error received: code' + error.errorCode + ', ' + 'message ' + error.body.message);
            });


        fetchRecordTypeValues({
                objname: this.objectname

            })
            .then((result) => {
                var result = result;
                var plValues = [];
                plValues.push({
                    class: "optionClass",
                    label: "--- None ---",
                    value: ""
                });
                for (var i = 0; i < result.length; i++) {
                    plValues.push({
                        label: result[i],
                        value: result[i]
                    });
                }
                this.lstOfRecordType = plValues;
            })
            .catch((error) => {
                console.log('Error received: code' + error.errorCode + ', ' + 'message ' + error.body.message);
            });


    }
    handleGenreChange(event) {
        var selectedValues = event.target.value

        this.selectedGenreList = selectedValues;

    }
    onChangeFunction() {
        debugger;
        var recordTypeLabel = this.template.querySelector('[data-id="selectid"]').value;

        getRecTypeId({
                "recordTypeLabel": recordTypeLabel
            })
            .then((result) => {
                if (1 === 1) {
                    ApiCallout({
                            "objname": this.objectname,
                            "recordtypeid": result,
                            "fieldapiname": this.objectfieldapi
                        })
                        .then((result) => {
                            this.retresult = result;
                            var result = this.retresult;
                            if (1 === 1) {
                                var plValues = [];
                                for (var i = 0; i < result.length; i++) {
                                    if (result[i].label != '--None--') {
                                        plValues.push({
                                            label: result[i].label,
                                            value: result[i].value
                                        });
                                    }
                                }
                                this.GenreList = plValues;
                            }
                        })
                        .catch((error) => {
                            console.log('Error received: code' + error.errorCode + ', ' + 'message ' + error.body.message);
                        });
                }
            })
            .catch((error) => {
                console.log('Error received: code' + error.errorCode + ', ' + 'message ' + error.body.message);
            });



    }
    fetchfilteredpicklistVal() {
        filteredPiklistValues({
                objname: this.objectname,
                fieldapiname: this.objectfieldapi,
                filter: this.FilterValues

            })
            .then((result) => {
                if (1 === 1) {
                    var result = result;
                    var plValues = [];
                    for (var i = 0; i < result.length; i++) {
                        plValues.push({
                            label: result[i],
                            value: result[i]
                        });
                    }
                    this.GenreList = plValues;
                }
            })
            .catch((error) => {
                console.log('Error received: code' + error.errorCode + ', ' + 'message ' + error.body.message);
            });


    }
}