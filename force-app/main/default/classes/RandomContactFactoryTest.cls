@isTest
public class RandomContactFactoryTest 
{
	@isTest static void RandomContactFactoryTesting() {
        // Test data setup
        Contact[] contcts = RandomContactFactory.generateRandomContacts(100,'Testing');
        // Perform test
        Test.startTest();
        Database.SaveResult[] results = Database.insert(contcts, false);
        Test.stopTest();
        // so check that we got back an error.
        for(Database.SaveResult dr : results) {
            System.assert(!dr.isSuccess());
            System.assert(dr.getErrors().size() > 0);
            System.assertEquals('Cannot insert multiple contact with same pattern name.',
                                 dr.getErrors()[0].getMessage());
        }
    }
}