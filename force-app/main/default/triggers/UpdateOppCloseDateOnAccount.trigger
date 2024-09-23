//To Update Last Opportunity Close Date on Account

trigger UpdateOppCloseDateOnAccount on Opportunity (after insert,after update) {
    Set<Id> accountId = new Set<Id>();

    For(Opportunity op : Trigger.new){
            if(op.AccountId!=null && op.StageName='Closed Won'){
                accountId.add(op.AccountId);
            }
        }

        Map<Id,Account> accMap = new Map<Id,Account>();
        List<Account> accountList = [
            SELECT Id, oppCloseDate__c,
                   (SELECT CloseDate FROM Opportunities 
                    WHERE StageName = 'Closed Won' 
                    ORDER BY CloseDate DESC LIMIT 1)
            FROM Account
            WHERE Id IN :accountId
        ];

        List<Account> accountsToUpdate = new List<Account>();

        for (Account acc : accountList) {
            if (acc.Opportunities.size() > 0) {
                acc.OppCloseDate__c = acc.Opportunities[0].CloseDate;
                accountsToUpdate.add(acc);
            }
        }

        // Perform update on the accounts
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }

   