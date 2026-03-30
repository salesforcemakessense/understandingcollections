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

    public static void useCaseSeven(){
        Set<String> uniqueTitles = new Set<String>();
        for(Contact con: [SELECT Id,Title FROM Contact WHERE Title != null]){
            uniqueTitles.add(con.Title);
        }
        System.debug(uniqueTitles.size());
        System.debug(uniqueTitles);
    }

    public static void useCaseEight(){
        Set<Id> contactIds = new Set<Id>();
        Set<String> emailList = new Set<String>();
        List<AggregateResult> results = [SELECT COUNT(Id), Email FROM Contact WHERE Email != null GROUP BY Email HAVING COUNT(Id) > 1];
        for(AggregateResult result: results){
            emailList.add((String)result.get('Email'));
        }
        for(Contact con: [SELECT Id FROM Contact WHERE Email IN :emailList]){
            contactIds.add(con.Id);
        }
        System.debug(contactIds.size());
        System.debug(contactIds);
    }

    public static void useCaseNine(){
        List<String> sicCodes = new List<String>();
        for(Lead eachLead: [SELECT Id, SICCode__c FROM Lead WHERE SICCode__c != null]){
            sicCodes.add(eachLead.SICCode__c);
        }
        System.debug(sicCodes.size());
        System.debug(sicCodes);
    }

    public static void useCaseTen(){
        Set<Date> closeDates = new Set<Date>();
        List<Date> closeDateList = new List<Date>();
        for(Opportunity opp: [SELECT Id, Closedate FROM Opportunity WHERE CloseDate != null]){
            closeDateList.add(opp.CloseDate);
        }      
        closeDates.addAll(closeDateList);
        System.debug(closeDates.size());
    }

    public static void useCaseEleven(){
        Set<String> oppNames = new Set<String>();
        for(Opportunity opp: [SELECT Id, Name FROM Opportunity]){
            if(opp.Name != null){ 
                oppNames.add(opp.Name);
            }
        }

        System.debug(oppNames);
        System.debug(oppNames.size());
    }

    public static void useCaseTwelve(){
        List<String> billingStateList = new List<String>();
        Set<String> billingSet = new Set<String>();
        for(Account acc: [SELECT Id, Name, BillingState FROM Account WHERE BillingState != null ORDER By BillingState]){
            billingSet.add(acc.BillingState);
        }
        
        billingStateList = new List<String>(billingSet);
        System.debug(billingStateList.size());
        System.debug(billingStateList);
    }

    public static List<Opportunity> useCaseThirteen(){
        List<Opportunity> oppRecords = [SELECT Id, Name, StageName, CLoseDate FROM Opportunity WHERE CloseDate = THIS_YEAR ORDER BY CloseDate DESC];
        return oppRecords;
    }

    public static Boolean useCaseFourteen(Id accountId){
        Boolean multipleTitlesFound = false; 
        List<String> titleList = new List<String>();
        List<String> multipleTitleList = new List<String>();

        List<Contact> conRecords = [SELECT Id, Title FROM Contact WHERE AccountId =:accountId];
        for(Contact con: conRecords){
            if(titleList.contains(con.Title)){
                multipleTitleList.add(con.Title); 
            }
            titleList.add(con.Title);
        }

        if(multipleTitleList.size() > 0){
            multipleTitlesFound = true; 
        }

        return multipleTitlesFound;
    }
    public static List<String> useCaseFifteen(){
        Set<String> leadSourceSet = new Set<String>();
        List<Lead> leadRecords = [SELECT Id, Name, LeadSource FROM Lead WHERE LeadSource != null];
        for(Lead leadRecord: leadRecords){
            leadSourceSet.add(leadRecord.LeadSource);
        }
        List<String> sourcesList = new List<String>(leadSourceSet);
        return sourcesList;
    }


}