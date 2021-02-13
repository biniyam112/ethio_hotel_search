const mongoose = require('mongoose')

const authSchema = new mongoose.Schema({
    _id : {
        type : mongoose.Schema.Types.ObjectId,
        required : true
    },
    email : {
        type : String,
        required : true,
        unique : true
    },
    password : {
        type : String,
        required : true,
        minlength : 8
    },
    type : {
        type : String,
        required : true
    }
})

const Auth = module.exports = mongoose.model('Auth', authSchema)