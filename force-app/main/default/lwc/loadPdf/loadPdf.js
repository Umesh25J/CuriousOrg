import { LightningElement, api, wire } from 'lwc';
import { loadScript } from 'lightning/platformResourceLoader';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import PDF from '@salesforce/resourceUrl/pdf';
//import pdfjsLibBuild from '@salesforce/resourceUrl/pdf_worker';
//import pdfjsLibSandbox from '@salesforce/resourceUrl/pdf_sandbox';

export default class LoadPdf extends LightningElement {
     @api recordId;

    connectedCallback() {
         Promise.all([loadScript(this, PDF)])
            .catch(error => {
                this.showErrorToast(error);
            });/**/
            // this.loadPdfJsLibs();
    }

    async loadPdfJsLibs() {
        try {
            await loadScript(this,pdfjsLibWeb);
            //await loadScript(this,pdfjsLibBuild);
            //await loadScript(this,pdfjsLibSandbox);
        } catch (error) {
            this.showErrorToast(error);
        }
    }

    /*loadScript(scriptUrl) {
        return new Promise((resolve, reject) => {
            const script = document.createElement('script');
            script.src = scriptUrl;
            script.onload = resolve;
            script.onerror = () => reject(`Failed to load script ${scriptUrl}`);
            document.body.appendChild(script);
        });
    }*/

    handleUploadFinished(event) {
        const uploadedFiles = event.detail.files;
        if (uploadedFiles.length > 0) {
            const file = uploadedFiles[0];
            if (file.mimetype === 'application/pdf') {
                const reader = new FileReader();
                reader.onloadend = () => {
                    const pdfContent = reader.result;
                    const event = new CustomEvent('pdfloaded', {
                        detail: { pdfContent },
                    });
                    this.dispatchEvent(event);
                };
                reader.readAsArrayBuffer(file);
            } else {
                this.showErrorToast('Unsupported file type. Please upload a PDF file.');
            }
        }
    }

    showErrorToast(error) {
        const event = new ShowToastEvent({
            title: 'Error',
            message: error,
            variant: 'error',
        });
        this.dispatchEvent(event);
    }
}