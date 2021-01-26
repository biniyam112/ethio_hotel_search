const Feature = require('../models/feature')
const mongoose = require('mongoose')

// @Purpose = List all Features
// @Previlage = No previladge
// @Required fields =  No
// @Optional params = No
// @ Success status code = 200
// @ Faillure Status code = 404
// @Request = GET
exports.features_all = (req, res) => {
    Feature.find()
        .exec()
        .then(result => {
            res.status(200).json({
                error : false,
                count : result.length,
                features : result
            })
        }).
        catch(err => {
            res.status(500).json({
                error : true,
                message : 'Some internal server error'
            })
        })
}

// @Purpose = Get single Feature using id
// @Previlage = No auth
// @Required fields =  feature_id
// @Optional params = No
// @ Success status code = 200
// @ Faillure Status code = 404
// @Request = GET
exports.feature_by_id = (req, res) => {
    let id = req.params.feature_id
    Feature.findById(id).
        exec().
        then(feature => {
            if (feature) {
                res.status(200).json({error : false,feature})
            } else {
                res.status(404).json({error :true, message : 'No Feature Found with this ID.'})
            }
        }).
        catch(err => {
            res.status(404).json({error : true, message : 'No Feature Found with this ID.'})
        })
}

// @Purpose = Creating Feature
// @Previlage = ADMIN
// @Required fields =  review
// @Optional params = No
// @ Success status code = 201
// @ Faillure Status code = 400
// @Request = POST
exports.create_feature = (req, res) => {
    const {name, description} = req.body
    if(name && description) {
        let newFeature = new Feature({
            _id : new mongoose.Types.ObjectId(),
            name,
            description
        })
        newFeature.save().then(() => {
            res.status(201).json({message:'New Feature Created!',feature : newFeature, error : false})
        })
    }
    else {
        res.status(400).json({error : true, message : 'Name and Description Should Be Provided!'})
    }
}

// @Purpose = Delete single Feature
// @Previlage = Admin
// @Required fields =  feature_id
// @Optional params = No
// @ Success status code = 200
// @ Faillure Status code = 400
// @Request = DELETE
exports.delete_feature = (req, res) => {
    let id = req.params.feature_id
    try {
       Feature.deleteOne({_id : mongoose.Types.ObjectId(id)}).exec().
       then((val => {
            if(val.deletedCount > 0) {
                res.status(200).json({error : false, message : `Deleted Feature with ID ${id}`})
            }
            else{
                res.status(200).json({error : true, message : `There is no Feature with ID of ${id}`})
            }
       }))
    } catch (error) {
        res.status(400).json({error : true, message : 'No Feature found with this ID'})
    }
}

// @Purpose = Handling error
// @Previlage = No
// @Required fields =  No
// @Optional params = No
// @ status code = 404
// @Request = No
exports.error_handler = (req, res) => {
    res.status(404).json({
        error : 'Page Not Found!'
    })
}