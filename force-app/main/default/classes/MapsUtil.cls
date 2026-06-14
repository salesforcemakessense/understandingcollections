public with sharing class MapsUtil {
    
    public static void understandMapMethods(){
        Map<String,String> roleVsNameMap = new Map<String,String>();
        //need to add values to the map
        roleVsNameMap.put('Salesforce Engineer', 'Himanshu Maheshwari');
        roleVsNameMap.put('Salesforce Quality', 'Jayant Rajput');
        roleVsNameMap.put('Salesforce Quality', 'Arbaaz Khan');
        roleVsNameMap.put('Salesforce Product', 'Soniya');
        System.debug(roleVsNameMap);

        //Result of how it is stored: {Salesforce Engineer=Himanshu Maheshwari}
        //{Salesforce Engineer=Himanshu Maheshwari, Salesforce Product=Soniya, Salesforce Quality=Arbaaz Khan}

        //need to get data from a Map
        String productName = roleVsNameMap.get('Salesforce Product');
        System.debug('PO for the project is: ' + productName);

        //size of the map: tells you the number of key-value pairs
        Integer sizeOfMap = roleVsNameMap.size();
        System.debug('Total Roles in this project: ' + sizeOfMap);

        //if I want to check if a specific key exists or not
        Boolean qualityFound = roleVsNameMap.containsKey('Salesforce Quality');
        System.debug('Quality Engineer is part of project? ' + qualityFound);

        //if I want to check if a specific value exists or not: 
        //Is Jayant Part of the project or not?
        if(roleVsNameMap.containsKey('Salesforce Quality')){
            String qualityEngineerValue = roleVsNameMap.get('Salesforce Quality'); //returns a value -> Jayant Rajput in our case
            if(qualityEngineerValue == 'Jayant Rajput'){
                System.debug('Jayant R is part of the project');
            }
        }

        //how to fetch all the values of a map
        List<String> myMembers = roleVsNameMap.values();
        System.debug('Members of the project are: ' + myMembers);
        // how to fetch all keys of the map:
        Set<String> allRoles = roleVsNameMap.keyset();
        System.debug('Roles of the project are: ' + allRoles);

        //to copy the entire map into another map variable
        Map<String,String> roleVsNameMapPrivate = roleVsNameMap.clone();

        //clear up the map & empty it
        roleVsNameMap.clear();

        //if you need to check if map has any data or not
        Boolean isMapEmpty = roleVsNameMap.isEmpty();
        System.debug('Map is empty? ' + isMapEmpty);

        Boolean isPrivateMapEmpty = roleVsNameMapPrivate.isEmpty();
        System.debug('Private Map is empty? ' + isPrivateMapEmpty);

        //how to remove a key from a map
        System.debug('Before key removal: ' + roleVsNameMapPrivate);
        roleVsNameMapPrivate.remove('Salesforce Quality');
        System.debug('After key removal: ' + roleVsNameMapPrivate);

        //re enable member to the project by using put
        roleVsNameMapPrivate.put('Salesforce Quality', 'Jayant Rajput');
        System.debug('Final Team: ' + roleVsNameMapPrivate);
        
    }
}