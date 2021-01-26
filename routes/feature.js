const express = require('express')
const router = express.Router()

const featureController = require('../controllers/feature')

router.get('/', featureController.features_all)
router.get('/:feature_id', featureController.feature_by_id)
router.post('/',featureController.create_feature)
router.delete('/:feature_id', featureController.delete_feature)

module.exports = router