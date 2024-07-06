public class CreateOrderRecordController {
	public static string accName;
    public static string orStartDate;
    public static string status;
    public static string sapOrderNum ;
    public static string product1Qty;
    public static string product2Qty;


	@RemoteAction
    public static String createOrderWithProducts(string accNameP ,string orStartDateP ,string statusP ,string sapOrderNumP, string product1QtyP, string product2QtyP) {
        
        List<Pricebook2> priceBook2Records =[SELECT IsActive ,Description, IsStandard, Id, Name, SystemModstamp FROM Pricebook2 WHERE IsActive=True And Name='Standard'];  
        List<PricebookEntry> pricebookEntryRecords =[SELECT Id, Name, Pricebook2Id, Product2Id, UnitPrice, IsActive, UseStandardPrice, ProductCode, IsDeleted, IsArchived FROM PricebookEntry Where Name Like '%Ruckus%' And Pricebook2Id=:priceBook2Records[0].Id ];
   
        Account acc = new Account(Name=accNameP);
        insert acc;
        
        Order orderRecord = new Order();
        orderRecord.AccountId = acc.id;
        orderRecord.EffectiveDate = date.parse(orStartDateP);
        orderRecord.Status = 'Draft';
        orderRecord.Pricebook2Id = priceBook2Records[0].Id;
        insert orderRecord;

        List<OrderItem> orderItemsToInsert = new List<OrderItem>();

        OrderItem orderItem1 = new OrderItem();
        orderItem1.OrderId = orderRecord.Id;
        orderItem1.Product2Id = pricebookEntryRecords[0].Id; 
        orderItem1.Quantity =  Integer.valueof(product1QtyP.trim());
        orderItem1.UnitPrice = pricebookEntryRecords[0].UnitPrice;
        orderItemsToInsert.add(orderItem1);

        OrderItem orderItem2 = new OrderItem();
        orderItem2.OrderId = orderRecord.Id;
        orderItem2.Product2Id = pricebookEntryRecords[1].Id; 
        orderItem2.Quantity = Integer.valueof(product2QtyP.trim());
        orderItem2.UnitPrice = pricebookEntryRecords[1].UnitPrice;

        orderItemsToInsert.add(orderItem2);
        if(orderItemsToInsert.size()>0){
        	insert orderItemsToInsert;
        }
        
        return 'Successful';
    }
}