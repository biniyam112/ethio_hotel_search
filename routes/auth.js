const express = require('express')
const authConroller = require('../controllers/auth')

const router = express.Router()

router.post('/login', authConroller.login_user) //no previlege is needed

module.exports = router