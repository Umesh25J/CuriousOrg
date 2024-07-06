public class JSON2Apex {

	public class Account {
		public String external_id;
		public String name;
		public String country;
		public String province;
		public String city;
		public String postal_code;
	}

	public List<Account> account;
	public List<Contacts> contacts;

	public class Contacts {
		public String first_name;
		public String last_name;
		public String email_address;
		public String account_id;
	}

	
	public static JSON2Apex parse(String json) {
		return (JSON2Apex) System.JSON.deserialize(json, JSON2Apex.class);
	}
}