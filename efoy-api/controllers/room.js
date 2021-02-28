const Room = require('../models/room');
const mongoose = require('mongoose');
const jwt = require('jsonwebtoken');
const AuthTypes = require('../utils/auth_types');

// @Purpose = List all Rooms
// @Previlage = *
// @Required fields =  No
// @Optional params = No
// @ Success status code = 200
// @ Faillure Status code = 404
// @Request = GET
exports.rooms_all = (req, res) => {
	const authHeader = req.headers['authorization'];
	const authToken = authHeader && authHeader.split(' ')[1];

	if (authToken) {
		jwt.verify(authToken, 'PLEASE_CHANGE_IT_LATER', (err, decode) => {
			if (err) {
				res.status(401).json({ error: true, message: 'Unauthorized Personnel!' });
			} else {
				if (decode.type === AuthTypes.HOTEL) {
					let hotelId = decode.hotel;
					Room.find({ hotel: hotelId })
						.populate('features')
						.exec()
						.then((result) => {
							res.status(200).json({
								error: false,
								count: result.length,
								rooms: result,
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
	} else {
		res.status(401).json({ error: true, message: 'Unauthorized Personnel!' });
	}
	//Use jwt
};

exports.rooms_all_2nd = (req, res) => {
	Room.find()
		.populate('features')
		.exec()
		.then((result) => {
			res.status(200).json({
				error: false,
				count: result.length,
				rooms: result,
			});
		})
		.catch((err) => {
			res.status(500).json({
				error: true,
				message: 'Some internal server error',
			});
		});
};

// @Purpose = Get single Room by ID
// @Previlage = *
// @Required fields =  room_id
// @Optional params = No
// @ Success status code = 200
// @ Faillure Status code = 404
// @Request = GET
exports.room_by_id = (req, res) => {
	let id = req.params.room_id;
	Room.findById(id)
		.populate('features')
		.exec()
		.then((room) => {
			if (room) {
				res.status(200).json({ error: false, room });
			} else {
				res.status(404).json({ error: true, message: 'No Room Found with this ID.' });
			}
		})
		.catch((err) => {
			res.status(404).json({ error: true, message: 'No Room Found with this ID.' });
		});
};

// @Purpose = Creating Room
// @Previlage = *
// @Required fields =  numberOfBedrooms, description, count, pricePerNight
// @Optional params = SuperAdmin
// @ Success status code = 201
// @ Faillure Status code = 400
// @Request = POST
exports.create_room = (req, res) => {
	const authHeader = req.headers['authorization'];
	const authToken = authHeader && authHeader.split(' ')[1];

	if (authToken) {
		jwt.verify(authToken, 'PLEASE_CHANGE_IT_LATER', (err, decode) => {
			if (err) {
				res.status(401).json({ error: true, message: 'Unauthorized Personnel!' });
			} else {
				if (decode.type === AuthTypes.HOTEL) {
					let hotelId = decode.hotel;
					const { features, numberOfBedrooms, description, count, pricePerNight } = req.body;
					console.log(decode);

					if (numberOfBedrooms && description && count && pricePerNight) {
						let newRoom = new Room({
							_id: new mongoose.Types.ObjectId(),
							numberOfBedrooms,
							count,
							description,
							pricePerNight,
							hotel: hotelId,
						});
						if (features && features.length > 0) {
							newRoom.features = features;
						}

						newRoom
							.save()
							.then(() => {
								res.status(201).json({
									error: false,
									message: 'Created Room!',
									success: true,
									newRoom,
								});
							})
							.catch((err) => {
								console.log(err);
								res.status(400).json({
									error: true,
									message:
										'Number of bedrooms, Price per Night and room count should be numerical values.',
								});
							});
					} else {
						res.status(400).json({
							error: true,
							message: 'numberOfBedrooms price per night, Description and Room counts are required',
						});
					}
				} else {
					res.status(401).json({ error: true, message: 'Unauthorized Personnel!' });
				}
			}
		});
	} else {
		res.status(401).json({ error: true, message: 'Unauthorized Personnel!' });
	}
};

// @Purpose = Delete single Room
// @Previlage = HotelAdmin
// @Required fields =  room_id
// @Optional params = No
// @ Success status code = 200
// @ Faillure Status code = 400
// @Request = DELETE
exports.delete_room = (req, res) => {
	let id = req.params.room_id;
	try {
		Room.deleteOne({ _id: mongoose.Types.ObjectId(id) })
			.exec()
			.then((val) => {
				if (val.deletedCount > 0) {
					res.status(200).json({ error: false, message: `Deleted Room with ID ${id}` });
				} else {
					res.status(200).json({ error: true, message: `There is no Room with ID of ${id}` });
				}
			});
	} catch (error) {
		res.status(400).json({ error: true, message: 'No Feature found with this ID' });
	}
};

exports.filter_rooms = (req, res) => {
	const { upto } = req.query;

	Room.find()
		.populate('features')
		.exec()
		.then((rooms) => {
			const filteredRoom = rooms.filter((room) => {
				return room.pricePerNight <= upto;
			});

			res.status(200).json({ error: false, count: filteredRoom.length, room: filteredRoom });
			// console.log(filteredRoom)
		})
		.catch((err) => {
			console.log(err);
			res.status(400).json({ error: true, message: 'The price value is inappropriate.' });
		});
};

// @Purpose = Handling error
// @Previlage = No
// @Required fields =  No
// @Optional params = No
// @ status code = 404
// @Request = No
exports.error_handler = (req, res) => {
	res.status(404).json({
		error: 'Page Not Found!',
	});
};

exports.update_room = (req, res) => {

	let room_id = req.params.room_id

	let {numberOfBedrooms, description, count, pricePerNight} = req.body

	if (numberOfBedrooms && description && count && pricePerNight) {
		Room.findById(room_id)
			.exec()
			.then((room) => {
				if (room) {					
					room.numberOfBedrooms = numberOfBedrooms;
					room.pricePerNight = pricePerNight;
					room.conunt = count;
					room.description = description;
					
					room.save().then(() => {
						res.status(200).json({message:'Updated!',error : false, success : true})
					})
				}
			}).catch(err => {
				res.status(400).json({
					error: true,
					message: 'Error updating room.',
				});
			});
	} else {
		res.status(400).json({
			error: true,
			message: 'numberOfBedrooms price per night, Description and Room counts are required',
		});
	}
};
