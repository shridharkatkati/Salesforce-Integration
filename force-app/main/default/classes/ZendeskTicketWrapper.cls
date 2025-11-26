public with sharing class ZendeskTicketWrapper {
	public ticket ticket;
	public class ticket {
		public comment comment;
		public String priority;	
		public String subject;	
		public requester requester;
	}
	public class comment {
		public String body;
	}
	public class requester {
		public String name;
		public String email;
	}
    /* Execute this in anonymous window
    
    ZendeskTicketWrapper.ticket ticket = new ZendeskTicketWrapper.ticket();
    ZendeskTicketWrapper.comment comment = new ZendeskTicketWrapper.comment();
    ZendeskTicketWrapper.requester requester = new ZendeskTicketWrapper.requester();
    ticket.priority = 'High';
    ticket.subject = 'This is the subject of ticket';
    comment.body = 'This is the comment of the ticket';
    requester.name = 'Nikitha';
    requester.email = 'nikks@gmail.com';
    ticket.comment = comment;
    ticket.requester = requester;

    System.debug(System.JSON.serializePretty(ticket));
    */
}