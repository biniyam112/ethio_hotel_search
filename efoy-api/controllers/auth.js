const Auth = require('../models/auth');
const mongoose = require('mongoose');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const Hotel = require('../models/hotel_model')

//TODO maybe forget password request will be saved in here

// @Purpose = Authenticate the user
// @Previlage = No
// @Required fields =  username, password
// @Optional params = No
// @ Success status code = 200
// @ Faillure Status code = 400
// @Request = POST
exports.login_user = (req, res) => {
	const { email, password } = req.body;
	if (email && password) {
		Auth.find({ email })
			.exec()
			.then((users) => {
				if (users.length > 0) {
					bcrypt.compare(password, users[0].password, (err, result) => {
						if (err) {
							res.status(401).json({ error: true, message: 'Auth Failed!', success: false });
						}
						if (result) {

                            Hotel.find({adminId : users[0]._id}).exec().then(result => {
                                if(users[0].type == 'HOTEL') {
                                    let token = jwt.sign(
                                        {
                                            id: users[0]._id,
                                            email: users[0].email,
                                            type: users[0].type,
                                            hotel: result[0]._id,
                                        },
                                        'PLEASE_CHANGE_IT_LATER'
                                    );
    
                                    res.status(200).json({
                                        error: false,
                                        success: true,
                                        info: {
                                            id: users[0]._id,
                                            email: users[0].email,
                                            type: users[0].type,
                                            hotelId: result[0]._id,
                                        },
                                        token,
                                    });
                                }
                                else{
                                    let token = jwt.sign(
                                        {
                                            id: users[0]._id,
                                            email: users[0].email,
                                            type: users[0].type,
                                        },
                                        'PLEASE_CHANGE_IT_LATER'
                                    );
    
                                    res.status(200).json({
                                        error: false,
                                        success: true,
                                        info: {
                                            id: users[0]._id,
                                            email: users[0].email,
                                            type: users[0].type,
                                        },
                                        token,
                                    });
                                }
 
                                
                            })
						} else {
							res.status(401).json({ error: true, message: 'Auth Failed!', success: false });
						}
					});
				} else {
					res.status(401).json({ error: true, message: 'Auth Failed!', success: false });
				}
			})
			.catch((err) => {
				res.status(401).json({ error: true, message: 'Auth Failed!', success: false });
			});
	} else {
		res.status(400).json({ error: true, message: 'Email and password are required fields!' });
	}
};
