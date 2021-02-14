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
authSchema.virtual("hotel", {
    ref: "Hotel",
    localField: "_id",
    foreignField: "adminId",
  });
  
  authSchema.set("toObject", { virtuals: true });
  authSchema.set("toJSON", { virtuals: true });
//TODO after betse and add the hotel information in the json web token

const Auth = module.exports = mongoose.model('Auth', authSchema)