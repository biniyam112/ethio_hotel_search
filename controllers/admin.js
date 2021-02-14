const Auth = require('../models/auth')
const mongoose = require('mongoose')
const bcrypt = require('bcrypt')
const jwt = require('jsonwebtoken')

const AuthTypes = require('../utils/auth_types')

// @Purpose = List all admins
// @Previlage = Super Admin
// @Required fields =  No
// @Optional params = No
// @ Success status code = 200
// @ Faillure Status code = 404
// @Request = GET
exports.admins_all = (req, res) => {
    Auth.find()
        .exec()
        .then(result => {
            let admins = result.filter(item => item.type === AuthTypes.ADMIN)
            res.status(200).json({
                error : false,
                count : admins.length,
                admins : admins
            })
        }).
        catch(err => {
            res.status(500).json({
                error : true,
                message : 'Some internal server error'
            })
        })
}

// @Purpose = Get single admin using id
// @Previlage = SUPERADMIN
// @Required fields =  admin_id
// @Optional params = No
// @ Success status code = 200
// @ Faillure Status code = 404
// @Request = GET
exports.admin_by_id = (req, res) => {
    let id = req.params.admin_id
    Auth.findById(id).
        exec().
        then(admin => {
            if (admin && admin.type === AuthTypes.ADMIN) {
                res.status(200).json({error : false,admin : admin})
            } else {
                res.status(404).json({error :true, message : 'No Admin Found with this ID.'})
            }
        }).
        catch(err => {
            res.status(404).json({error : true, message : 'No Admin Found with this ID.'})
        })
}

// @Purpose = Creating Admin
// @Previlage = Superadmin
// @Required fields =  username, password
// @Optional params = SuperAdmin
// @ Success status code = 201
// @ Faillure Status code = 400
// @Request = POST
exports.create_admin = (req, res) => {

    const {email, password} = req.body
    if(email && password) {
        //check if the phone number is taken
        Auth.find({email : email}).exec()
        .then(admin => {
            if(admin.length >= 1) {
                // console.log(admin)
                res.status(400).json({error :true , message : 'Email already registered'})
            }
            else{
                if(password.length < 8) {
                    res.status(400).json({error : true, message : 'Password should be at least 8 characters'})
                }
                else {
                    bcrypt.hash(password,10,(err, hashed) => {
                        if(err) {
                            res.status(500).json({error : true, message : 'Internal server error endountered'})
                        }
                        else {
                            let newAdmin = new Auth({
                                _id : new mongoose.Types.ObjectId(),
                                email,
                                password : hashed,
                                type : AuthTypes.ADMIN
                            })
                            newAdmin.save().then(() => {
                                res.status(201).json({error : false, message:'Created!',success : true})
                            })
                        }
                    })
                }
            }
        }).catch(err => {
            console.log(err)
            res.status(500).json({error : true, message : 'Some intername error happened.'})
        })        
    }
    else {
        res.status(400).json({error :true, message : 'username and password should be provided'})
    }
}

// @Purpose = Delete single Admin
// @Previlage = SuperAdmin 
// @Required fields =  admin_id
// @Optional params = No
// @ Success status code = 200
// @ Faillure Status code = 400
// @Request = DELETE
exports.delete_admin = (req, res) => {
    //check is there is at least one admin
    let id = req.params.admin_id
    Auth.find({}).exec().then(admins => {
        if(admins.length <= 1) {
            res.status(400).json({error :true, message : 'There must be at least one Admin!'})
        }
        else {
            try {
                Auth.deleteOne({_id : mongoose.Types.ObjectId(id),type : AuthTypes.ADMIN}).exec().
                then((val => {
                    if(val.deletedCount > 0) {
                        res.status(200).json({error : false, message : `Deleted Admin with ID ${id}`})
                    }
                    else{
                        res.status(200).json({error : true, message : `There is no Admin with ID of ${id}`})
                    }
                
                }))
             } catch (error) {
                 console.log(error)
                 res.status(404).json({error : true, message : `There is no Admin with ID of ${id}`})
             }
        }
    }).catch(err => {
        console.log(err)
        res.status(400).json({error : true, message : `There is no Admin with ID of ${id}`})
    })
}

// @Purpose = Update Admin Pasword
// @Previlage = SuperAdmin
// @Required fields =  password, confirmationPassword
// @Optional params = Admin
// @ Success status code = 200
// @ Faillure Status code = 400
// @Request = PATCH
exports.update_admin_by_id = (req, res) => {
    //maybe sending email will be required
    const {password, confirmPassword} = req.body
    let id = req.params.admin_id

    if (id.match(/^[0-9a-fA-F]{24}$/)) {
        if(password && confirmPassword) {
        Auth.findById(id).exec()
        .then(admin => {
            if(admin && admin.type === AuthTypes.ADMIN){
                if(password.length < 8 || password != confirmPassword) {
                    res.status(401).json({error : true, message : 'Password should be at least 8 characters and should match the confirmation password!'})
                }
                else {
                    bcrypt.hash(password,10,(err, hashed) => {
                        if(err) {
                            res.status(400).json({error : err})
                        }
                        else {
                            admin.password = hashed
                            admin.save().then(() => {
                                res.status(200).json({message:'Updated!',error : false, success : true})
                            })
                        }
                    })
                }
            }
            else {
                res.status(400).json({error : true, message : 'No Admin found with this ID!'})
            }
        }).catch(err => {
            console.log(err)
            res.status(400).json({error : true, message : 'Some internal error happened.'})
        })        
    }
    else {
        res.status(400).json({error : true, message : 'password and confirmPassword should be provided!'})
    }
}
    else{
        res.status(400).json({error : true, message : 'The provided ID is not correct!'})
    }
    

    
}


// @Purpose = Authenticate the user
// @Previlage = No
// @Required fields =  username, password
// @Optional params = No
// @ Success status code = 200
// @ Faillure Status code = 400
// @Request = POST
exports.login_admin = (req, res) => {
    //not necessary anymore
    const {email, password} = req.body
    if(email && password) {
        Auth.find({email}).exec()
            .then(admins => {
                if(admins.length > 0) {
                    bcrypt.compare(password,admins[0].password,(err, result) => {
                        if(err) {
                            res.status(401).json({error : true, message : 'Auth Failed!', success:false})
                        }
                        if(result) {
                            let token = jwt.sign({
                                id : admins[0]._id,
                                email : admins[0].email, 
                                type : admins[0].type
                            }, 'PLEASE_CHANGE_IT_LATER')
                            //instead of passing the token as a response, just put it in cookie
                            res.status(200).json({error : false, success : true, info : {id : admins[0]._id, email : admins[0].email, type : admins[0].type}, token})
                        }
                        else {
                            res.status(401).json({error : true, message : 'Auth Failed!', success:false})
                        }
                    })
                }
                else {
                    res.status(401).json({error : true, message : 'Auth Failed!', success:false})
                }
            })
            .catch(err => {
                res.status(401).json({error : true, message : 'Auth Failed!', success:false})
            })
    }
    else {
        res.status(400).json({error :true, message : 'Phone number and password are required fields!'})
    }
}

// @Purpose = Logout the user
// @Previlage = No
// @Required fields =  No
// @Optional params = No
// @ Success status code = 200
// @Request = GET
exports.logout_admin = (req, res) => {
    res.status(200).json({
        success : true,
        error : false
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