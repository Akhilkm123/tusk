//Assignment 1
//Weatherforecastclass.parsermethod();
public class Weatherforecastclass {
   public Static void removepresentdata()
        {
             try{
                List<Weather_Forecast__c> presentdata=[select ID from Weather_Forecast__c];
                if(presentdata.size()>0){
                                         Database.delete(presentdata,false);
                                        }
                }
                catch(DMLException removedata)
                {
                     System.debug('Exception has occured in inserting a record');
                                System.debug('The following exception has occurred: ' + removedata.getMessage());
                }
        }

public Static void parsermethod()
{
        
//code for Converting JSON to Object     
        StaticResource sr = [SELECT Id, Body FROM StaticResource WHERE Name = 'data' ];
               String body = sr.Body.toString();
        WeatherObject wobj=(WeatherObject)JSON.deserialize(body, WeatherObject.class); 
            

        List<Weather_Forecast__c> BulkRecords=new List<Weather_Forecast__c>();
        
        	for(WeatherObject.Recordlist rl: wobj.rllist)
                    {
                       Weather_Forecast__c Record=new Weather_Forecast__c();
                       Record.cityname__c=wobj.city.name;
                       Record.Country__c=wobj.city.country;
                       Record.City_ID__c=wobj.city.city_id;
                       Record.dt_txt__c=Datetime.valueOfGmt(rl.dt_txt);
                       Record.Temp__c =rl.main.temp-UtilityClass.tempkelvin;
                       Record.temp_min__c=rl.main.temp_min-UtilityClass.tempkelvin;
                       Record.temp_max__c=rl.main.temp_max-UtilityClass.tempkelvin;
                        
                        System.debug(rl.main.temp_max-UtilityClass.tempkelvin);
                        System.debug(rl.main.temp_min-UtilityClass.tempkelvin);
                        
                       BulkRecords.add(Record);
                    }
               
//CODE INSERTING BULKRECORDS         
        try{
            //Code for deleting existing records.
                       List<Weather_Forecast__c> presentdata=[select ID from Weather_Forecast__c];
                                    if(presentdata.size()>0){
                                       Database.delete(presentdata,false);
                                    }  
                    Database.SaveResult[] recordinserted = Database.insert(BulkRecords,false);
                    for (Database.SaveResult recordinfo : recordinserted)
                    {
                    
                        if (recordinfo.isSuccess()) {
                    // Code for Getting recordid
                                            System.debug('Successfully inserted contact. Contact ID: ' + recordinfo.getId());
                                            List<ID> RecordID=new List<ID>();
                                            RecordID.add(recordinfo.getId());
                    								} 
                        else {
                                // Operation failed, so get all errors
                                for(Database.Error err : recordinfo.getErrors()) {
                                System.debug('The following error has occurred.');
                                System.debug(err.getStatusCode() + ': ' + err.getMessage());
                                System.debug('Contact fields that affected this error: ' + err.getFields());
                    															}
                        	 }
                    }
        }
                            catch(DMLException errormessage){
                                System.debug('Exception has occured in inserting a record');
                                System.debug('The following exception has occurred: ' + errormessage.getMessage());  
                                                            }   
    }  
}