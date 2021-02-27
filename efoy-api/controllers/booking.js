const Booking = require('../models/booking')
const mongoose = require('mongoose')
const jwt = require('jsonwebtoken')
const AuthTypes = require('../utils/auth_types')

// @Purpose = List all Features
// @Previlage = No previladge
// @Required fields =  No
// @Optional params = No
// @ Success status code = 200
// @ Faillure Status code = 404
// @Request = GET
exports.bookings_all = (req, res) => {

    const authHeader = req.headers['authorization'];
	const authToken = authHeader && authHeader.split(' ')[1];

    if(authToken) {
        jwt.verify(authToken, 'PLEASE_CHANGE_IT_LATER', (err, decode) => {
			if (err) {
				res.status(401).json({ error: true, message: 'Unauthorized Personnel!' });
			} else {
				if (decode.type === AuthTypes.HOTEL) {
					let hotelId = decode.hotel;
					Booking.find({ hotel: hotelId })
						.populate('room')
						.exec()
						.then((result) => {
							res.status(200).json({
								error: false,
								count: result.length,
								bookings: result,
							});
						})
						.catch((err) => {
							res.status(500).json({
								error: true,
								message: 'Some internal server error',
							});
						});
				} else {
					res.status(401).json({ error: true, message: 'Unauthorized Personnel!' });
				}
			}
		});
    }
    else{
        res.status(401).json({ error: true, message: 'Unauthorized Personnel!' });
    }
    //DONT RETURN ALL THE BOOKINGS FOR EVERYBODY IT MUST BE AUTHENTICATED AND AUTHORIZED
    
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
    //TDOD hotel will be send as parameter from user input/selection
    //TODO ADD CHECKIN AND CHECKOUT DATEs AS USER INPUT FROM USER PROVIDED FORM
    const {room, phoneNumber, checkInDate, checkOutDate, hotel} = req.body
    if(room && phoneNumber && hotel) {
        let newBooking = new Booking({
            _id : new mongoose.Types.ObjectId(),
            room,
            phoneNumber,
            hotel
        })
        newBooking.save().then(() => {
            res.status(201).json({message:'Booking Saved!',booking : newBooking, error : false})
        }).catch(err => {
            res.status(400).json({error : true, message : 'Incorrect message format please insert correct value.'})
        })
    }
    else {
        res.status(400).json({error : true, message : 'room, phoneNumber, checkInDate, checkOutDate and hotel Should Be Provided!'})
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

// @Purpose = Get Bookings of a single hotel
// @Previlage = Hotels ? maybe not
// @Required fields =  hotel_id
// @Optional params = No
// @ Success status code = 200
// @ Faillure Status code = 404
// @Request = GET
exports.get_bookings_by_hotel_id = (req, res) => {
    let id = req.params.hotel_id
    Booking.find({hotel : id}).populate('room').
        exec().
        then(bookings => {
            if (bookings) {
                res.status(200).json({error : false,bookings})
            } else {
                res.status(404).json({error :true, message : 'No Booking Found For this hotel.'})
            }
        }).
        catch(err => {
            res.status(404).json({error : true, message : 'No Booking Found for this hotel.'})
        })
}