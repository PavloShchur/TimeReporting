@isTest
public class OpportunityTriggerTest {
    
    @testSetup static void setup() {
        
        List<Opportunity> opptyListToUpdate = new List<Opportunity>();
        
        for(Integer i = 0; i < 10; i++) {
            opptyListToUpdate.add(new Opportunity(Name = 'testOpportunity_' + i, StageName = 'Prospecting', 
                                                       CloseDate = Date.today().addDays(1), Description = 'testDescription', Probability = 70));
        }
        
        insert opptyListToUpdate;

    }
    
    testmethod static void createOpportunity_ProbabilityMoreThan80WithRelatedProject(){
        
        Test.startTest();
        insert new Opportunity(Name = 'test_1', StageName = 'Prospecting', CloseDate = Date.today().addDays(1), 
                               Description = 'testDescription', Probability = 85);
        Test.stopTest();
      
        System.assertEquals([SELECT Opportunity__c FROM Project__c WHERE Name = 'test_1'].Opportunity__c, 
                            [SELECT Id FROM Opportunity WHERE Name = 'test_1' AND Probability = 85 AND StageName = 'Prospecting'].Id);
        
    }
    
    testmethod static void createOpportunity_ProbabilityLessThan80WithoutRelatedProject(){
        
        Test.startTest();
        insert new Opportunity(Name = 'test_2', StageName = 'Prospecting', CloseDate = Date.today().addDays(1), 
                               Description = 'testDescription', Probability = 10);
        Test.stopTest();
        
        System.assertEquals(true, [SELECT Opportunity__c FROM Project__c WHERE Name = 'test_2'].isEmpty());
        
    }
    
    testmethod static void updateOpportunity_ProbabilityLessThan80ToMoreThan80WithRelatedProject(){
        
        List<Opportunity> opportunitiesFromSetup = [SELECT Name FROM Opportunity WHERE Probability = 70];
        
        for(Opportunity opptyItem :opportunitiesFromSetup){
            opptyItem.Probability = 85;
            opptyItem.Name = 'testOpportunityList';
        }
        
        Test.startTest();
        update opportunitiesFromSetup;
        Test.stopTest();
        
        List<Project__c> projects = [SELECT Opportunity__c FROM Project__c WHERE Name = 'testOpportunityList'];
        
        System.assertEquals(opportunitiesFromSetup.size(), projects.size());
        
        for(Opportunity opptyItem :opportunitiesFromSetup){
            System.assertEquals([SELECT Opportunity__c FROM Project__c WHERE Opportunity__c = :opptyItem.Id].Opportunity__c, 
                            [SELECT Id FROM Opportunity WHERE Id = :opptyItem.Id].Id);
        }        
        
    }

}