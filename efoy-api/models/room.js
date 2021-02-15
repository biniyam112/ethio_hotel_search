const mongoose = require('mongoose')

const roomsSchema = new mongoose.Schema({
    _id : {
        type : mongoose.Schema.Types.ObjectId,
        require : true
    },
    features : [{type : mongoose.Schema.Types.ObjectId, ref : 'Feature'}],
    ratings : {
        type : Number,
        min : 0,
        max : 5,
        default : 3.5
    },
    status : {
        type : Boolean,
        default : false
    },
    pricePerNight : {
        type : Number,
        required : true
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
    },
    hotel: {
        type: mongoose.Schema.Types.ObjectId,
        required: true,
      }
})

const Room = module.exports = mongoose.model('Room', roomsSchema)