@isTest
private class CaseTaskServiceClassTest {

    private static testMethod void doTest() {

        Test.startTest();
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        ID acctID = acc.ID;
        Contact con = new Contact(ContactName__c  = 'Test Proximity',
        Priority__c = 'Primary',LastName = 'Proximity Last',AccountId = acctID);
        insert con;

        Test.stopTest();

        Case caseTest = [Select CaseNumber From Case];
        System.assertNotEquals(caseTest.CaseNumber, null,'Case is created');

        List<Task> task = [Select Id, Subject From Task];

        System.assertEquals(task.Size(), 1,'Task is created');
       
    }
}