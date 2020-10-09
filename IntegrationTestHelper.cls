@IsTest
public class IntegrationTestHelper {
    
    
    
    public static  Id createIntegrationFamily(String familyName){
        intframework__Integration_Family__c intFamily=new intframework__Integration_Family__c();
        intFamily.Name=familyName;
        insert intFamily;
        return intFamily.Id;
    }
    
    public static Id createIntegrationProvider(Id familyId,String providerName){
        intframework__Integration_Provider__c intProvider=new intframework__Integration_Provider__c();
        intProvider.Name=providerName;
        intProvider.intframework__Provider_Name__c='dummyProduct';
        intProvider.intframework__Active__c=true;
        intProvider.intframework__Support_Type__c='Custom';
        intProvider.intframework__Integration_Family__c=familyId;
        insert intProvider;
        
        return intProvider.Id;
    }
    
    public static Id createIntegrationApiType(Id familyId,string apiTypeName){
        intframework__Integration_API_Type__c intApiType=new intframework__Integration_API_Type__c();
        intApiType.Name=apiTypeName;
        intApiType.intframework__Integration_Family__c=familyId;
        insert intApiType;
        return intApiType.Id;
    }
    
    public static Id createIntegrationConfiguration(String configurationName,String namedCredentials,Id providerId){
        intframework__Integration_Configuration__c intConfig=new intframework__Integration_Configuration__c();
        intConfig.Name=configurationName;
        intConfig.intframework__Authentication_Named_Credential__c=namedCredentials;
        intConfig.intframework__Integration_Provider__c=providerId;
        insert intConfig;
        return intConfig.Id;
    }
    public static Id createIntegrationConfiguration(String configurationName,Id providerId){
        String namedCredentials='';
        return createIntegrationConfiguration(configurationName,namedCredentials,providerId);
        
        
    }
    public static Id createIntegrationApiConfiguration(string apiConfigName,string familyId,string providerId,string apiTypeId,string intConfigId,string contentType,string apiEndpoint,string adapter,string namedCredentials,decimal executionPriority,string httpmethod,string requestMapping,string responseMapping){
        /***Inserting Integration API Configuration******/
        intframework__Integration_API_Configuration__c icObj = new intframework__Integration_API_Configuration__c();
        icObj.Name =apiConfigName;
        icObj.intframework__Integration_Family__c =familyId;
        icObj.intframework__Integration_Provider__c =providerId;
        icObj.intframework__Integration_API_Type__c =apiTypeId;
        icObj.intframework__Integration_Configuration__c=intConfigId;
        icObj.intframework__Adapter_Class_Name__c =adapter;
        icObj.intframework__API_Named_Credential__c =namedCredentials;
        icObj.intframework__HTTP_Content_Type__c =contentType;
        icObj.intframework__Execution_Priority__c =executionPriority;
        icObj.intframework__Request_Timeout__c =120000;
        icObj.intframework__HTTP_Method__c=httpmethod;
        icObj.intframework__Number_Of_Retries__c =0;
        icobj.intframework__API_Endpoint__c='';
        icObj.intframework__Request_Mapping__c =requestMapping;
        icObj.intframework__Response_Mapping__c=responseMapping;
        insert icObj;
        
        return icobj.Id;  
    }
    public static Id createIntegrationApiConfiguration(string apiConfigName,string familyId,string providerId,string apiTypeId,string intConfigId,string contentType,string apiEndpoint,string adapter,string namedCredentials,decimal executionPriority,string httpmethod){
        string requestMapping='{ "thirdPartySystem": { "name": "WeatherForecast", "staticParameters": [], "dynamicDataParameters": [], "filters": [] } }';
        string responseMapping='{"StorageConfiguration":{"StoreInDB":"False"},"DMLOperations":[]}';
        return  createIntegrationApiConfiguration(apiConfigName,familyId,providerId,apiTypeId,intConfigId,contentType,apiEndpoint,adapter,namedCredentials,executionPriority,httpmethod,requestMapping,responseMapping);
        
    }
    
    
    
    
}