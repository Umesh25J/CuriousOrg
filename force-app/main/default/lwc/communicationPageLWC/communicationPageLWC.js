import { LightningElement } from 'lwc';
import ToastContainer from 'lightning/toastContainer';
import Toast from 'lightning/toast';

export default class CommunicationPageLWC extends LightningElement {
    validateForm(){
        //document.getElementById("success-message").classList.remove("hidden");
        console.log('Possible');
        Toast.show({
            label: 'Success!update',
            // labelLinks : [{
            //     url: 'https://www.lightningdesignsystem.com/components/toast/',
            //     label: 'LDS link'
            // }, {
            //     url: 'https://www.lightningdesignsystem.com/accessibility/guidelines/global-focus/#toasts',
            //     label: 'toast guideline'
            // }],
            message: 'Markdown request submitted successfully',
            mode: 'sticky',
            variant: 'success'
        }, this);

    }
    connectedCallback() {
        const toastContainer = ToastContainer.instance();
        toastContainer.maxShown = 5;
        toastContainer.toastPosition = 'top-center';
    }

    /**/
    /*value = 'inProgress';
    get options() {
        return [
            { value: '01250000000RY0t', label: 'Opinion Lab Survey'},
        ];
    }
    handleChange(event) {
        this.value = event.detail.value;
    }
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
        const formElement = this.div.template.querySelector('form');
        const testFieldArea = this.div.template.querySelector('textarea');
        
        this.descrip += this.descriptionValue +'  Modal Numbes:-' +this.modelValues + '  Refund Percentage:-' + this.refundValues ;
        testFieldArea.value = this.descrip;

        formElement.setAttribute('action', 'https://warehouse--npdev.sandbox.my.salesforce.com/servlet/servlet.WebToCase?encoding=UTF-8&orgId=00DK000000XJkpI');
        formElement.setAttribute('method', 'POST');
        formElement.submit();
    }*/
}