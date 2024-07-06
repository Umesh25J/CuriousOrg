import { LightningElement } from 'lwc';

export default class TestWebTOCaseDirect extends LightningElement {
    modelValues = [];
    refundValues = [];
    descriptionValue = '';
    descrip = '';

    handleInputChange(event) {
        const { name, value } = event.target;
        if (name.startsWith('model')) {
            this.modelValues[parseInt(name.slice(-1)) - 1] = value;
        } else if (name.startsWith('refund')) {
            this.refundValues[parseInt(name.slice(-1)) - 1] = value;
        } else if (name === 'description') {
            this.descriptionValue = value;
        }
    }
    requestForm(event) {
        const formElement = this.template.querySelector('form');
        const testFieldArea = this.template.querySelector('textarea');
        
        this.descrip += this.descriptionValue +'  Modal Numbes:-' +this.modelValues + '  Refund Percentage:-' + this.refundValues ;
        testFieldArea.value = this.descrip;

        
        formElement.setAttribute('action', 'https://webto.salesforce.com/servlet/servlet.WebToCase?encoding=UTF-8&orgId=00D5j000008cATU');
        formElement.setAttribute('method', 'POST');
        formElement.submit();
    }
    /*handleInputChange(event) {
        const { name, value } = event.target;
        if (name.startsWith('model')) {
            this.modelValues[parseInt(name.slice(-1)) - 1] = value;
        } else if (name.startsWith('refund')) {
            this.refundValues[parseInt(name.slice(-1)) - 1] = value;
        } else if (name === 'description') {
            this.descriptionValue = value;
        }
        //console.log(this.modelValues);
        //console.log(this.refundValues);
        //console.log(this.descriptionValue);
    }
    requestForm(event) {
        //event.preventDefault();
        const formElement = this.template.querySelector('form');
        console.log('formElement', formElement);
        //console.log('Form ID:', formElement.id);
        //console.log('Form Action:', formElement.action);
        const testFieldArea = this.template.querySelector('textarea');
        console.log('testFieldArea', testFieldArea);
        // Combine model numbers and refund percentages into the description
        let description = '';
        console.log(this.modelValues.length);
        for (let i = 0; i < this.modelValues.length; i++) {
            description += `Model Number ${i + 1}: ${this.modelValues[i]}\n`;
            description += `Refund Percentage ${i + 1}: ${this.refundValues[i]}\n\n`;
        }
        description += `Additional Description: ${this.descriptionValue}`;
        
        this.descrip += this.descriptionValue +'  Modal Numbes' +this.modelValues + '  ---' + this.refundValues ;
        testFieldArea.value = this.descrip;
        //console.log('this.modelValues'+this.modelValues);
        //console.log('refundValues'+this.refundValues);
        //console.log('descriptionValue'+this.descriptionValue);
        //formElement.description.value = this.descrip;
        //console.log('this.descrip'+this.descrip);
        //console.log('formElement.description'+formElement.description);
        // Dynamically set the action attribute
        formElement.setAttribute('action', 'https://webto.salesforce.com/servlet/servlet.WebToCase?encoding=UTF-8&orgId=00D5j000008cATU');
        
        // Dynamically set the method attribute
        formElement.setAttribute('method', 'POST');
    
        // Optionally, you can submit the form programmatically
        formElement.submit();
    }*/
}