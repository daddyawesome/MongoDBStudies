Step one: Connect to the Atlas cluster

mongo "mongodb+srv://<username>:<password>@<cluster>.mongodb.net/admin"
 
Step two: navigate to the database that we need:

use sample_training

Step three, get a random document from the collection:

db.inspections.findOne();

Step four, copy this random document, and try to insert in into the collection:

db.inspections.insert({
      "_id" : ObjectId("56d61033a378eccde8a8354f"),
      "id" : "10021-2015-ENFO",
      "certificate_number" : 9278806,
      "business_name" : "ATLIXCO DELI GROCERY INC.",
      "date" : "Feb 20 2015",
      "result" : "No Violation Issued",
      "sector" : "Cigarette Retail Dealer - 127",
      "address" : {
              "city" : "RIDGEWOOD",
              "zip" : 11385,
              "street" : "MENAHAN ST",
              "number" : 1712
         }
  })

db.inspections.insert({
      "id" : "10021-2015-ENFO",
      "certificate_number" : 9278806,
      "business_name" : "ATLIXCO DELI GROCERY INC.",
      "date" : "Feb 20 2015",
      "result" : "No Violation Issued",
      "sector" : "Cigarette Retail Dealer - 127",
      "address" : {
              "city" : "RIDGEWOOD",
              "zip" : 11385,
              "street" : "MENAHAN ST",
              "number" : 1712
         }
  })

db.inspections.find({"id" : "10021-2015-ENFO", "certificate_number" : 9278806}).pretty()


In this lesson we used the following commands:

Insert three test documents:

db.inspections.insert([ { "test": 1 }, { "test": 2 }, { "test": 3 } ])
Insert three test documents but specify the _id values:

db.inspections.insert([{ "_id": 1, "test": 1 },{ "_id": 1, "test": 2 },
                       { "_id": 3, "test": 3 }])

Find the documents with _id: 1

db.inspections.find({ "_id": 1 })

Insert multiple documents specifying the _id values, and using the "ordered": false option.

db.inspections.insert([{ "_id": 1, "test": 1 },{ "_id": 1, "test": 2 },
                       { "_id": 3, "test": 3 }],{ "ordered": false })
Insert multiple documents with _id: 1 with the default "ordered": true setting

db.inspection.insert([{ "_id": 1, "test": 1 },{ "_id": 3, "test": 3 }])
View collections in the active db

show collections
Switch the active db to training

use training

View all available databases

show dbs
