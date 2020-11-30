#Aggregation Framework
Commands used in this lesson:

Connect to the Atlas cluster:

mongo "mongodb+srv://<username>:<password>@<cluster>.mongodb.net/admin"

Switch to this database:
use sample_airbnb

Find all documents that have Wifi as one of the amenities. Only include price and address in the resulting cursor.

db.listingsAndReviews.find({ "amenities": "Wifi" },
                           { "price": 1, "address": 1, "_id": 0 }).pretty()

Using the aggregation framework find all documents that have Wifi as one of the amenities``*. Only include* ``price and address in the resulting cursor.

db.listingsAndReviews.aggregate([
                                  { "$match": { "amenities": "Wifi" } },
                                  { "$project": { "price": 1,
                                                  "address": 1,
                                                  "_id": 0 }}]).pretty()

Find one document in the collection and only include the address field in the resulting cursor.

db.listingsAndReviews.findOne({ },{ "address": 1, "_id": 0 })

Project only the address field value for each document, then group all documents into one document per address.country value.

db.listingsAndReviews.aggregate([ { "$project": { "address": 1, "_id": 0 }},
                                  { "$group": { "_id": "$address.country" }}])

Project only the address field value for each document, then group all documents into one document per address.country value, and count one for each document in each group.

db.listingsAndReviews.aggregate([
                                  { "$project": { "address": 1, "_id": 0 }},
                                  { "$group": { "_id": "$address.country",
                                                "count": { "$sum": 1 } } }
                                ])

Problem:

To complete this exercise connect to your Atlas cluster using the in-browser IDE space at the end of this chapter.

What room types are present in the sample_airbnb.listingsAndReviews collection?
db.listingsAndReviews.aggregate([ { "$project": { "room_type": 1, "_id": 0 }},
                                  { "$group": { "_id": "$room_type" }}])


#sort() and limit()
There is another fun method called skip() that might come in handy with sort() and limit(). 

Commands used in this lesson:

Connect to the Atlas cluster:

mongo "mongodb+srv://<username>:<password>@<cluster>.mongodb.net/admin"

use sample_training

db.zips.find().sort({ "pop": 1 }).limit(1)

db.zips.find({ "pop": 0 }).count()

db.zips.find().sort({ "pop": -1 }).limit(1)

db.zips.find().sort({ "pop": -1 }).limit(10)

db.zips.find().sort({ "pop": 1, "city": -1 })

Problem:

Which of the following commands will return the name and founding year 
for the 5 oldest companies in the sample_training.companies collection?
db.companies.find({ "founded_year": { "$ne": null }},
                  { "name": 1, "founded_year": 1 }
                 ).sort({ "founded_year": 1 }).limit(5)

db.companies.find({ "founded_year": { "$ne": null }},
                  { "name": 1, "founded_year": 1 }
                 ).limit(5).sort({ "founded_year": 1 })

In what year was the youngest bike rider from the sample_training.trips collection born?
db.trips.find({ "birth year": { "$ne": null }},
                  { "birth year": 1}
                 ).limit(5).sort({ "birth year": -1 })

db.trips.find({ "birth year": { "$ne": "" }},
                  { "birth year": 1}
                 ).limit(5).sort({ "birth year": -1 })

#Introduction to Indexes
To learn more about performance and indexing with MongoDB, take our MongoDB Performance Course!

Commands used in this lesson:

mongo "mongodb+srv://<username>:<password>@<cluster>.mongodb.net/admin"

use sample_training

db.trips.find({ "birth year": 1989 })

db.trips.find({ "start station id": 476 }).sort( { "birth year": 1 } )

db.trips.createIndex({ "birth year": 1 })

db.trips.createIndex({ "start station id": 476, "birth year": 1 })

Problem:

Jameela often queries the sample_training.routes collection by the src_airport field like this:

db.routes.find({ "src_airport": "MUC" }).pretty()

Which command will create an index that will support this query?
db.routes.createIndex({ "src_airport": -1 })

#Introduction to Data Modeling
Data modeling - a way to organize fields in a document to support your application performance and querying capabilities.

#Upsert - Update or Insert?
Commands used in this lesson:

db.iot.updateOne({ "sensor": r.sensor, "date": r.date,
                   "valcount": { "$lt": 48 } },
                         { "$push": { "readings": { "v": r.value, "t": r.time } },
                        "$inc": { "valcount": 1, "total": r.value } },
                 { "upsert": true })

Aggregation Framework

1. Using the aggregation framework find all documents that have Wifi as one
   of the amenities. Only include price and address in the resulting cursor.

2. Which countries have listings in the sample_airbnb database?
3. How many countries have listings in the sample_airbnb database?

sort() and limit()

1. Find the least populated ZIP code in the zips collection.
2. Find the most populated ZIP code in the zips collection.
3. Find the top ten most populated ZIP codes.
4. Get results sorted in increasing order by population, and decreasing
   order by city name.

Introduction to Indexes

Create two separate indxes to support the following queries:

db.trips.find({"birth year": 1989})

db.trips.find({"start station id": 476}).sort("birth year": 1)
