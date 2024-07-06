import { LightningElement } from 'lwc';

export default class WebToCaseForm extends LightningElement {
    requestForm(){
        //debugger;
        /*var input = document.getElementById("name");
        console.log('input--'+input);
        console.log('dis--'+document.getElementById("description"));
        var description = document.getElementById("description");
        var modelValues = [];
        var refundValues = [];

        var modelFieldIds = ["model1", "model2", "model3"];

        for (var i = 0; i < modelFieldIds.length; i++) {
            var field = document.getElementById(modelFieldIds[i]);
            if (field && field.value.trim() !== "") {
                modelValues.push(field.value);
            }
        }
        console.log('modalfields'+modelValues);
    
        var refundFieldIds = ["refund1", "refund2", "refund3"];

        for (var i = 0; i < refundFieldIds.length; i++) {
            var field = document.getElementById(refundFieldIds[i]);
            if (field && field.value.trim() !== "") {
                refundValues.push(field.value);
            }
        }

        // Construct description text
        var descriptionText = "";
        if (modelValues.length > 0) {
            descriptionText += " Model Numbers: " + modelValues.join(", ") + "\n";
        }
        if (refundValues.length > 0) {
            descriptionText += "Refund Percentages: " + refundValues.join(", ") + "\n";
        }
        // Append to description field
        description.value += descriptionText;
        console.log('descriptionField'+descriptionText);
        console.log('description.value'+description.value);

        // Set action and method attributes of the form
        var form = document.getElementById("caseForm");
        form.action = "https://webto.salesforce.com/servlet/servlet.WebToCase?encoding=UTF-8&orgId=00D5j000008cATU";
        form.method = "POST";

        // Submit the form
        form.submit();*/
    }
}
/*import { LightningElement, api } from 'lwc';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import { createRecord ,updateRecord} from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

//import COMMUNICATION_OBJECT from '@salesforce/schema/Communication__c';
//import HEADER_FIELD from '@salesforce/schema/Communication__c.Header__c';
//import AUDIENCE_FIELD from '@salesforce/schema/Communication__c.Audience__c';
//import SEND_EMAIL_FIELD from '@salesforce/schema/Communication__c.Send_Email_To_Leadership__c';
//import FROM_FIELD from '@salesforce/schema/Communication__c.From__c';
//import EXPIRATION_FIELD from '@salesforce/schema/Communication__c.Expiration_Date__c';
//import SUBJECT_FIELD from '@salesforce/schema/Communication__c.Subject__c';
//import BODY_FIELD from '@salesforce/schema/Communication__c.Body__c';
import { NavigationMixin } from 'lightning/navigation';

export default class WebToCaseForm extends NavigationMixin(LightningElement) {
//@api recordId;
    /*communicationObject = COMMUNICATION_OBJECT;
    headerField = HEADER_FIELD;
    audienceField = AUDIENCE_FIELD;
    sendToLeadership = SEND_EMAIL_FIELD;
    fromField = FROM_FIELD;
    expirationDateField = EXPIRATION_FIELD;
    subjectField = SUBJECT_FIELD;
    bodyField = BODY_FIELD;
    toggleSpinner = false;
    recordId;

   handleSubmit(event){
    this.toggleSpinner = true;
    }

    handleRecordCreate(event){
        
        this.recordId = event.detail.id;
        this.dispatchEvent(
            new ShowToastEvent({
                title: "Success",
                message: "Record created successfully!",
                variant: "success"
            })
        );
        this.toggleSpinner = false;
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.recordId,
                objectApiName: 'Communication__c',
                actionName: 'view'
            }
        });
    }
    
    
}*/

/*import { LightningElement, api,track } from 'lwc';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import { createRecord} from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import { CloseActionScreenEvent } from "lightning/actions";

import COMMUNICATION_OBJECT from '@salesforce/schema/Communication__c';
import HEADER_FIELD from '@salesforce/schema/Communication__c.Header__c';
import AUDIENCE_FIELD from '@salesforce/schema/Communication__c.Audience__c';
import SEND_EMAIL_FIELD from '@salesforce/schema/Communication__c.Send_Email_To_Leadership__c';
import FROM_FIELD from '@salesforce/schema/Communication__c.From__c';
import EXPIRATION_FIELD from '@salesforce/schema/Communication__c.Expiration_Date__c';
import SUBJECT_FIELD from '@salesforce/schema/Communication__c.Subject__c';
import BODY_FIELD from '@salesforce/schema/Communication__c.Body__c';

export default class CommunicationPageLWC extends NavigationMixin(LightningElement) {
    @api recordId;
    @track communicationRecord = '';
    @track headerField = '';
    @track audienceField;
   @track sendToLeadership = false;
   @track fromField = '';
   @track expirationDateField ='';
   @track subjectField='';
   @track bodyField='';
   @track selectedLookupValue;
   @track lookupErrors = [];

   toggleSpinner = false;

    headerOptions = [
        {label: 'Online Contact Centers',value: 'Online Contact Centers'},
        {label: 'Tempe Contact Center',value: 'Tempe Contact Center'},
        {label: 'Ogden Contact Center',value: 'Ogden Contact Center'},
        {label: 'Kennesaw Contact Center',value: 'Kennesaw Contact Center'},
        {label: 'Customer Care',value: 'Customer Care'}

    ];

    handleChangeHeader(event) {
        this.headerField = event.target.value;
    }
    handleChangeAudience(event) {
        this.audienceField = event.target.value;
    }
    handleChangeSendTo(event) {
        this.sendToLeadership = event.target.checked;
        console.log('sendToLeadership--'+event.target.value);
        console.log('this. sendToLeadership--'+this.sendToLeadership);
    }
    handleChangeFrom(event) {
        this.fromField= event.target.value;
        
    }
    handleChangeExpDate(event) {
        this.expirationDateField = event.target.value;
        console.log('date--'+event.target.value);
        console.log('this. date--'+this.expirationDateField);
    }
    handleChangeSubject(event) {
        this.subjectField = event.target.value;
    }
    handleChangeBody(event) {
        this.bodyField = event.target.value;
    }

    createCommunicationRecord(){
        this.toggleSpinner = true;
        const fields = {};
        fields[HEADER_FIELD.fieldApiName] = this.headerField;
        fields[AUDIENCE_FIELD.fieldApiName] = this.audienceField ? this.audienceField[0] : null;
        fields[SEND_EMAIL_FIELD.fieldApiName] = this.sendToLeadership;
        fields[FROM_FIELD.fieldApiName] = this.fromField;
        fields[EXPIRATION_FIELD.fieldApiName] = this.expirationDateField;
        fields[SUBJECT_FIELD.fieldApiName] = this.subjectField;
        fields[BODY_FIELD.fieldApiName] =  this.bodyField;

        console.log('header'+this.headerField);
        console.log('Audience'+this.audienceField);
        console.log('SendEmail'+this.sendToLeadership);
        console.log('from '+this.fromField);
        console.log('date'+this.expirationDateField);
        console.log('Subject'+this.subjectField);
        console.log('Body'+this.bodyField);

        const recordInput = {apiName: COMMUNICATION_OBJECT.objectApiName, fields};
        console.log('beforecreate');
        createRecord(recordInput)
        .then(result =>{
            this.recordId = result.id;
            console.log('result--'+ JSON.stringify(result));
            console.log(result.id);
            this.toggleSpinner = false;
            this.dispatchEvent(
                new ShowToastEvent({
                    title: "Success",
                    message: "Record created successfully!",
                    variant: "success"
                })
            );
            this[NavigationMixin.Navigate]({
                type: 'standard__recordPage',
                attributes: {
                    recordId: this.recordId,
                    objectApiName: 'Communication__c',
                    actionName: 'view'
                }
            });
        })
    }

    backToListView(){
        this.dispatchEvent(new CloseActionScreenEvent());
    }
}*/
/**/