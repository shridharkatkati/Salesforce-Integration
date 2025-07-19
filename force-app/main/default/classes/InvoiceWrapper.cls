public with sharing class InvoiceWrapper {
	public invoiceList[] invoiceList;
	class invoiceList {
		public Double totalPrice;
		public String statementDate;
		public lineItems[] lineItems;
		public Integer invoiceNumber;
	}
	class lineItems {
		public Double UnitPrice;
		public Double Quantity;
		public String ProductName;
	}
}