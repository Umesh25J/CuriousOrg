import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { createRecord } from 'lightning/uiRecordApi';
import CASE_OBJECT from '@salesforce/schema/Case';
import LINE_ITEM_OBJECT from '@salesforce/schema/Line_Item__c';

export default class CaseCreationSaveTheSales extends LightningElement {
    @track subject = '';
    @track description = '';
    @track ordernumber = '';
    @track modalNumber = '';
    @track refundPercentage = '';
    @track buildingNumber = '';
    @track lineItems = [{ modalNumber: '', refundPercentage: '' }];

    handleSubjectChange(event) {
        this.subject = event.target.value;
    }

    handleDescriptionChange(event) {
        this.description = event.target.value;
    }

    handleOrderNumberChange(event) {
        this.ordernumber = event.target.value;
    }

    handleModalNumberChange(event) {
        this.modalNumber = event.target.value;
    }

    handleRefundPercentageChange(event) {
        this.refundPercentage = event.target.value;
    }

    handleBuildingNumberChange(event) {
        this.buildingNumber = event.target.value;
    }

    addLineItem() {
        this.lineItems.push({ modalNumber: '', refundPercentage: '' });
    }

    createCase() {
        const fields = {
            Subject: this.subject,
            Description: this.description,
            Status: 'New',
            Priority: 'High',
            Order_Number__c: this.ordernumber,
            Origin: 'Web',
            Building_Number__c: this.buildingNumber
        };
        const recordInput = { apiName: CASE_OBJECT.objectApiName, fields };

        createRecord(recordInput)
            .then(result => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Case created: ' + result.id,
                        variant: 'success',
                    }),
                );
                //this.createLineItems(result.id);
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body ? error.body.message : 'Unknown error From 1',
                        variant: 'error',
                    }),
                );
            });
    }

    createLineItems(caseId) {
        const promises = this.lineItems.map(item => {
            const fields = {
                Modal_Number__c: item.modalNumber,
                Refund_Percentage__c: item.refundPercentage,
                Case__c: caseId
            };
            const recordInput = { apiName: LINE_ITEM_OBJECT.objectApiName, fields };
            return createRecord(recordInput);
        });

        Promise.all(promises)
            .then(results => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Line Items created',
                        variant: 'success',
                    }),
                );
                this.clearFields();
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating Line Items',
                        message: error.body ? error.body.message : 'Unknown error From 2',
                        variant: 'error',
                    }),
                );
            });
    }

    removeLineItem(event) {
        const index = event.target.dataset.index;
        this.lineItems.splice(index, 1);
        this.lineItems = [...this.lineItems];
    }

    clearFields() {
        this.subject = '';
        this.description = '';
        this.ordernumber = '';
        this.modalNumber = '';
        this.refundPercentage = '';
    }
}