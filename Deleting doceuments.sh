Commands used in this lesson:

mongo "mongodb+srv://<username>:<password>@<cluster>.mongodb.net/admin"
use sample_training

Look at all the docs that have test field equal to 1.
db.inspections.find({ "test": 1 }).pretty()

Look at all the docs that have test field equal to 3.
db.inspections.find({ "test": 3 }).pretty()

Delete all the documents that have test field equal to 1.
db.inspections.deleteMany({ "test": 1 })

Delete one document that has test field equal to 3.
db.inspections.deleteOne({ "test": 3 })

Inspect what is left of the inspection collection.
db.inspection.find().pretty()

View what collections are present in the sample_training collection.

show collections

Drop the inspection collection.
db.inspection.drop()



###Sample

Inserting New Documents - insert() and errors:

1. Get a random document from a collection
2. Copy this random document, and insert it back to the collection. Do you get
   a "Duplicate Key" error?
3. Insert that document into the collection without the _id field to get a
   successfull insert. Did it work?


Inserting New Documents - insert() order:

1. Insert three test documents into the inspections collection
   db.inspections.insert([{"test":1},{"test":2},{"test":3}])
2. Insert the same three documents into the inspections collection. Did it
   work? Why?
3. Insert these three test documents into the inspections collection. Did it
   work? Why?
   db.inspections.insert([{"_id": 1, "test": 1},{"_id": 1, "test": 2},{"_id": 3,"test": 3}])
4. Try the same insert as above but make it unordered.
5. Try this command. Did it work? Why?
   db.inspection.insert([{ "_id":1, "test": 1 },{ "_id": 3,"test": 3 }])


Updating Documents  - mongo shell

1. Find all documents in the zips collection where the zip field is equal to
   "12434".
2. Find all documents in the zips collection where the city field is equal to
   "HUDSON".
3. Find how many documents in the zips collection have the zip field is equal
   to "HUDSON".
4. Update all documents in the zips collection where the city field is equal
   to "HUDSON" by adding 10 to the current value of the "pop" field.
5. Update a single document in the zips collection where the zips field is
   equal to "12534" by setting the value of the "pop" field to 17630.
6. Update a single document in the zips collection where the zips field is
   equal to "12534" by setting the value of the "population" field to 17630.
7. Find all documents in the grades collection where the student_id is 151,
   and the class_id field is 399.
8. Find all documents in the grades collection where the student_id is 250,
   and the class_id field is 399.
9. Update one document in the grades collection where the student_id is 250,
   and the class_id field is 399, by adding a document element to the "scores"
   array.

Practice Question:

People often confuse New York City as the capital of New York state, when in
reality the capital of New York state is Albany.

Add a boolean field "capital?" to all documents pertaining to Albany NY, and
New York, NY. The value of the field should be true for all Albany documents
and false for all New York documents.


Deleting Documents and Collections

1. Look at all the documents in the inspections collection that have test field
   equal to 1.
2. Look at all the documents in the inspections collection that have test field
   equal to 3.
3. Delete all the documents from the inspections collection that have test
   field equal to 1
4. Delete one document from the inspections collection that has test field
   equal to 3
5. Inspect what is left of the inspection collection.
6. View what collections are present in the sample_training collection.
7. Drop the inspection collection
