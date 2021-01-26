const mongoose = require('mongoose')

const roomsSchema = new mongoose.Schema({
    _id : {
        type : mongoose.Schema.Types.ObjectId,
        require : true
    },
    features : [{type : mongoose.Schema.Types.ObjectId, ref : 'Feature'}],
    status : {
        type : Boolean,
        default : false
    },
    pricePerNight : {
        type : Number,
        required : true
    },
    checkIn : {
        type : Date,
        default : Date.now
    },
    checkOut : {
        type : Date,
        default : Date.now
    },
    numberOfBedrooms : {
        type : Number,
        required : true,
    },
    description : {
        type : String,
        required : false
    },
    count : {
        type : Number,
        default : 60
    },
    onDiscount : {
        type : Boolean,
        default : false
    },
    discountPercent : {
        type : Number,
        default : 0,
        min : 0,
        max : 99
    }
})

const Room = module.exports = mongoose.model('Room', roomsSchema)