//Create a field on User Object “Count”, On Account update Increment 1 in count field and 
//on delete of account decrement count by 1.

trigger updateUserCountAcc on Account (after update,after delete) {
    Set<Id> oid = new Set<Id>();
    Map<Id,User> userCountMap = new Map<Id,User>();
    List<User> lstUserToUpdate = new List<User>();
    List<User> lstUserToUpdate1 = new List<User>();
    If(Trigger.isUpdate){
        For(Account a : Trigger.new){
            oid.add(a.OwnerId);
        }

    List<User> userList = [Select id, count__c from User where id in :oid];
    If(!userList.isEmpty()){
        For(User u : userList){
            userCountMap.put(u.id, u);
        }
        }
    }

    If(!userCountMap.isEmpty()){
        lstUserToUpdate = [Select id,count__c from user where id in :userCountMap.keySet()];
        For(User u : lstUserToUpdate){
            u.count__c +=1;
            lstUserToUpdate1.add(u);
        }
        //lstUserToUpdate = [Select id,count__c from user where id in :userCountMap.keySet()];
    }
    If(Trigger.isDelete){
        For(Account ac: Trigger.old){
            oid.add(ac.OwnerId);
        }
    List<User> userList = [Select id, count__c from User where id in :oid];
    If(!userList.isEmpty()){
        For(User u : userList){
            userCountMap.put(u.id, u);
        }
    }

    If(!userCountMap.isEmpty()){
        lstUserToUpdate = [Select id,count__c from user where id in :userCountMap.keySet()];
        For(User u : lstUserToUpdate){
            u.count__c -=1;
            lstUserToUpdate1.add(u);
        }
        //lstUserToUpdate = [Select id from user where id in :userCountMap.keySet()];
    }

    }

    If(!lstUserToUpdate1.isEmpty()){
        update lstUserToUpdate1;
    }

    }

    
