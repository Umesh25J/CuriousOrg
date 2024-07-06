public class unusedMetadataCheck {

	public static String getDependentMetadataComponents() {
        // Tooling API query to retrieve dependencies of triggers, Visualforce pages, and custom objects
        String query = 'SELECT RefMetadataComponentName, RefMetadataComponentId, MetadataComponentName, RefMetadataComponentType ' +
                       'FROM MetadataComponentDependency ' +
                       'WHERE RefMetadataComponentType IN (\'ApexClass\', \'ApexTrigger\', \'ApexPage\', \'CustomObject\')';
        
        // Make the Tooling API request
        Http httpProtocol = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm() +
                        '/services/data/v47.0/tooling/query/?q=' +
                        EncodingUtil.urlEncode(query, 'UTF-8'));
        req.setMethod('GET');
        req.setHeader('Authorization', 'OAuth ' + UserInfo.getSessionId());
        HttpResponse resp = httpProtocol.send(req);
        return resp.getBody();
    }
    public static void getMetadataComponents() {

		String query = 'SELECT RefMetadataComponentName, RefMetadataComponentId, MetadataComponentName, RefMetadataComponentType ' +
                       'FROM MetadataComponentDependency ' +
                       'WHERE RefMetadataComponentType IN (\'ApexClass\', \'ApexTrigger\', \'ApexPage\', \'CustomObject\')';
        
       	HttpRequest req = new HttpRequest();
        req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
        req.setHeader('Content-Type', 'application/json');
        
        req.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm() +'/services/data/v58.0/tooling/query/?q=Select+id,Name+from+MetadataContainer');
		req.setMethod('GET');
        
        Http h = new Http();
        HttpResponse res = h.send(req);
        system.debug(res.getBody());

    }

}