public with sharing class TimeReportingController {
	
    Contact contact {get; set;}
    List<CContact> cContacts {get; set;}
    
    public TimeReportingController() {
        contact = new Contact();
    }
    
    
    public List<CContact> getContacts() {
        if(cContacts == null) {
            cContacts = new List<CContact>();
            
            for(Contact c: [SELECT Name FROM Contact LIMIT 5]) {
                cContacts.add(new CContact(c, new Project__c(), new Task__c(), new Billing_Rule__c(), new Time__c()));
            }
        }
        return cContacts;
    }    
    
    public class CContact {
        
        public Contact cont {get; set;}
        public Project__c project {get; set;}
        public Task__c task {get; set;}
        public Billing_Rule__c billingRule {get; set;}
        public Time__c calendarTime {get; set;}
        
        public CContact(Contact c, Project__c p, Task__c task, Billing_Rule__c b, Time__c t) {
            this.cont = c;
            this.project = p;
            this.task = task;
            this.billingRule = b;
            this.calendarTime = t;
        }
        
    }
    
}