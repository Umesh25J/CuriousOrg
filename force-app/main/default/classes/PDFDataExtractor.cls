public with sharing class PDFDataExtractor {
   // Define the API endpoint for PDF extraction
    private static final String PDF_EXTRACTION_ENDPOINT = 'https://app.docparser.com/myaccount/api';

    public static String extractTextFromPdf(Blob pdfBlob) {
        // Convert the PDF blob to a base64-encoded string
        String base64Pdf = EncodingUtil.base64Encode(pdfBlob);

        // Create an HTTP request
        HttpRequest request = new HttpRequest();
        request.setEndpoint(PDF_EXTRACTION_ENDPOINT);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Authorization', '1e749511d7f8d0badb8a2bffc31693e152776a51'); // Replace with your Docparser API key

        // Create the request body
        Map<String, Object> requestBody = new Map<String, Object>();
        requestBody.put('data', base64Pdf);
        //requestBody.put('remote_id', 'unique_id'); // Replace with your desired unique ID for the document
        String requestBodyJson = JSON.serialize(requestBody);
        System.debug('requestBodyJson'+requestBodyJson);
        request.setBody(requestBodyJson);

        // Send the request and get the response
        HttpResponse response = new Http().send(request);
        String responseBody = response.getBody();
        System.debug('responseBody'+responseBody);

        // Parse the JSON response
        /*Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(responseBody);
        String extractedText = (String) responseMap.get('text');*/
        String extractedText = 'dfsdfgsfg';

        return extractedText;
    }
    public static void createRecord() {
        // Implement the logic to create a record using the transformed data
        // Use appropriate Salesforce APIs or libraries to create the record
        String file_title = 'sample';

        List<ContentVersion> files = [SELECT Id, Title, IsLatest, VersionData FROM ContentVersion WHERE Title = :file_title AND IsLatest = true];

        String files_txt = files[0].VersionData.toString();
        System.debug('files_txt'+files_txt);
    }
}