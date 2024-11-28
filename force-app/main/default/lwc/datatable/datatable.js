import { LightningElement,track } from 'lwc';

export default class Datatable extends LightningElement {

    @track lstEmployee = [];
    @track myTitle = 'Employee Information';
    @track paginationList = [];
    @track pageSize = 5;
    @track totalSize;
    @track start;
    @track end;




    get retexp1() {
        return ((this.start == 0));
    }
    get retexp2() {
        return ((this.end >= this.totalSize - 1));
    }

    renderedCallback()
    {
        this.addClass(this.template.querySelector('[data-id="nextRow"]'), "slds-hide");

    }
    connectedCallback() {




        var dataRow = {
            "dataList": [{
                "Name": "Javvadi, Monica",
                "PersonBirthdate": "1970-01-01",
                "CityName": "New York City",
                "State": " New York",
                "PostCode": "10001",
                "Tel": "9876543210",
                "Email": "jmonica@deloitte.com",
                "Salutation": "Ms.",
                "SSN": "987654321",
                "Country": "USA"
            }, {
                "Name": "Bahl, Shruti",
                "PersonBirthdate": "1955-11-07",
                "CityName": "Sanfrancisco",
                "State": "Northern California",
                "PostCode": "901",
                "Tel": "8976543210",
                "Email": "bshruthi@deloitte.com",
                "Salutation": "Ms.",
                "SSN": "967854321",
                "Country": "USA"
            }, {
                "Name": "Saxena, Amit",
                "PersonBirthdate": "1956-10-13",
                "CityName": "Dallas",
                "State": "Texas",
                "PostCode": "73309",
                "Tel": "7890654321",
                "Email": "samit@deloitte.com",
                "Salutation": "Mr.",
                "SSN": "978654321",
                "Country": "USA"
            }, {
                "Name": "Dhuri, Vivek",
                "PersonBirthdate": "2011-01-18",
                "CityName": "Costa Mesa",
                "State": "California",
                "PostCode": "96527",
                "Tel": "8790654321",
                "Email": "dvivek@deloitte.com",
                "Salutation": "Mr.",
                "SSN": "967894321",
                "Country": "USA"
            }, {
                "Name": "Divekar, Abhijeet",
                "PersonBirthdate": "2016-10-01",
                "CityName": "Tucson",
                "State": "Arizona",
                "PostCode": "85750",
                "Tel": "6789054321",
                "Email": "dabhiji@deloitte.com",
                "Salutation": "Mr.",
                "SSN": "912654321",
                "Country": "USA"
            }, {
                "Name": "Kuah, Henry",
                "PersonBirthdate": "1982-11-05",
                "CityName": "Dallas",
                "State": "Texas",
                "PostCode": "73304",
                "Tel": "9876543210",
                "Email": "khenry@deloitte.com",
                "Salutation": "Mr.",
                "SSN": "990654321",
                "Country": "USA"
            }, {
                "Name": "Maria, Claudia",
                "PersonBirthdate": "2017-12-15",
                "CityName": "Allen",
                "State": "Texas",
                "PostCode": "73306",
                "Tel": "7896543210",
                "Email": "mclaudia@deloitte.com",
                "Salutation": "Ms.",
                "SSN": "954654321",
                "Country": "USA"
            }, {
                "Name": "Battu, Sashidhar",
                "PersonBirthdate": "2017-12-15",
                "CityName": "Phoenix",
                "State": "Arizona",
                "PostCode": "85760",
                "Tel": "7869834521",
                "Email": "bsasidhar@deloitte.com",
                "Salutation": "Mr.",
                "SSN": "987456321",
                "Country": "USA"
            }, {
                "Name": "Jain, Ankita",
                "PersonBirthdate": "1990-01-02",
                "CityName": "Jacksonville",
                "State": "Florida",
                "PostCode": "86790",
                "Tel": "8907654321",
                "Email": "jankitha@deloitte.com",
                "Salutation": "Ms.",
                "SSN": "987651234",
                "Country": "USA"
            }, {
                "Name": "Sikchi, Raunak",
                "PersonBirthdate": "1942-07-09",
                "CityName": "Olympia",
                "State": "North Carolina",
                "PostCode": "78698",
                "Tel": "6784561330",
                "Email": "sraunik@deloitte.com",
                "Salutation": "Mr.",
                "SSN": "987654781",
                "Country": "USA"
            }, {
                "Name": "Saxena, Raunak",
                "PersonBirthdate": "1942-07-09",
                "CityName": "Olympia",
                "State": "North Carolina",
                "PostCode": "78698",
                "Tel": "6784561330",
                "Email": "sraunik@deloitte.com",
                "Salutation": "Mr.",
                "SSN": "987654781",
                "Country": "USA"
            }]
        }
        this.lstEmployee = JSON.parse(JSON.stringify(dataRow)).dataList;
        this.totalSize = this.lstEmployee.length;
        
       //this.totalSize = component.get "v.lstEmployee";
       // this.totalSize = this.lstEmployee;
        var listEmployees = this.lstEmployee;
        var pageSize = this.pageSize;
        this.start = 0;
        this.end = pageSize - 1;
        var paginationList = [];
        for (var i = 0; i < pageSize; i++) {
            paginationList.push(listEmployees[i]);
        }
        this.paginationList = paginationList;


    }
    onClickmore(event) {
        var parentElm;
        if (event.target.value === 'Show more') {
            event.target.value = "Show less";
            parentElm = document.getElementById(parseInt(event.target.id, 10)).parentElement.parentElement;
            //parentElm.nextElementSibling.classList.remove("slds-hide");
        } else if (event.target.value === 'Show less') {
            parentElm = document.getElementById(parseInt(event.target.id, 10)).parentElement.parentElement;
            parentElm.nextElementSibling.classList.add("slds-hide");
            //event.target.value = 'Show more';
        }

    }
    next(event) {

        var elist = this.lstEmployee;
        var endPosn = this.end;
        var startPosn = this.start;
        var paginationlist = [];
        for (var i = 0; i < this.pageSize; i++) {
            endPosn++;
            if (elist.length > endPosn) {
                paginationlist.push(elist[endPosn]);
            }
            startPosn++;
        }
        this.paginationList = paginationlist;
        this.start = startPosn;
        this.end = endPosn;


    }
    previous(event) {

        var elist = this.lstEmployee;
        var startPosn = this.start;
        var endPosn = this.end;
        var paginationlist = [];
        var pageSize = this.pageSize;
        startPosn -= pageSize;
        if (startPosn > -1) {
            for (var i = 0; i < pageSize; i++) {
                if (startPosn > -1) {
                    paginationlist.push(elist[startPosn]);
                    startPosn++;
                    endPosn--;
                }
            }
            startPosn -= pageSize;
            this.paginationList = paginationlist;
            this.start = startPosn;
            this.end = endPosn;
        }


    }
    addClass(elem, classval) {
        elem.classList.add(classval);
    }
}