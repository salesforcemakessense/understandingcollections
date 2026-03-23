public with sharing class ListAndSetUtil {
    public static void useCaseOne(){
       List<String> accountNames = new List<String>(); 
       for(Account acc: [SELECT Id, Name FROM Account WHERE Name != null]){
            accountNames.add(acc.Name);
       }
       System.debug(accountNames.size());
       System.debug(accountNames);
    }

    public static void useCaseTwo(){
        Set<String> emailAddresses = new Set<String>();
        for(Contact con: [SELECT Id, Name, Email FROM Contact WHERE Email != null]){
            emailAddresses.add(con.Email);
        }
        System.debug(emailAddresses.size());
        System.debug(emailAddresses);
    }

    public static void useCaseThree(){
        List<Decimal> amountData = new List<Decimal>();
        List<Opportunity> oppRecords = [SELECT Id, Amount FROM Opportunity WHERE StageName != 'Closed Won' AND StageName != 'Closed Lost' AND Amount != null];
        for(Opportunity opp: oppRecords){
            amountData.add(opp.Amount);
        }

        System.debug(amountData.size());
    }

    public static void useCaseFour(){
        Set<Id> accountIds = new Set<Id>();
        for(Contact con: [SELECT Id, Name, AccountId, Account.Name FROM Contact WHERE AccountId != null]){
            accountIds.add(con.AccountId);
        }

        System.debug(accountIds.size());
        System.debug(accountIds);
    }

    public static void useCaseFive(){
        List<String> leadNames = new List<String>();
        for(Lead leadRecord: [SELECT Id, Name, LeadSource FROM Lead WHERE LeadSource = 'Web']){
            leadNames.add(leadRecord.Name);
        }
        System.debug(leadNames.size());
        System.debug(leadNames);
    }

    public static void useCaseSix(){
        List<String> phoneNumbers = new List<String>();
        for(Contact conRecord: [SELECT Id, MailingState, Phone FROM Contact WHERE MailingState = 'CA' AND Phone != null]){
            phoneNumbers.add(conRecord.Phone);
        }

        System.debug(phoneNumbers.size());
    }


}