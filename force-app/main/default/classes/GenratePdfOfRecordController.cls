public with sharing class GenratePdfOfRecordController {

    public class Broker {
        public String emailaddress { get; set; }
        public String firstName { get; set; }
        public String lastName { get; set; }
        public String candidateName { get; set; }
    }
    public List<Broker> getBroker(){

        List<Broker> brokers = new List<Broker>();
  
        Broker broker = new Broker();
        //broker.emailaddress = getEmail();

        brokers.add(broker);

        return brokers;
    }
    private String getEmail(String orderProperties){
        String emailaddress;
        //If the map already has the value from the child line items
        //If not, then checks the parent line item (Orders)
        if(orderProperties != null){
            Map<String, Object> properties = (Map<String, Object>) JSON.deserializeUntyped(orderProperties);
            //TMNLQuoteContractData.Place place = (TMNLQuoteContractData.Place)JSON.deserialize(JSON.serialize(properties.get('place')),TMNLQuoteContractData.Place.class);
            //emailaddress = place.street + ' ' + place.houseNumber + ', ' + place.postcode + ' ' + place.city;
        }
        return emailaddress;
    }


}