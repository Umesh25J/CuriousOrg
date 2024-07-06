public class ParentsChild {
	 //get the name of the child relationship based on the name of the Parent object and the name of the child object
    public static String getChildRelationshipName(String parentsObj, String childsObj) {

        //Create sobject Instance 
        sObject dynamicObj = (SObject)Type.forName(parentsObj).newInstance();
        //get the type token
        SObjectType sObjType = dynamicObj.getSObjectType();
        //get describe
        DescribeSobjectResult sObjDescribe = sObjType.getDescribe();
        //loop through children
        for(Schema.ChildRelationship rels :sObjDescribe.getChildRelationships()){
            //find the child
            if(String.ValueOf(rels.getChildSObject()) == childsObj){
                return rels.getRelationshipName();
            }
        }
        return null;
    }

//returns map of childrelationships based on the child Object name
    public static Map<String, ChildRelationship> getChildRelationshipMap(String parentsObj){

        Map<String, ChildRelationship> sObjChildRelationshipName = new Map<String, ChildRelationship>();
        //Create sobject Instance 
        sObject dynamicObj = (SObject)Type.forName(parentsObj).newInstance();
        //get the type token
        SObjectType sObjType = dynamicObj.getSObjectType();
        //get describe
        DescribeSobjectResult sObjDescribe = sObjType.getDescribe();
        //loop through children
        for(Schema.ChildRelationship rels :sObjDescribe.getChildRelationships()){
            //put the child in map
            sObjChildRelationshipName.put(String.ValueOf(rels.getChildSObject()), rels);
        }
        return sObjChildRelationshipName;
    }
}