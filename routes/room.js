const express = require('express')
const router = express.Router()

const roomController = require('../controllers/room')

router.get('/', roomController.rooms_all)
router.get('/filter', roomController.filter_upto_price)
router.get('/:room_id',roomController.room_by_id)

//List rooms of a specific Hotel
router.post('/', roomController.create_room)
router.delete('/:room_id', roomController.delete_room)


module.exports = router