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
/*
    // Execute the following in apex anonymous window
    String json='{"invoiceList":[{"totalPrice":5.5,"statementDate":"2011-10-04T16:58:54.858Z","lineItems":[{"UnitPrice":1.0,"Quantity":5.0,"ProductName":"Pencil"},{"UnitPrice":0.5,"Quantity":1.0,"ProductName":"Eraser"}],"invoiceNumber":1}'+
		',{"totalPrice":11.5,"statementDate":"2011-10-04T16:58:54.858Z","lineItems":[{"UnitPrice":6.0,"Quantity":1.0,"ProductName":"Notebook"},{"UnitPrice":2.5,"Quantity":1.0,"ProductName":"Ruler"},{"UnitPrice":1.5,"Quantity":2.0,"ProductName":"Pen"}],"invoiceNumber":2}]}'+
		'';

    // JSON.deserializeStrict(jsonString,System.type);
    System.debug('JSON.deserializeStrict');
    InvoiceWrapper wrapper = (InvoiceWrapper) System.JSON.deserializeStrict(json,InvoiceWrapper.class); // since it returns object we have to type cast the returning result
    System.debug('wrapper: '+wrapper);

    // JSON.deserialize(jsonString,System.type);
    System.debug('JSON.deserialize');
    InvoiceWrapper wrap = (InvoiceWrapper) System.JSON.deserialize(json,InvoiceWrapper.class); // returns object, typecast it to desired type
    system.debug('wrap: '+ wrap);

    // JSON.deserialize(jsonString,System.type);
System.debug('JSON.deserialize');
InvoiceWrapper wrap = (InvoiceWrapper) System.JSON.deserialize(json,InvoiceWrapper.class); // returns object, typecast it to desired type
system.debug('wrap: '+ wrap);

json=		'{'+
		'  "firstName": "Amir",'+
		'  "lastName": "Singh",'+
		'  "age": 28,'+
		'  "status": "Single",'+
		'  "occupation": "Content Writer",'+
		'  "company": "WordsWorth",'+
		'  "city": "Mumbai",'+
		'  "state": "MH",'+
		'  "country": "India",'+
		'  "email": "amir.singh@email.com",'+
		'  "phone": "+919876543210",'+
		'  "favoriteColor": "Blue",'+
		'  "luckyNumber": 77,'+
		'  "heightCm": 174,'+
		'  "weightKg": 71,'+
		'  "hobby1": "Painting",'+
		'  "hobby2": "Football",'+
		'  "hobby3": "Chess",'+
		'  "music1": "Classical",'+
		'  "music2": "Rock",'+
		'  "music3": "Bollywood",'+
		'  "sport1": "Cricket",'+
		'  "sport2": "Badminton",'+
		'  "pet1": "Dog",'+
		'  "dogName": "Max",'+
		'  "pet2": "Parrot",'+
		'  "parrotName": "Mithu",'+
		'  "favBook": "The Alchemist",'+
		'  "favMovie": "Inception",'+
		'  "favFood": "Pasta",'+
		'  "favSeason": "Winter",'+
		'  "dreamDestination": "Japan",'+
		'  "twitter": "@amirsingh28",'+
		'  "instagram": "amir.art",'+
		'  "linkedin": "amir-singh",'+
		'  "carModel": "Honda Jazz",'+
		'  "bikeModel": "Royal Enfield",'+
		'  "primaryLanguage": "Hindi",'+
		'  "secondaryLanguage": "English",'+
		'  "coffeeOrTea": "Tea",'+
		'  "currentMood": "Happy",'+
		'  "birthday": "1997-04-16",'+
		'  "anniversary": "",'+
		'  "hasDrivingLicense": "Yes",'+
		'  "passport": "Yes",'+
		'  "bloodGroup": "A+",'+
		'  "favoriteCuisine": "Mexican",'+
		'  "morningPerson": "No",'+
		'  "nightOwl": "Yes",'+
		'  "favoriteQuote": "To be yourself in a world that is constantly trying to make you something else is the greatest accomplishment.",'+
		'  "roleModel": "Mother Teresa",'+
		'  "volunteer": "Yes",'+
		'  "numberOfSiblings": 3,'+
		'  "sibling1": "Seema",'+
		'  "sibling2": "Arjun",'+
		'  "sibling3": "Ravi"'+
		'}';

        // JSON.deserializeUntyped(jsonString); use this only in case where the json body is not complex
        System.debug('JSON.deserializeUntyped');
        Map<String,Object> jsonMap = (Map<String,Object>) System.JSON.deserializeUntyped(json);
        String favouriteQuote = (String) jsonMap.get('favoriteQuote');
        System.debug(favouriteQuote);
*/
}