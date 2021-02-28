const express = require('express')
const bookingController = require('../controllers/booking')
const AuthMiddlewares = require('../middlewares/auth_middlewares')

const router = express.Router()

router.get('/', bookingController.bookings_all) //Specific Hotel

router.get('/:booking_id', bookingController.booking_by_id)

router.get('/hotel/:hotel_id',AuthMiddlewares.hotel_logged_in, bookingController.get_bookings_by_hotel_id) //Use hotelLoggedInMiddleware

router.get('/user/:phone_number', bookingController.get_bookings_by_phone_number)

router.post('/', bookingController.create_booking) //user uploads bookings

router.delete('/:booking_id',AuthMiddlewares.hotel_logged_in, bookingController.delete_book) ////Use hotelLoggedInMiddleware

module.exports = router