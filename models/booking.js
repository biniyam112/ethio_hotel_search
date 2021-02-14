const mongoose = require('mongoose')

const bookSchema = new mongoose.Schema({
    _id : {
        type : mongoose.Schema.Types.ObjectId,
        required : true,
    },
    room : {
        type : mongoose.Schema.Types.ObjectId,
        ref : 'Room',
        required : true
    },
    
    phoneNumber :{
        type : String,
        required : true,
        minlength : 10,
        maxlength : 13
    },
    checkInDate : {
        type : Date,
        default : Date.now()
    },
    checkOutDate : {
        type : Date,
        default : Date.now()
    },
    hotel: {
        type: mongoose.Schema.Types.ObjectId,
        required: true,
      },

})

const Booking = module.exports = mongoose.model('Booking', bookSchema)