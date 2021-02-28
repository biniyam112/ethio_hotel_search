const express = require('express')
const router = express.Router()
const roomController = require('../controllers/room')
const AuthMiddleware = require('../middlewares/auth_middlewares')

router.get('/', roomController.rooms_all_2nd)
router.get('/filter', roomController.filter_rooms)
router.get('/:room_id',roomController.room_by_id)

//List rooms of a specific Hotel
router.post('/',AuthMiddleware.hotel_logged_in, roomController.create_room) ////Use hotelLoggedInMiddleware

router.patch('/:room_id',AuthMiddleware.hotel_logged_in, roomController.update_room)

router.delete('/:room_id',AuthMiddleware.hotel_logged_in, roomController.delete_room) //Use hotelLoggedInMiddleware

module.exports = router