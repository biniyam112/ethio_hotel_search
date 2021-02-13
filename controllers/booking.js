const Booking = require('../models/booking')
const mongoose = require('mongoose')

// @Purpose = List all Features
// @Previlage = No previladge
// @Required fields =  No
// @Optional params = No
// @ Success status code = 200
// @ Faillure Status code = 404
// @Request = GET
exports.bookings_all = (req, res) => {
    //TODO get the hotel id from the jwt
    //DONT RETURN ALL THE BOOKINGS FOR EVERYBODY IT MUST BE AUTHENTICATED AND AUTHORIZED
    Booking.find().populate('room')
        .exec()
        .then(result => {
            res.status(200).json({
                error : false,
                count : result.length,
                bookings : result
            })
        }).
        catch(err => {
            res.status(500).json({
                error : true,
                message : 'Some internal server error'
            })
        })
}

// @Purpose = Get single Booking using id
// @Previlage = Hotels ? maybe not
// @Required fields =  booking_id
// @Optional params = No
// @ Success status code = 200
// @ Faillure Status code = 404
// @Request = GET
exports.booking_by_id = (req, res) => {
    let id = req.params.booking_id
    Booking.findById(id).populate('room').
        exec().
        then(booking => {
            if (booking) {
                res.status(200).json({error : false,booking})
            } else {
                res.status(404).json({error :true, message : 'No Booking Found with this ID.'})
            }
        }).
        catch(err => {
            res.status(404).json({error : true, message : 'No Booking Found with this ID.'})
        })
}

// @Purpose = Creating Booking
// @Previlage = users can create one, no auth may be needed
// @Required fields =  room_id, phoneNumber, checkInDate, checkOutDate
// @Optional params = No
// @ Success status code = 201
// @ Faillure Status code = 400
// @Request = POST
exports.create_booking = (req, res) => {
    //TODO ADD CHECKIN AND CHECKOUT DATEs AS USER INPUT FROM USER PROVIDED FORM
    const {room, phoneNumber, checkInDate, checkOutDate} = req.body
    if(room && phoneNumber) {
        let newBooking = new Booking({
            _id : new mongoose.Types.ObjectId(),
            room,
            phoneNumber
        })
        newBooking.save().then(() => {
            res.status(201).json({message:'Booking Saved!',booking : newBooking, error : false})
        }).catch(err => {
            res.status(400).json({error : true, message : 'Incorrect message format please insert correct value.'})
        })
    }
    else {
        res.status(400).json({error : true, message : 'room_id, phoneNumber, checkInDate and checkOutDate Should Be Provided!'})
    }
}

// @Purpose = Delete single Book
// @Previlage = Hotel
// @Required fields =  book_id
// @Optional params = No
// @ Success status code = 200
// @ Faillure Status code = 400
// @Request = DELETE
exports.delete_book = (req, res) => {
    let id = req.params.booking_id
    try {
       Booking.deleteOne({_id : mongoose.Types.ObjectId(id)}).exec().
       then((val => {
            if(val.deletedCount > 0) {
                res.status(200).json({error : false, message : `Deleted Booking with ID ${id}`})
            }
            else{
                res.status(200).json({error : true, message : `There is no Booking with ID of ${id}`})
            }
       }))
    } catch (error) {
        res.status(400).json({error : true, message : 'No Booking found with this ID'})
    }
}

//TODO add route for get_bookings_hotel_id