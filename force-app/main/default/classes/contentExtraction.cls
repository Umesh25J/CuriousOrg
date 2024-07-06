public class contentExtraction {

    public static void Method()
    {
        List<ContentDocument> docx=new List<ContentDocument>([SELECT Id, Title, ContentAssetId FROM ContentDocument]);
        System.debug(docx);
        List<Id> ids=new List<Id>();
        for(ContentDocument doc:docx)
        {
            ids.add(doc.ID);
        }
        List<ContentVersion> docxContent =new List<ContentVersion>([SELECT Id,TextPreview, ContentUrl, FileType,Origin,VersionData,Title FROM ContentVersion WHERE ContentDocumentId = :ids[3] AND IsLatest = true]);
        System.debug(docxContent);
        for(ContentVersion con:docxContent)
        {
            System.debug(con);
        }
        /*List<ContentDocumentLink> conDocLinks=new List<ContentDocumentLink>([SELECT Id, ContentDocumentId,ShareType,Visibility FROM ContentDocumentLink WHERE LinkedEntityId = '0015j00000fS0e0AAC']);
        System.debug(conDocLinks);*/
        System.debug(docxContent[0].VersionData);
        Blob csvBlob =(docxContent[0].VersionData);
        System.debug(csvBlob);
        String s = EncodingUtil.base64Encode(csvBlob);
 		System.debug(s);
        
        //String extractedText = PDFDataExtractor.extractTextFromPdf(csvBlob);

        // Output the extracted text
        //System.debug(extractedText);
        // Decode the base64-encoded string back into a Blob
		/*Blob decodedBlob = EncodingUtil.base64Decode(s);

		// Convert the Blob to a string
		String decodedString = decodedBlob.toString();

        // Output the decoded string
        System.debug(decodedString);
        /*String s1 = EncodingUtil.base64Decode(s).toString(); 
        System.debug(s1);
        String str = s1.replaceAll('\\s','');
        System.debug(str);
       
        String name=s1.substring(6,s1.IndexOf('Phone:-'));
        String phone=s1.substring(s1.IndexOf('Phone:-')+7, s1.indexOf('Price:-'));
        String price=s1.substring(s1.indexOf('Price:-')+7,s1.length());
        System.debug(name+' '+phone+' '+price);
        /*String bodyEncoded = EncodingUtil.base64Encode(docxContent[0].versiondata);
    	Http http = new Http();
    	HttpRequest request = new HttpRequest();
    	request.setEndpoint('https://realpyth.herokuapp.com/get/fileService/');
    	request.setMethod('POST');
    	request.setHeader('Content-Type', 'application/json');
    	request.setBody('{"BlobData":"'+docxContent[0].versiondata+'"}'); // Send the data as Blob
    	//request.setBody('{"BlobData":"'+bodyEncoded+'"}'); // Convert the blob data and send as String
    	HttpResponse response = http.send(request);
    	if (response.getStatusCode() != 201) {
    		System.debug('=======' +response.getStatusCode() + ' ' + response.getBody());
    	} else {
    		System.debug('====response==='+response.getBody());
    	}*/
    }
}