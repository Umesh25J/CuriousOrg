public class AccountUtility 
{
	public static void viewAnnualRevenue()
    {
        List<Account> accountsList = [SELECT Name, AnnualRevenue FROM Account];
        for (Account acc : accountsList){
            String acctRev = 'First Name: ' + acc.Name + ', Last Name: ' + acc.AnnualRevenue;
            system.debug(acctRev);
        }
    }
}