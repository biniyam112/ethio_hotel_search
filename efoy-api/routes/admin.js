const adminController = require('../controllers/admin')
const AuthMiddlewares = require('../middlewares/auth_middlewares')
const express = require('express')
const router = express.Router()

router.get('/',AuthMiddlewares.super_admin_logged_in, adminController.admins_all) //superadmin middleware must be added
router.get('/:admin_id',AuthMiddlewares.super_admin_logged_in, adminController.admin_by_id) //superadmin middleware is needed
router.post('/',AuthMiddlewares.super_admin_logged_in,  adminController.create_admin) //superadmin middlware is needed
router.delete('/:admin_id',AuthMiddlewares.super_admin_logged_in, adminController.delete_admin) //superadmin middlware must be added
router.patch('/:admin_id',AuthMiddlewares.minimal_admin_logged_in
, adminController.update_admin_by_id) //logged in admin middleware must be added
//TODO add one route for forgot password

module.exports = router