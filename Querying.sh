# to connect to atlas
mongo "mongodb+srv://<username>:<password>@<cluster>.mongodb.net/admin"

# example


it iterates through the cursor.

show dbs

use sample_training

show collections


1. Query the zips collection from the sample_training database to find all documents where the state is New York.
2. Iterate through the query results.
3. Find out how many ZIP codes there are in NY state.
4. What about the ZIP codes that are in NY but also in the city of Albany?
5. Make the cursor look more readable.

answers: 
db.zips.find({"state": "NY"}).count()

db.zips.find({"state": "NY", "city": "ALBANY"})

db.zips.find({"state": "NY", "city": "ALBANY"}).pretty()

db.zips.find({"state": "NY"})


# quiz: Using the sample_training.inspections collection find out how many inspections were conducted on Feb 20 2015.
answers: 
db.inspections.find({"date":"Feb 20 2015"})

db.inspections.find({"date":"Feb 20 2015"})