import { LightningElement,wire } from 'lwc';
import getUnReferencedClasses from '@salesforce/apex/ApexDependencyController.getUnReferencedClasses';

export default class ChechUnusedMetadata extends LightningElement {

    unreferencedClasses;

    // Call the Apex method using wire adapter
    @wire(getUnReferencedClasses)
    wiredUnreferencedClasses({ error, data }) {
        if (data) {
            this.unreferencedClasses = data;
        } else if (error) {
            // Handle any error during the wire method call
            console.error('Error retrieving unreferenced classes:', error);
        }
    }
    searchInput;
    classes ;
    error;

    connectedCallback(){
        console.log(this.unreferencedClasses);
    }
    handleOnChange(event){
        this.searchInput=event.detail.value;
        console.log(this.searchInput);
    }

}