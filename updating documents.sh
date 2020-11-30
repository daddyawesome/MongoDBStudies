Commands used in this lesson:

Connect to your Atlas Cluster.

mongo "mongodb+srv://<username>:<password>@<cluster>.mongodb.net/admin"

Use the sample_training database as your database in the following commands.

use sample_training

Find all documents in the zips collection where the zip field is equal to "12434".
db.zips.find({ "zip": "12534" }).pretty()

Find all documents in the zips collection where the city field is equal to "HUDSON".
db.zips.find({ "city": "HUDSON" }).pretty()

Find how many documents in the zips collection have the city field equal to "HUDSON".
db.zips.find({ "city": "HUDSON" }).count()

Update all documents in the zips collection where the city field is equal to "HUDSON" by adding 10 to the current value of the "pop" field.
db.zips.updateMany({ "city": "HUDSON" }, { "$inc": { "pop": 10 } })

Update a single document in the zips collection where the zip field is equal to "12534" by setting the value of the "pop" field to 17630.
db.zips.updateOne({ "zip": "12534" }, { "$set": { "pop": 17630 } })

Update a single document in the zips collection where the zip field is equal to "12534" by setting the value of the "popupation" field to 17630.
db.zips.updateOne({ "zip": "12534" }, { "$set": { "population": 17630 } })

Find all documents in the grades collection where the student_id field is 151 , and the class_id field is 339.
db.grades.find({ "student_id": 151, "class_id": 339 }).pretty()

Find all documents in the grades collection where the student_id field is 250 , and the class_id field is 339.
db.grades.find({ "student_id": 250, "class_id": 339 }).pretty()

Update one document in the grades collection where the student_id is ``250`` *, and the class_id field is 339 , by adding a document element to the "scores" array.
db.grades.updateOne({ "student_id": 250, "class_id": 339 },
                    { "$push": { "scores": { "type": "extra credit",
                                             "score": 100 }
                                }
                     })



Practice Question:

People often confuse New York City as the capital of New York state, when in reality the capital of New York state is Albany.

Add a boolean field "capital?" to all documents pertaining to Albany NY, and New York, NY. The value of the field should be true for all Albany documents
and false for all New York documents.

db.zips.find({ "city": "ALBANY","state":"NY" }).count()
db.zips.find({ "city": "NEW YORK","state":"NY" }).count()

db.zips.updateMany({ "city": "ALBANY","state":"NY" },{"$set": { "capital?": true }})
db.zips.updateMany({ "city": "NEW YORK","state":"NY" },{"$set": { "capital?": false }})
