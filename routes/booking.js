const express = require('express')
const bookingController = require('../controllers/booking')

const router = express.Router()

router.get('/', bookingController.bookings_all)

router.get('/:booking_id', bookingController.booking_by_id)

router.post('/', bookingController.create_booking)

router.delete('/:booking_id', bookingController.delete_book)



module.exports = router