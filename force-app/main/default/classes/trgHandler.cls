public class trgHandler
{
public static void trgMethod(List<Account> accList,Map<Id,Account> oldMap)
{
Set<Id> accIds = new Set<Id>();

if(!accList.isEmpty())
{
for(Account ac : accList)
{
if(ac.Close_all_Opps__c == true && oldMap.containsKey(ac.Id) && oldMap.get(ac.Id).Close_all_Opps__c == false)
{
accIds.add(ac.Id);
}
}
}

if(!accIds.isEmpty())
{
List<Opportunity> oppList = [Select Id,AccountId,Stagename from Opportunity where AccountId IN : accIds
and Stagename != 'Closed Won' and Probability >= 70];

List<Opportunity> listToUpdate = new List<Opportunity>();

if(!oppList.isEmpty())
{
for(Opportunity opp : oppList)
{
opp.Stagename = 'Closed Won';
opp.CloseDate = date.today();
listToUpdate.add(opp);
}
}

if(!listToUpdate.isEmpty())
{
update listToUpdate;
}
}
}
}