public class OpportunityTriggerHelper {
    
    // this method returns only those opportunities
    // whose Probabilty is greater than 80%
    public static List<Opportunity> filterOpportunities(Map<Id, Opportunity> oldMap, List<Opportunity> newList) {
        
        List<Opportunity> opportunities = new List<Opportunity>();
        
        if( ( oldMap == null && newList != null ) || ( oldMap != null && newList != null )) {
            
            for(Opportunity opportunityNew :newList) {
                if( oldMap == null && opportunityNew.Probability > 80 || ( oldMap != null && (opportunityNew.Probability > 80
                                                           &&(oldMap.get( opportunityNew.Id ).Probability != opportunityNew.Probability)))) {
                    opportunities.add(opportunityNew);
                }
            }
            
        }
        return opportunities;
    }
        
    public static void createProject(List<Opportunity> opportunities) {
        List<Project__c> projectsToInsert = new List<Project__c>();
        
        for(Opportunity opptyItem :createRelatedProject(opportunities)) {
            projectsToInsert.add(new Project__c(Name = opptyItem.Name, Description__c = opptyItem.Description, 
                                                Opportunity__c = opptyItem.Id, Primary_Contact__c = opptyItem.Account.Primary_Contact__c));
        }
        
        try{
            insert projectsToInsert; 
        } catch(DMLException e) {
            System.debug(e.getMessage());
        }
        
    }
    
    //this method ommit opportunities which already have related Project
    private static List<Opportunity> createRelatedProject(List<Opportunity> opportunities) {
        if(opportunities.isEmpty()) return new List<Opportunity>();
        
        List<Opportunity> filteredOpportunities = new List<Opportunity>();
        
        for(Opportunity opptyItem :opportunities) {
            if(opptyItem.Related_Projects__c == 0) { filteredOpportunities.add(opptyItem); }
        }
        return filteredOpportunities;
        
    }
    
}