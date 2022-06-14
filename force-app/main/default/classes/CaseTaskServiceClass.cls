public with sharing class CaseTaskServiceClass {
    //If there are more values coming in future 
    //then these constants can be replaced with custom metadata or custom settings
    private static string PRIMARY = 'Primary';
    private static string SECONDARY = 'Secondary';
    private static string TERTIARY = 'Tertiary';

    private static string HIGH = 'High';
    private static string MEDIUM = 'Medium';
    private static string LOW = 'Low';
    

    public static void caseCreation(List<Contact> contacts){
        Map<String,String> mapContactPriority = 
                    new Map<String,String>();
        mapContactPriority.put(PRIMARY,HIGH);
        mapContactPriority.put(SECONDARY,MEDIUM);
        mapContactPriority.put(TERTIARY,LOW);

        List<Case> casesList = new List<Case>();
      
        for (Contact cont : contacts) {
            Case caseNew = new Case();
                caseNew.Subject = 'New Case for' + cont.Name;
                caseNew.Type = 'Newcontact';
                caseNew.Status = 'Working';
                caseNew.Origin = 'New Contact';
                caseNew.ownerId = cont.ownerId;
                caseNew.AccountId = cont?.AccountId;
                caseNew.Priority = mapContactPriority.get(cont.Priority__c); //Low,Medium,High
                casesList.add(caseNew);
         
        }
        
        try {
        insert casesList;
        taskCreation(casesList);
        }
        catch(DmlException e) {
         System.debug('The following exception has occurred: ' + e.getMessage());

            //errorobject
        }
    }

     public static void taskCreation(List<case> cases){
  
        Map<String,Date> mapTaskpriority = 
                    new Map<String,Date>();

        mapTaskpriority.put(HIGH,Date.Today() + 7);
        mapTaskpriority.put(MEDIUM, Date.Today() + 14);
        mapTaskpriority.put(LOW,Date.Today() + 21);

        List<Task> tasksList = new List<Task>();

        for (Case caseNew : cases) {

                Task tsk = new Task();
                tsk.Subject = 'Welcome call for' + caseNew.CaseNumber ;
                tsk.Status = 'Not Started';
                tsk.Priority = 'Normal';
                tsk.ActivityDate = mapTaskpriority.get(caseNew.Priority);
                tsk.OwnerId = caseNew.OwnerId;
                tasksList.add(tsk);
           
        }
        try {
        insert tasksList;

        }
        catch(DmlException e) {

        System.debug('The following exception has occurred: ' + e.getMessage());
            //Or errorobject needs to be created insert those details
        
        }

    }

}