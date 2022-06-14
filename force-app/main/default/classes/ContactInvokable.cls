public class ContactInvokable {
    @InvocableMethod
    public static void ProcessContactsForCases(List<Id> contactIds)
    {
         List<Contact> lstContacts =  
         [SELECT Id,Name,ownerId,Priority__c,
         AccountId FROM Contact WHERE Id in :contactIds];
         CaseTaskServiceClass.caseCreation(lstContacts);

    }
}