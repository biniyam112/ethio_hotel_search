const adminController = require('../controllers/admin')
const express = require('express')
const router = express.Router()

router.get('/', adminController.admins_all)
router.get('/:admin_id', adminController.admin_by_id)
router.post('/', adminController.create_admin)
router.delete('/:admin_id', adminController.delete_admin)
router.patch('/:admin_id', adminController.update_admin_by_id)
router.post('/auth', adminController.login_admin)
module.exports = router