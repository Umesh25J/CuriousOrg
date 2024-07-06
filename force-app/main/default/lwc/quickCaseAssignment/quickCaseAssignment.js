import { LightningElement, api, wire,track } from 'lwc';

//import { getObjectInfo, getPicklistValuesByRecordType, createRecord } from 'lightning/uiObjectInfoApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { createRecord } from 'lightning/uiRecordApi';
import CASE_OBJECT from '@salesforce/schema/Case';

import STATUS_FIELD from '@salesforce/schema/Case.Status';
import ORIGIN_FIELD from '@salesforce/schema/Case.Origin';
import PRIORITY_FIELD from '@salesforce/schema/Case.ContactId';
import getAccountContactRecords from "@salesforce/apex/AccountContactController.getAccountContactRecords";
import deleteContactData from "@salesforce/apex/AccountContactController.deleteContactData";
import insertContactData from '@salesforce/apex/AccountContactController.insertContactData';

export default class QuickCaseAssignment extends LightningElement {
    subject;
    description;
    statusValue;
    originValue;
    priorityValue;

    pickValStatus;
    pickValOrigin;
    pickValPriority;

    @api recordId;
    @api objectApiName; 
    
    objectName; 

    /*@wire(getObjectInfo, { objectApiName: CASE_OBJECT })
        accountMetadata;

    @wire(getPicklistValuesByRecordType, { 
            recordTypeId : '$accountMetadata.data.defaultRecordTypeId', 
            objectApiName : CASE_OBJECT
        }) 
        wiredRecordTypeInfo({data, error}) {
            if(data) {
                console.log(' getPicklistValuesByRecordType Info : ', data);
                this.pickValStatus = data.picklistFieldValues.Status.values;
                this.pickValOrigin = data.picklistFieldValues.Origin.values;
                this.pickValPriority = data.picklistFieldValues.Priority.values;
            }
            if(error) {
                console.log('Error Occurred : ', error);
            }
    }*/

    handleChange(event) {
        let name = event.target.name;
        let val = event.target.value;
        if(name === 'subject'){
            this.subject = val;
        } else if (name === 'description') {
            this.description = val;
        } else if (name === 'CaseStatus') {
            this.statusValue = val;
        } else if (name === 'CaseOrigin') {
            this.originValue = val;
        } else if (name === 'CasePriority') {
            this.priorityValue = val;
        } 
    }

    handleCreate() {
        console.log('*** recordId *** ' + this.recordId);
        console.log('*** objectApiName *** ' + this.objectApiName);
        console.log('*** statusValue *** ' + this.statusValue);
        console.log('*** originValue *** ' + this.originValue);
               
        const fields = {};
        fields[STATUS_FIELD.fieldApiName] = this.statusValue;
        fields[ORIGIN_FIELD.fieldApiName] = this.originValue;
        fields[PRIORITY_FIELD.fieldApiName] = this.priorityValue;
        const caseRecord = {apiName : CASE_OBJECT.objectApiName, fields : fields};
        
        createRecord(caseRecord)
            .then(result => {
                //const id = result.id;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Case created: ' + result.id,
                        variant: 'success',
                    }),
                );
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error',
                    }),
                );
            }) 
            console.log('*** end createRecord *** ');
    }
    @track isShowAccountModal = false;
    @track isShowContactModal = false;
    @track showContactEditForm = false;
    totalAccounts;
    contactId;
    visibleAccounts;
    @track blankRow = [];
    @track disabledCheckbox = true;
    @track index = 0;
    AccountID;
    @track hideSave=false;
    connectedCallback()
    {
        console.log('Entered');
        getAccountContactRecords().then(result=>{
            this.totalAccounts=result;
        }).catch(error=>{
            console.error('Error while getting records'+error)
        }
            )
    }

    showAccountModalBox() {  
        this.isShowAccountModal = true;
        console.log('show');
    }

    showContactModalBox() {  
        this.isShowContactModal = true;
        console.log('show');
    }


    hideModalBox() {  
        this.isShowAccountModal = false;
        this.isShowContactModal = false;
        this.showContactEditForm = false;
        console.log('hide');
    }

    AccountCreated(event)
    {
        this.hideModalBox();
        const evt = new ShowToastEvent({
            message: 'Account Created Successfully '+event.detail.id,
            variant: 'success',
        });
        this.dispatchEvent(evt);
        eval("$A.get('e.force:refreshView').fire();");
    }
    ContactCreated(event)
    {
        this.hideModalBox();
        const evt = new ShowToastEvent({
            message: 'Contact Created Successfully '+event.detail.id,
            variant: 'success',
        });
        this.dispatchEvent(evt);
        eval("$A.get('e.force:refreshView').fire();");
    }
    cancel() {  
        this.hideModalBox();
    }
    editContact(event)
    {
        this.contactId=event.target.name;
        this.showContactEditForm=true;
    }    
    updateContact(event)
    {
        this.hideModalBox();
        const evt = new ShowToastEvent({
            message: 'Contact Updated Successfully '+event.detail.id,
            variant: 'success',
        });
        this.dispatchEvent(evt);
        eval("$A.get('e.force:refreshView').fire();");
    }
    updateAccountHandler(event){
        this.visibleAccounts=[...event.detail.records]
        console.log(event.detail.records)
    }
    removeRow(event){
        console.log('sdxfhlgksklfhnk'+this.AccountID);
        const eventName = event.target.name;
        let blankRow = this.blankRow;
        if(eventName === 'multipleRowRemoval'){
            for(let i = 0; i < blankRow.length; i++){
                    blankRow.splice(i, 1);
                    i--;
            }
        }else{
            blankRow.splice(event.target.value, 1);
        }
        this.blankRow = blankRow;
        if(this.blankRow.length==0)
        {
            this.hideSave=false;
        }
    }
    // setCheckBox(event){
    //     console.log('select : '+this.AccountID);
    //     let blankrow = this.blankRow;
    //     if(blankrow[event.target.name].isChecked){
    //         blankrow[event.target.name].isChecked = false;
    //     }else{
    //         blankrow[event.target.name].isChecked = true;
    //     }
    //     this.blankRow = blankrow;
    // }
    saveData(event){
        console.log('Entered for Save : '+this.AccountID);
        let contactDataList=[];
        let blankRow = this.blankRow;
        console.log('LastName'+this.blankRow[0].LastName);
        for(let i = 0; i < blankRow.length; i++){
            if(blankRow[i] !== undefined){// && blankRow[i].isChecked
                console.log('Entered for Record Creation');
                let conData = new Object();
                conData.AccountId =this.AccountID;
                conData.FirstName = blankRow[i].FirstName;
                conData.LastName = blankRow[i].LastName;
                contactDataList.push(conData);
            }
        }
        if(contactDataList.length > 0){
            console.log('Entered for Method Calling');
            insertContactData({contactDataString: JSON.stringify(contactDataList)}).then(result => {
                console.log(result);
                for(let j = 0; j < result.length; j++)
                {
                const evt = new ShowToastEvent({
                    message: 'Contact Created Successfully ',
                    variant: 'success',
                });
                this.dispatchEvent(evt);
            }
                
                eval("$A.get('e.force:refreshView').fire();");

            }).catch(error => {
                window.alert('Please contact system admin: ' + JSON.stringify(error));
            })
        }else{
            window.alert('Please select any row to insert data.');
        }
    }
    setFirstName(event){
        const eventName = event.target.name;
        let blankRow = this.blankRow;
        blankRow[eventName].FirstName = event.target.value;
        this.blankRow = blankRow;
    }

    setLastName(event){
        const eventName = event.target.name;
        let blankRow = this.blankRow;
        blankRow[eventName].LastName = event.target.value;
        console.log(this.AccountID);
        this.blankRow = blankRow;
    }
    // setAccountId(accountId)
    // {
    //     this.AccountID=accountId;
    //     console.log(this.AccountID);
    // }
    // handleAccountId(event){
    //     let accountId = event.target.name;
    //     this.selectedAccount = accountId;
    //     this.setAccountId(this.selectedAccount);
    // }
    addRow(event){
        this.AccountID=event.target.name;
        console.log('add : '+this.AccountID);
        this.hideSave=true;
        this.index++;
        let i = this.index;
        let newContact = new Object();
        let blankRow = this.blankRow;
        newContact.Id = i;
        //newContact.isChecked = false;
        blankRow.push(newContact);
        this.blankRow = blankRow; 
    }
    deleteContact(event)
    {
        console.log('Entered For Delete');
        deleteContactData({conId:event.target.name}).then(result=>{
            const evt = new ShowToastEvent({
                message: 'Contact Deleted Successfully ',
                variant: 'success',
            });
            this.dispatchEvent(evt);
            eval("$A.get('e.force:refreshView').fire();");
            
        }).catch(error=>{
            console.error('Error while deleting Record '+error);
        })

    }
}