const mongoose = require('mongoose')

const featureSchema = new mongoose.Schema({
    _id : {
        type : mongoose.Schema.Types.ObjectId,
        require : true
    },
    name : {
        type : String,
        require : true
    },
    description : {
        type : String,
        require : true
    }
})

const Feature = module.exports = mongoose.model('Feature', featureSchema)