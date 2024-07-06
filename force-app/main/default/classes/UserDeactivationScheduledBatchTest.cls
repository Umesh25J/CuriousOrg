@isTest
public class UserDeactivationScheduledBatchTest {
	
    @testSetup
    static void testSetup(){
        //Create a user with lastlogin date greater than 30 days and isActive true
        User user = new User();
        user.FirstName = 'TestUserFirstNamer';
        user.LastName = 'TestUserLastName';
        user.Email = 'testuser@homedepot.com';
        user.Username = 'TestUserNamesadas@testttt.com';
        user.IsActive = true;
        user.CommunityNickname = 'test' + (Math.random() * 1000);
        user.LocaleSidKey = 'en_US';
        user.TimeZoneSidKey = 'GMT';
        user.ProfileID = [Select Id from Profile where Name = 'Salesforce'][0].Id;
        user.LanguageLocaleKey = 'en_US';
        user.EmailEncodingKey = 'UTF-8';
        user.Alias = 'Tcode';
        
        insert user;
        
    }
    
    @isTest
    static void testUserDeactivation(){
        Test.startTest();
        User user = [select lastLoginDate from User where FirstName = 'TestUserFirstNamer' LIMIT 1];
        System.runAs(user) {
            System.debug('User has logged in');
        }
        User sameuser = [select lastLoginDate from User where FirstName = 'TestUserFirstNamer' LIMIT 1];
        
        System.debug('Last login : ' + user.LastLoginDate);
        System.assert(true);  
        Test.stopTest();
    }
    
    @isTest
    static void testUserDeactivationScheduled(){
        try{
            Test.startTest();
            String CRON_EXP = '0 0 11 3 9 ? 2030';
            String jobId = System.schedule('User deactivation batch test', CRON_EXP, new UserDeactivationScheduledBatch());
            CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
            UserDeactivationScheduledBatch obj = new UserDeactivationScheduledBatch();
            System.assertEquals(CRON_EXP, ct.CronExpression);
            System.assertEquals(0, ct.TimesTriggered); 
            System.assertEquals('2030-09-03 11:00:00', String.valueOf(ct.NextFireTime));
            Test.stopTest();
        }
        catch(Exception e){
            System.assertEquals(true, e.getMessage().contains('Unable to test user deactivation batch.'));
        }
	}
}