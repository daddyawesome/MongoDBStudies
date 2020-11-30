#Comparison
This lesson used the following commands:

Connect to the Atlas cluster:
mongo "mongodb+srv://<username>:<password>@<cluster>.mongodb.net/admin"

Switch to this database:

use sample_training

Find all documents where the tripduration was less than or equal to 70 seconds and the usertype was not Subscriber:
db.trips.find({ "tripduration": { "$lte" : 70 },
                "usertype": { "$ne": "Subscriber" } }).pretty()

Find all documents where the tripduration was less than or equal to 70 seconds and the usertype was Customer using a redundant equality operator:

db.trips.find({ "tripduration": { "$lte" : 70 },
                "usertype": { "$eq": "Customer" }}).pretty()

Find all documents where the tripduration was less than or equal to 70 seconds and the usertype was Customer using the implicit equality operator:
db.trips.find({ "tripduration": { "$lte" : 70 },
                "usertype": "Customer" }).pretty()

Problem:
To complete this exercise connect to your Atlas cluster using the in-browser IDE space at the end of this chapter.

How many documents in the sample_training.zips collection have fewer than 1000 people listed in the pop field?
db.zips.find({"pop":{"$lt":1000}}).count()

What is the difference between the number of people born in 1998 and the number of people born after 1998 in the sample_training.trips 
collection?
db.trips.find({"birth year":{"$eq":1998}}).count() - db.trips.find({"birth year":{"$gt":1998}}).count()


#Logic Operations
This lesson used the following commands:

Connect to the Atlas cluster:

mongo "mongodb+srv://<username>:<password>@<cluster>.mongodb.net/admin"

switch to this database:
use sample_training

Find all documents where airplanes CR2 or A81 left or landed in the KZN airport:
db.routes.find({ "$and": [ { "$or" :[ { "dst_airport": "KZN" },
                                    { "src_airport": "KZN" }
                                  ] },
                          { "$or" :[ { "airplane": "CR2" },
                                     { "airplane": "A81" } ] }
                         ]}).pretty()

Problem:
How many businesses in the sample_training.inspections dataset have the inspection result "Out of Business" and 
belong to the "Home Improvement Contractor - 100" sector?
db.inspections.find({"result":"Out of Business", "sector" : "Home Improvement Contractor - 100"}).count()

Which is the most succinct query to return all documents from the sample_training.inspections collection where the inspection date is either "Feb 20 2015", or "Feb 21 2015" 
and the company is not part of the "Cigarette Retail Dealer - 127" sector?
db.inspections.find(
  { "$or": [ { "date": "Feb 20 2015" },
             { "date": "Feb 21 2015" } ],
    "sector": { "$ne": "Cigarette Retail Dealer - 127" }}).pretty()

How many zips in the sample_training.zips dataset are neither over-populated nor under-populated?
In this case, we consider population of more than 1,000,000 to be over- populated and less than 5,000 to be under-populated.

db.zips.find(
  { "$nor": [ { "pop": {"$gt":1000000} },
             { "pop": {"$lt":5000}}
             ]}).count()

How many companies in the sample_training.companies dataset were either founded in 2004, or 
in the month of October and either have the social category_code or web category_code?
db.companies.find({"$and":[
  { "$or": [ { "founded_year": 2004 },
             { "founded_month": 10}
             ]},
  { "$or": [ { "category_code": "social" },
             { "category_code": "web"}
             ]}
]}
             ).count()

#Expressive Query Operator
This lesson used the following commands:

Connect to the Atlas cluster:
mongo "mongodb+srv://<username>:<password>@<cluster>.mongodb.net/admin"

Switch to this database:
use sample_training

Find all documents where the trip started and ended at the same station:
db.trips.find({ "$expr": { "$eq": [ "$end station id", "$start station id"] }
              }).count()

Find all documents where the trip lasted longer than 1200 seconds, and started and ended at the same station:
db.trips.find({ "$expr": { "$and": [ { "$gt": [ "$tripduration", 1200 ]},
                         { "$eq": [ "$end station id", "$start station id" ]}
                       ]}}).count()

Problem:
Which of the following statements will find all the companies that have more employees than the year in which they were founded?
db.companies.find(
  { "$expr": { "$gt": [ "$number_of_employees", "$founded_year" ] }}).count()

  or
db.companies.find(
  { "$expr": { "$lt": [ "$founded_year", "$number_of_employees" ]}}).count()

How many companies in the sample_training.companies collection have the same permalink as their twitter_username?
db.companies.find({"$expr": { "$eq": [ "$permalink", "$twitter_username"]} }).count()


#Array Operators
This lesson used the following commands:

Connect to the Atlas cluster:
mongo "mongodb+srv://<username>:<password>@<cluster>.mongodb.net/admin"

Switch to this database:
use sample_airbnb

Find all documents with exactly 20 amenities which include all the amenities listed in the query array:
db.listingsAndReviews.find({ "amenities": {
                                  "$size": 20,
                                  "$all": [ "Internet", "Wifi",  "Kitchen",
                                           "Heating", "Family/kid friendly",
                                           "Washer", "Dryer", "Essentials",
                                           "Shampoo", "Hangers",
                                           "Hair dryer", "Iron",
                                           "Laptop friendly workspace" ]
                                         }
                            }).pretty()

Problem:

To complete this exercise connect to your Atlas cluster using the in-browser IDE space at the end of this chapter.

What is the name of the listing in the sample_airbnb.listingsAndReviews dataset that accommodates more than 6 people 
and has exactly 50 reviews?
db.listingsAndReviews.find({"$and":
                    [{"accommodates" :{"$gt":6}},
                    {"reviews":{"$size":50}}
                    ]}
                    ).pretty()

Using the sample_airbnb.listingsAndReviews collection find out how many documents have the "property_type" "House",
and include "Changing table" as one of the "amenities"?
db.listingsAndReviews.find({ "property_type": "House",
                             "amenities": "Changing table" }).count()


Which of the following queries will return all listings that have "Free parking on premises", "Air conditioning", and "Wifi" as part of their amenities, 
and have at least 2 bedrooms in the sample_airbnb.listingsAndReviews collection?
db.listingsAndReviews.find(
  { "amenities":
     { "$all": [ "Free parking on premises", "Wifi", "Air conditioning" ] },
    "bedrooms": { "$gte":  2 } }).pretty()

#Array Operators and Projection
Commands used in this lesson:

Connect to the Atlas cluster:
mongo "mongodb+srv://<username>:<password>@<cluster>.mongodb.net/admin"

Switch to this database:
use sample_airbnb

Find all documents with exactly 20 amenities which include all the amenities listed in the query array, and display their price and address:
db.listingsAndReviews.find({ "amenities":
        { "$size": 20, "$all": [ "Internet", "Wifi",  "Kitchen", "Heating",
                                 "Family/kid friendly", "Washer", "Dryer",
                                 "Essentials", "Shampoo", "Hangers",
                                 "Hair dryer", "Iron",
                                 "Laptop friendly workspace" ] } },
                            {"price": 1, "address": 1}).pretty()

Find all documents that have Wifi as one of the amenities only include price and address in the resulting cursor:
db.listingsAndReviews.find({ "amenities": "Wifi" },
                           { "price": 1, "address": 1, "_id": 0 }).pretty()

Find all documents that have Wifi as one of the amenities only include price and address in the resulting cursor, also exclude ``"maximum_nights"``. **This will be an error:*
db.listingsAndReviews.find({ "amenities": "Wifi" },
                           { "price": 1, "address": 1,
                             "_id": 0, "maximum_nights":0 }).pretty()

Switch to this database:

use sample_training

Get one document from the collection:
db.grades.findOne()

Find all documents where the student in class 431 received a grade higher than 85 for any type of assignment:
db.grades.find({ "class_id": 431 },
               { "scores": { "$elemMatch": { "score": { "$gt": 85 } } }
             }).pretty()

Find all documents where the student had an extra credit score:
db.grades.find({ "scores": { "$elemMatch": { "type": "extra credit" } }
               }).pretty()

Problem:

How many companies in the sample_training.companies collection have offices in the city of Seattle?
db.companies.find({ "offices": { "$elemMatch": { "city":"Seattle" } } }).count()

Which of the following queries will return only the names of companies from the sample_training.companies 
collection that had exactly 8 funding rounds?
db.companies.find({ "funding_rounds": { "$size": 8 } },
                  { "name": 1, "_id": 0 })


#Array Operators and Sub-Documents

Commands used in this lesson:

Connect to the Atlas cluster:
mongo "mongodb+srv://<username>:<password>@<cluster>.mongodb.net/admin"

use sample_training

db.trips.findOne({ "start station location.type": "Point" })

db.companies.find({ "relationships.0.person.last_name": "Zuckerberg" },
                  { "name": 1 }).pretty()

db.companies.find({ "relationships.0.person.first_name": "Mark",
                    "relationships.0.title": { "$regex": "CEO" } },
                  { "name": 1 }).count()


db.companies.find({ "relationships.0.person.first_name": "Mark",
                    "relationships.0.title": {"$regex": "CEO" } },
                  { "name": 1 }).pretty()

db.companies.find({ "relationships":
                      { "$elemMatch": { "is_past": true,
                                        "person.first_name": "Mark" } } },
                  { "name": 1 }).pretty()

db.companies.find({ "relationships":
                      { "$elemMatch": { "is_past": true,
                                        "person.first_name": "Mark" } } },
                  { "name": 1 }).count()

Problem:

Latitude decreases in value as you move west.

How many trips in the sample_training.trips collection started at stations that are to the west of the -74 latitude coordinate?
db.trips.find({ "start station location.coordinates.0": {"$lt":-74}}).count()

How many inspections from the sample_training.inspections collection were conducted in the city of NEW YORK?
db.inspections.find({"address.city":"NEW YORK"}).count()

Which of the following queries will return the names and addresses of all listings from the sample_airbnb.listingsAndReviews 
collection where the first amenity in the list is "Internet"?
db.listingsAndReviews.find({ "amenities.0": "Internet" },
                           { "name": 1, "address": 1 }).pretty()

Query Operators - Comparison

1. Find all documents where the trip was less than or equal to 70 seconds
   and the usertype was not "Subscriber"
2. Find all documents where the trip was less than or equal to 70 seconds
   and the usertype was "Customer" using a redundant equality operator.
3. Find all documents where the trip was less than or equal to 70 seconds
   and the usertype was "Customer" using the implicit equality operator.


Query Operators - Logic

Find all documents where airplanes CR2 or A81 left or landed in the KZN
airport.

Expressive Query Operator

1. Find all documents where the trip started and ended at the same station.
2. Find all documents where the trip lasted longer than 1200 seconds, and
   started and ended at the same station.

Array Operators

1. Find all documents that contain more than one amenity without caring
   about the order of array elements.
2. Only return documents that list exactly 20 amenities in this field and
   contain the amenities of your choosing.

Array Operators and Projection

1. Find all documents in the sample_airbnb database with exactly 20
   amenities which include all the amenities listed in the query array, and display their price and address.
2. Find all documents in the sample_airbnb database that have Wifi as one of
   the amenities only include price and address in the resulting cursor.
3. Find all documents in the sample_airbnb database that have Wifi as one of
   the amenities only include price and address in the resulting cursor,
   also exclude "maximum_nights".
   Was this operation successful? Why?
4. Find all documents in the grades collection where the student in class
   431 received a grade higher than 85 for any type of assignment.
5. Find all documents in the grades collection where the student had an
   extra credit score.

Array Operators and Sub-Documents

1. Find any document from the companies collection where the last name
   Zuckerberg in the first element of the relationships array.
2. Find how many documents from the companies collection have CEOs who's
   first name is Mark and who are listed as the first relationship in this
   array for their company entry.
3. Find all documents in the companies collection where people named Mark
   used to be in the senior company leadership array, a.k.a the
   relationships array, but are no longer with the company.




