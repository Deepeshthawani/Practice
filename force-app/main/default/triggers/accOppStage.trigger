//Write a trigger on the Account when the Account is updated check all opportunities related to the account. 
//Update all Opportunities Stage to close lost if an opportunity created date is greater than 30 days from today 
//and stage not equal to close won.

trigger accOppStage on Account (after update) {
    Set<Id> ac = new Set<Id>();
    For(Account a: Trigger.new){
        ac.add(a.id);
    }

    List<Opportunity> lstOpp = [Select id,StageName,CreatedDate,CloseDate from Opportunity where AccountId in :ac];
    List<Opportunity> lstOppToUpdate = new List<Opportunity>();

    Datetime day30 = System.today() - 30;

    If(!lstOpp.isEmpty()){
        For(Opportunity o : lstOpp){
            If(o.StageName != 'Closed Won' && o.CreatedDate < day30){
                o.StageName = 'Closed Lost';
                o.CloseDate = System.today();
                lstOppToUpdate.add(o);
            }
        }
    }

    If(!lstOppToUpdate.isEmpty()){
        update lstOppToUpdate;
    }
}