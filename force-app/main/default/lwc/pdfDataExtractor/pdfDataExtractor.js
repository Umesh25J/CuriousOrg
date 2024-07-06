import { LightningElement, track } from 'lwc';

export default class PdfDataExtractor extends LightningElement {
    @track pdfContent;

    handlePdfLoaded(event) {
        this.pdfContent = event.detail.pdfContent;
        console.log('this.pdfContent----1=='+this.pdfContent);
    }
}