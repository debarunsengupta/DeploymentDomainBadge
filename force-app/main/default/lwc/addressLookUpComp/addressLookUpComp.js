import { LightningElement,track,api,wire } from 'lwc';
import getAddressSet from '@salesforce/apex/AddressComponentController.getAddressSet';
import getAddressDetailsByPlaceId from '@salesforce/apex/AddressComponentController.getAddressDetailsByPlaceId';
import checkAddressFields from '@salesforce/apex/AddressComponentController.checkAddressFields';
import saveAddressServer from '@salesforce/apex/AddressComponentController.saveAddress';
import getAddressField from '@salesforce/apex/AddressComponentController.getAddressField';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';
const addressApiNameToField = new Map();
const DELAY = 350;
export default class AddressLookUpComp extends LightningElement {
    @track showModalBox=false;
    @track mapMarkers=[];
    
    @track error;
    addressFields=[];
    @api recordId;
    @track showAddressSearch;
    stateApiName;
    countryApiName;
    zipCodeApiName;
    streetApiName;
    cityApiName;
    @track addressValidate=false;
    @track street;
    @track city;
    @track state;
    @track country;
    @track zipcode;
    @track AddressList=[];
    zoomLevel=1;
   
    connectedCallback(){
       
        if(this.stateApiName!=undefined){
        this.addressFields.push(this.stateApiName);
        addressApiNameToField.set(this.stateApiName,'state');
        }
        if(this.countryApiName!=undefined){
            this.addressFields.push(this.countryApiName);
            addressApiNameToField.set(this.countryApiName,'country');
        }
        if(this.zipCodeApiName!=undefined){
            this.addressFields.push(this.zipCodeApiName);
            addressApiNameToField.set(this.zipCodeApiName,'zipcode');
        }
        if(this.streetApiName!=undefined ){
            this.addressFields.push(this.streetApiName);
            addressApiNameToField.set(this.streetApiName,'street');
        }
        if(this.cityApiName!=undefined){
            this.addressFields.push(this.cityApiName);
            addressApiNameToField.set(this.cityApiName,'city');
        }
       
       

        if(this.addressFields.length >0){
            checkAddressFields({ record: this.recordId, addressFields: this.addressFields})
        .then(result => {
            this.addressValidate = result;
            this.fetchAddressOnload(this.recordId,this.addressFields);
        })
        .catch(error => {
            this.error = error;
            this.addressValidate=false;
          
        });
        }
     
    
    }



   
    @api set mappedStateApiName(value) {

        this.stateApiName=value;

      }
    get mappedStateApiName() {
        return this.stateApiName;
      }
    @api set mappedCountryApiName(value) {
        this.countryApiName=value;
     
      }
    get mappedCountryApiName() {
        return this.countryApiName;
      }
      @api set mappedZipCodeApiName(value) {
        this.zipCodeApiName=value;
     
      }
    get mappedZipCodeApiName() {
        return this.zipCodeApiName;
      }

    @api set isAddressSearchRequired(value) {
        this.showAddressSearch=value;
        this.showModalBox=false;
     
      }
    get isAddressSearchRequired() {
        return this.showAddressSearch;
      }
    @api set mappedStreetApiName(value) {
        this.streetApiName=value;
     
      }
    get mappedStreetApiName() {
        return this.streetApiName;
      }
      @api set mappedCityApiName(value) {
        this.cityApiName=value;
     
      }
    get mappedCityApiName() {
        return this.cityApiName;
      }
    OpenModal(event){
        this.showModalBox=true;
        this.AddressList=[];
    }
    closeModal(event){
        this.showModalBox=false;
        this.AddressList=[];
    }
    validateFields(event){
       
        const country=this.template.querySelector('.country');
        const city=this.template.querySelector('.city');
        const state=this.template.querySelector('.state');
        const zipCode=this.template.querySelector('.zipcode');
        const street=this.template.querySelector('.street');

        let onlyAlphabet=/^[A-Za-z ]+$/
        let onlyDigits=/^[0-9]*$/
       

       if(country.value!=''){
        if(!country.value.match(onlyAlphabet)){
            country.setCustomValidity('Country name cannot contain numbers');
        }
        else{
            country.setCustomValidity('');

        }
       }
       if(city.value !=''){
        if(!city.value.match(onlyAlphabet)){
            city.setCustomValidity('City name cannot contain numbers');

        }
        else{
            city.setCustomValidity('');

        }
        }
        if(state.value != ''){
        
        if(!state.value.match(onlyAlphabet) ){
            state.setCustomValidity('State name cannot contain numbers');

        }
        else{
            state.setCustomValidity('');

        }
        }
        if(zipCode.value !=''){
        if(!zipCode.value.match(onlyDigits) ){
            zipCode.setCustomValidity('Zip/postalcode cannot contain alphabets');

        }
        else{
            zipCode.setCustomValidity('');

        }
       }


        
    }
    getAddressRecommendations(event){

      this.AddressList=[];
       
      window.clearTimeout(this.delayTimeout);
      const searchKey=event.target.value;

      this.delayTimeout = setTimeout(() => {
        getAddressSet({ SearchText:searchKey })
            .then(result => {
                let response = JSON.parse(result);
                let predictions=response.predictions;
                var addresses = [];
                if (predictions.length > 0) {
                    for (let i = 0; i < predictions.length; i++) {
                       
                        addresses.push(
                            {
                                main_text: predictions[i].structured_formatting.main_text, 
                                secondary_text: predictions[i].structured_formatting.secondary_text,
                                place_id: predictions[i].place_id
                            });
                        
                    }
                }
             
                this.AddressList=addresses;
            })
            .catch(error => {
                this.error = error;
            });
    }, DELAY);

    }

    get checkAddressList(){
      
        
       
        if(this.AddressList.length >0){
            return true;
        }
        return false;
    }
    selectOption(event){
        let selectedValue = event.currentTarget.dataset.value;

        getAddressDetailsByPlaceId({PlaceID:selectedValue})
        .then(result => {
            let response = JSON.parse(result);
            var postalCode = '', state = '', country= '', city = '', street = '', street_number = '', route = '', subLocal1 = '', subLocal2 = '';
            for(let i=0; i < response.result.address_components.length ; i++){
                let FieldLabel = response.result.address_components[i].types[0];
            
                if(FieldLabel == 'sublocality_level_2' || FieldLabel == 'sublocality_level_1' || FieldLabel == 'street_number' || FieldLabel == 'route' || FieldLabel == 'locality' || FieldLabel == 'country' || FieldLabel == 'postal_code' || FieldLabel == 'administrative_area_level_1'){
                    switch(FieldLabel){
                        case 'sublocality_level_2':
                            subLocal2 = response.result.address_components[i].long_name;
                            break;
                        case 'sublocality_level_1':
                            subLocal1 = response.result.address_components[i].long_name;
                            break;
                        case 'street_number':
                            street_number = response.result.address_components[i].long_name;
                            break;
                        case 'route':
                            route = response.result.address_components[i].short_name;
                            break;
                        case 'postal_code':
                            postalCode = response.result.address_components[i].long_name;
                            break;
                        case 'administrative_area_level_1':
                            state = response.result.address_components[i].short_name;
                            break;
                        case 'country':
                            country = response.result.address_components[i].long_name;
                            break;
                        case 'locality':
                            city = response.result.address_components[i].long_name;
                            break;
                        default:
                            break;
                    }
                }
            }
            
            street = street_number + ' ' + route;
            if(street == null){
                street = subLocal2 + ' ' + subLocal1;
            }
            console.log(street);
            this.street=street;
            this.city=city;
            this.state=state;
            this.country=country;
            this.zipcode=postalCode;
            this.showModalBox=false;
            this.searchKey=null;


            this.mapMarkers=[];
            var loc={location: 
                {
                // Location Information
                City: this.city || '',
                Country: this.country || '',
                PostalCode: this.zipCode || '',
                State: this.state || '',
                Street: this.street || '',
              },
    
    
            // Extra info for tile in list & info window
            icon: 'standard:account'
        }
        this.mapMarkers.push(loc);
        this.zoomLevel=15;


          
        })
        .catch(error => {
            this.error = error;
        });


    }
  

    saveAddress(event){
        const city=this.template.querySelector('.city').value;
        const country=this.template.querySelector('.country').value;
        const state=this.template.querySelector('.state').value;
        const zipCode=this.template.querySelector('.zipcode').value;
        const street=this.template.querySelector('.street').value;
        const isInputsCorrect = [...this.template.querySelectorAll('lightning-input')]
        .reduce((validSoFar, inputField) => {
            inputField.reportValidity();
            return validSoFar && inputField.checkValidity();
        }, true);

        const isInputsCorrectStreet = [...this.template.querySelectorAll('lightning-textarea')]
        .reduce((validSoFar, inputField) => {
            inputField.reportValidity();
            return validSoFar && inputField.checkValidity();
        }, true);

    if (isInputsCorrect && this.addressValidate && isInputsCorrectStreet) {
   
     console.log('All Passed !')
     var addressField={};
    
     if(city!=undefined && this.cityApiName !=undefined){
        addressField[this.cityApiName]=city;
     }
     if(country!=undefined && this.countryApiName !=undefined){
        addressField[this.countryApiName]=country;
     }
     if(state!=undefined && this.stateApiName !=undefined){
        addressField[this.stateApiName]=state;
     }
     if(street!=undefined && this.streetApiName !=undefined){
        addressField[this.streetApiName]=street;
     }
     if(zipCode!=undefined && this.zipCodeApiName !=undefined){
        addressField[this.zipCodeApiName]=zipCode;
     }
     console.log('addressField:'+JSON.stringify(addressField));
     saveAddressServer({recordId:this.recordId,fieldApiToValue: addressField})
     .then(result => {
       console.log('success');
       const event = new ShowToastEvent({
        title: 'Toast message',
        message: 'Address Information has been Saved Successfully.',
        variant: 'success',
        mode: 'dismissable'
    });
    this.dispatchEvent(event);
    window.location.reload();
    this.mapMarkers=[];
    var loc={location: 
        {
        // Location Information
        City: city || '',
        Country: country || '',
        PostalCode: zipCode || '',
        State: state || '',
        Street: street || '',
      },


    // Extra info for tile in list & info window
    icon: 'standard:account'
}
this.mapMarkers.push(loc);
this.zoomLevel=15;
      
     })
     .catch(error => {
         this.error = error;
         const event = new ShowToastEvent({
            title: 'Toast message',
            message: 'There is an error while saving the Address Information.',
            variant: 'error',
            mode: 'dismissable'
        });
        this.dispatchEvent(event);
     });
    
    }else{
        console.log('Atleast one failed.')
        const event = new ShowToastEvent({
            title: 'Toast message',
            message: 'There is an error in the address form.',
            variant: 'error',
            mode: 'dismissable'
        });
        this.dispatchEvent(event);
    }
    
    }
    showOnMap(event){
     
        const city=this.template.querySelector('.city').value;
        const country=this.template.querySelector('.country').value;
        const state=this.template.querySelector('.state').value;
        const zipCode=this.template.querySelector('.zipcode').value;
        const street=this.template.querySelector('.street').value;

        this.mapMarkers=[];
  
        var loc={location: 
            {
            // Location Information
            City: city || '',
            Country: country || '',
            PostalCode: zipCode || '',
            State: state || '',
            Street: street || ''
          },
 
 
        // Extra info for tile in list & info window
       
        icon: 'standard:account'
    }
    this.mapMarkers.push(loc);
    this.zoomLevel = 15;   


    }

    handleMarkerSelect(event){
        const city=this.template.querySelector('.city').value;
        const country=this.template.querySelector('.country').value;
        const state=this.template.querySelector('.state').value;
        const zipCode=this.template.querySelector('.zipcode').value;
        const street=this.template.querySelector('.street').value;
        console.log('clicked');

        window.open('http://maps.google.com/maps?q='+street+'%20'+city+'%20'+state+'%20'+zipCode+'%20'+country);
        

    }

    fetchAddressOnload(recordId,addressField){

  


        let scope=this;
        getAddressField({recordId:recordId,addressFields: addressField})
     .then(result => {
       console.log('success');
       console.log('Res-->'+JSON.stringify(result));
       console.log('Object.keys(result).length:'+Object.keys(result).length);
       
       console.log('addressApiNameToField Map'+addressApiNameToField);

       if(Object.keys(result).length >0){
       for(let outerkey in result){
        addressApiNameToField.forEach(function(value, key) {
            if(value==="city" && outerkey==key){
                scope.city=result[outerkey];
               }
               if(value==="state" && outerkey==key){
                scope.state=result[outerkey];
               }
               if(value==="country" && outerkey==key){
                scope.country=result[outerkey];
               }
               if(value==="street" && outerkey==key){
                scope.street=result[outerkey];
               }
               if(value==="zipcode" && outerkey==key){
                scope.zipcode=result[outerkey];
               }
             })
       }
      
       this.mapMarkers=[];
  
       var loc={location: 
           {
           // Location Information
           City: this.city || '',
           Country: this.country || '',
           PostalCode: this.zipcode || '',
           State: this.state || '',
           Street: this.street || ''
         },


       // Extra info for tile in list & info window
      
       icon: 'standard:account'
   }
   this.mapMarkers.push(loc);
   this.zoomLevel = 15;   
       
    } /*else{
        const event = new ShowToastEvent({
            title: 'Toast message',
            message: 'There is an error while retrieving the Address Information.',
            variant: 'error',
            mode: 'dismissable'
        });
        this.dispatchEvent(event);
    }*/
    const event = new ShowToastEvent({
        title: 'Toast message',
        message: 'Address Information Retrieved Successfully',
        variant: 'success',
        mode: 'dismissable'
    });
    this.dispatchEvent(event);
      
     })
     .catch(error => {
         this.error = error;
         const event = new ShowToastEvent({
            title: 'Toast message',
            message: 'There is an error while retrieving the Address Information.',
            variant: 'error',
            mode: 'dismissable'
        });
        this.dispatchEvent(event);
     });
    }
    }