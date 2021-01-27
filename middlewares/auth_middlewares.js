const jwt = require('jsonwebtoken')

const AuthTypes = require('../utils/auth_types')

exports.minimal_admin_logged_in = (req, res, next) => {
    const authHeader = req.headers['authorization']
    const authToken = authHeader && authHeader.split(' ')[1]

    if(authToken) {
        jwt.verify(authToken,'PLEASE_CHANGE_IT_LATER',(err, decode) => {
        if(err) {
            res.status(401).json({error : true, message : 'Unauthorized Personnel!'})
        }
        else{
            if(decode.type === AuthTypes.ADMIN || decode.type === AuthTypes.SUPERADMIN){
                next()
                
            }
            else{
                res.status(401).json({error : true, message : 'Unauthorized Personnel!'})
            }
        }
    })
    }else{
        res.status(401).json({error : true, message : 'Unauthorized Personnel!'})
    }    
}

exports.super_admin_logged_in = (req, res, next) => {
    const authHeader = req.headers['authorization']
    const authToken = authHeader && authHeader.split(' ')[1]

    if(authToken) {
        jwt.verify(authToken,'PLEASE_CHANGE_IT_LATER',(err, decode) => {
        if(err) {
            res.status(401).json({error : true, message : 'Unauthorized Personnel!'})
        }
        else{
            if(decode.type === AuthTypes.SUPERADMIN){
                next()
            }
            else{
                res.status(401).json({error : true, message : 'Unauthorized Personnel!'})
            }
        }
    })
    }else{
        res.status(401).json({error : true, message : 'Unauthorized Personnel!'})
    }
}