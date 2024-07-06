@isTest
public class TestVerifyDate 
{
	@isTest static void testDate()
    {
        Date date1=Date.newInstance(2018,3,18);
        Date date2=Date.newInstance(2018,4,10);
        VerifyDate.CheckDates(date1,date2);
    }
    @isTest static void testDate2()
    {
        Date date1=Date.newInstance(2018,3,18);
        Date date2=Date.newInstance(2018,4,17);
        VerifyDate.CheckDates(date1,date2);
    }
}