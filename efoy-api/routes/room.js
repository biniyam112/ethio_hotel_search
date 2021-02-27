const express = require('express')
const router = express.Router()

const roomController = require('../controllers/room')

router.get('/', roomController.rooms_all_2nd)
router.get('/filter', roomController.filter_rooms)
router.get('/:room_id',roomController.room_by_id)

//List rooms of a specific Hotel
router.post('/', roomController.create_room) ////Use hotelLoggedInMiddleware
router.delete('/:room_id', roomController.delete_room) //Use hotelLoggedInMiddleware

module.exports = router