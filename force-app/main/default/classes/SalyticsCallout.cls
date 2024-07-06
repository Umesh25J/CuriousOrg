@RestResource(urlMapping='/RestCallPosting/*')
global with sharing class SalyticsCallout {

    /*{	"sName":"Account Name",
		"sPhone":"8999878756",
		"sDescription":"tHjksdfg klsdjlk jasg",}*/
    @HttpPost
    global static String doPost(String sName, String sPhone,String sDescription){
    	Account objAcc =new Account();
        objAcc.name = sName;
        objAcc.Phone= sPhone;
        objAcc.Description=sDescription;
        
        return 'Account Successfully Created'+ objAcc.id;
    }
}