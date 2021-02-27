const adminController = require('../controllers/admin')
const AuthMiddlewares = require('../middlewares/auth_middlewares')
const express = require('express')
const router = express.Router()

router.get('/',adminController.admins_all) //superadmin middleware must be added
router.get('/:admin_id', adminController.admin_by_id) //superadmin middleware is needed
router.post('/', adminController.create_admin) //superadmin middlware is needed
router.delete('/:admin_id',AuthMiddlewares.super_admin_logged_in, adminController.delete_admin) //superadmin middlware must be added
router.patch('/:admin_id', adminController.update_admin_by_id) //logged in admin middleware must be added
//TODO add one route for forgot password

module.exports = router