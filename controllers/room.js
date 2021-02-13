const Room = require('../models/room')
const mongoose = require('mongoose')

// @Purpose = List all Rooms
// @Previlage = *
// @Required fields =  No
// @Optional params = No
// @ Success status code = 200
// @ Faillure Status code = 404
// @Request = GET
exports.rooms_all = (req, res) => {
    Room.find().populate('features')
        .exec()
        .then(result => {
            res.status(200).json({
                error : false,
                count : result.length,
                rooms : result
            })
        }).
        catch(err => {
            res.status(500).json({
                error : true,
                message : 'Some internal server error'
            })
        })
}

// @Purpose = Get single Room by ID
// @Previlage = *
// @Required fields =  room_id
// @Optional params = No
// @ Success status code = 200
// @ Faillure Status code = 404
// @Request = GET
exports.room_by_id = (req, res) => {
    let id = req.params.room_id
    Room.findById(id).populate('features').
        exec().
        then(room => {
            if (room) {
                res.status(200).json({error : false,room})
            } else {
                res.status(404).json({error :true, message : 'No Room Found with this ID.'})
            }
        }).
        catch(err => {
            res.status(404).json({error : true, message : 'No Room Found with this ID.'})
        })
}

//TODO Add controller to list rooms of a hotel

// @Purpose = Creating Room
// @Previlage = *
// @Required fields =  numberOfBedrooms, description, count, pricePerNight
// @Optional params = SuperAdmin
// @ Success status code = 201
// @ Faillure Status code = 400
// @Request = POST
exports.create_room = (req, res) => {

    const {features, numberOfBedrooms, description, count, pricePerNight} = req.body

    //TODO add rooms of features
    if(numberOfBedrooms && description && count, pricePerNight) {
            let newRoom = new Room({
                _id : new mongoose.Types.ObjectId(),
                numberOfBedrooms,
                count,
                description,
                pricePerNight
            })
            if(features && (features.length > 0)) {
                newRoom.features = features
            }
    
            newRoom.save().then(() => {
                res.status(201).json({error : false, message:'Created Room!',success : true, newRoom})
            }).catch(err => {
                res.status(400).json({error :true, message : 'Number of bedrooms, Price per Night and room count should be numerical values.'})
            })
    }
    else {
        res.status(400).json({error :true, message : 'numberOfBedrooms price per night, Description and Room counts are required'})
    }
}

// @Purpose = Delete single Room
// @Previlage = HotelAdmin 
// @Required fields =  room_id
// @Optional params = No
// @ Success status code = 200
// @ Faillure Status code = 400
// @Request = DELETE
exports.delete_room = (req, res) => {
    let id = req.params.room_id
    try {
       Room.deleteOne({_id : mongoose.Types.ObjectId(id)}).exec().
       then((val => {
            if(val.deletedCount > 0) {
                res.status(200).json({error : false, message : `Deleted Room with ID ${id}`})
            }
            else{
                res.status(200).json({error : true, message : `There is no Room with ID of ${id}`})
            }
       }))
    } catch (error) {
        res.status(400).json({error : true, message : 'No Feature found with this ID'})
    }
}

exports.filter_rooms = (req, res) => {
    const {upto, numberOfBedrooms} = req.query

    Room.find({pricePerNight : {$lte : upto}, numberOfBedrooms : {$eq : numberOfBedrooms}}).
    populate('features').
    exec().
    then(rooms => {
        res.status(200).json({error : false, count : rooms.length, rooms})
    }).
    catch(err => {
        console.log(err)
        res.status(400).json({error : true, message : 'The price value is inappropriate.'})
    })
}

// @Purpose = Handling error
// @Previlage = No
// @Required fields =  No
// @Optional params = No
// @ status code = 404
// @Request = No
exports.error_handler = (req, res) => {
    res.status(404).json({
        error : 'Page Not Found!'
    })
}