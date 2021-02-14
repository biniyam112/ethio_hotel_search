const express = require('express')
const bookingController = require('../controllers/booking')

const router = express.Router()

router.get('/', bookingController.bookings_all) //Specific Hotel

router.get('/:booking_id', bookingController.booking_by_id)

router.get('/hotel/:hotel_id', bookingController.get_bookings_by_hotel_id) //Use hotelLoggedInMiddleware

router.post('/', bookingController.create_booking) //user uploads bookings

router.delete('/:booking_id', bookingController.delete_book) ////Use hotelLoggedInMiddleware



module.exports = router