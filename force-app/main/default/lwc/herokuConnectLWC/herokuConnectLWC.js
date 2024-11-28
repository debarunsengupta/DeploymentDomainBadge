import { LightningElement } from 'lwc';

export default class HerokuConnectLWC extends LightningElement {
    data;
    connectedCallback()
    {
        fetch('https://data.heroku.com/dataclips/cbpnbertydmqzsuueskzuyuetjqy.json',
		{
			method : "GET",
			headers : {
				"Accept": "application/json"
			}
		}).then(function(response) {
			return response.json();
		})
		.then((myJson) =>{
            console.log('%%%%'+JSON.stringify(myJson));
            
            console.log('Full Obj' + myJson);
            
           this.data= myJson.values.map((eachval) => {
                
                return {"SFDCID": eachval[6],"AccountName": eachval[2],"Rating":eachval[5],"NumberOfEmployee":eachval[4]};
            })
			
			
			
		})
		.catch(e=>console.log(e));
    }
}