@isTest
private class CaseTaskServiceClassTest {

    private static testMethod void doTest() {

        Test.startTest();
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        Contact con = new Contact(Name = 'Test Proximity',
                     Company = 'Test Proximity Company',
                     Priority = 'High',AccountId = acc?.AccountId);
        insert con;

        Test.stopTest();

        Case case = [Select CaseNumber From Case where AccountId = :acc.AccountId];
        System.assertNotEquals(case.CaseNumber, null,'Case is created');

        List<Task> task = [Select Id, Subject From Task];

        System.assertEquals(task.Size(), 1,'Task is created');
        System.assert(task[0].Subject.contains(case.CaseNumber));
    }
}