/*
MIT License

Copyright (c) 2020 Playground, https://www.playg.app

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/
import { LightningElement} from 'lwc';
import getAllActiveUsers from '@salesforce/apex/PermissionSetManagerController.getAllActiveUsers';
import getAllPermissionSets from '@salesforce/apex/PermissionSetManagerController.getAllPermissionSets';
import getPermissionSetAssignments from '@salesforce/apex/PermissionSetManagerController.getPermissionSetAssignments';
import saveChanges from '@salesforce/apex/PermissionSetManagerController.saveChanges';

export default class permissionSetManager extends LightningElement {
    permissionSets = [];
    users = [];
    permissionSetAssignments = [];
    selectedPermissionSet;
    selectedUser;
    hasRendered = false;
    isLoading = true;
    error;
    showResponse = false;
    saveResponse;
    selectedTab;
    disableSave;

    getPermissionSets() {
        this.isLoading = true;
        this.selectedTab = 'PermissionSet';
        this.permissionSets = [];
        getAllPermissionSets().then(result => { 
            for (var index in result) {
                var permissionSet = result[index];
                var userLicenseName = ((permissionSet.License != null) ? permissionSet.License.Name : '');
                this.permissionSets.push({
                    id : permissionSet.Id,
                    name : permissionSet.Name, 
                    label : permissionSet.Label,
                    userLicenseName : userLicenseName,
                    checked : false
                });
            }
            if (this.permissionSets && this.permissionSets.length > 0) {
                this.selectedPermissionSet = this.permissionSets[0].id;
                this.updatedSelectedPermissionSet();
            }
            this.isLoading = false;
        })
        .catch(error => {
            this.error = error;
            this.isLoading = false;
        });
    }

    getActiveUsers() {        
        this.isLoading = true;
        this.selectedTab = 'User';
        this.users = [];
        getAllActiveUsers().then(result => { 
            for (var index in result) {
                var userDetail = result[index];
                var userLicenseName = '';
                if (userDetail.Profile && userDetail.Profile.UserLicense) {
                    userLicenseName = userDetail.Profile.UserLicense.Name;
                }
                this.users.push({
                    id : userDetail.Id,
                    name : userDetail.Name, 
                    userLicenseName : userLicenseName,
                    checked : false
                });
            }
            if (this.users && this.users.length > 0) {
                this.selectedUser = this.users[0].id;
                this.updatedSelectedUser();
            }
            this.isLoading = false;
        })
        .catch(error => {
            this.error = error;
            this.isLoading = false;
        });
    }

    getAssignments() {
        this.isLoading = true;
        this.saveResponse = [];
        this.showResponse = false;
        var recordId = (this.selectedTab == 'PermissionSet') ? this.selectedPermissionSet : this.selectedUser;
        getPermissionSetAssignments({tabType : this.selectedTab, recordId : recordId}).then(result => { 
            this.permissionSetAssignments = result;
            this.isLoading = false;
        })
        .catch(error => {
            this.error = error;
            this.isLoading = false;
        });
    }

    handlePermissionSetChange(event) {
        if (event.target.checked == false) {
            event.target.checked = true; //Don't allow unchecking
        } else {
            this.selectedPermissionSet = event.target.name;
            this.updatedSelectedPermissionSet();
        }
    }

    handleUserChange(event) {
        if (event.target.checked == false) {
            event.target.checked = true; //Don't allow unchecking
        } else {
            this.selectedUser = event.target.name;
            this.updatedSelectedUser();
        }
    }

    handleUserSelect(event){
        for (var index in this.permissionSetAssignments) {
            if (this.permissionSetAssignments[index].assigneeId == event.target.name) {
                this.permissionSetAssignments[index].checked = event.target.checked;
            }
        }
    }

    handlePermissionSelect(event){
        for (var index in this.permissionSetAssignments) {
            if (this.permissionSetAssignments[index].permissionSetId == event.target.name) {
                this.permissionSetAssignments[index].checked = event.target.checked;
            }
        }
    }

    updatedSelectedPermissionSet() {
        this.disableSave = false;
        for (var index in this.permissionSets) {
            if (this.permissionSets[index].id == this.selectedPermissionSet) {
                this.permissionSets[index].checked = true;
            } else {
                this.permissionSets[index].checked = false;
            }
        }
        this.getAssignments();
    }

    updatedSelectedUser() {
        this.disableSave = false;
        for (var index in this.users) {
            if (this.users[index].id == this.selectedUser) {
                this.users[index].checked = true;
            } else {
                this.users[index].checked = false;
            }
        }
        this.getAssignments();
    }

    checkDownloadButtonVisibility() {
        if (this.selectedObjectNames && this.selectedObjectNames.length > 0) {
            this.disableDownload = false;
        } else {
            this.disableDownload = true;
        }
    }

    save(event) {
        this.isLoading = true;
        this.isLoading = true;

        saveChanges({assignmentWrapper : this.permissionSetAssignments}).then(result => { 
            this.showResponse = true;
            this.saveResponse = result;
            this.disableSave = true;
            this.isLoading = false;
        });
    }

    reset(event) {
        this.disableSave = false;
        if (this.selectedTab == 'PermissionSet') {
            this.updatedSelectedPermissionSet();
        } else {
            this.updatedSelectedUser();
        }
    }

    selectPermissionSetTab(event) {
        this.getPermissionSets();
    }

    selectUserTab(event) {
        this.getActiveUsers();
    }

}