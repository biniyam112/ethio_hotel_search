const routes = require("./index"),
  router = require("express").Router();

router.use("/hotels", routes.hotelRoute);
router.use("/events", routes.eventRoute);
router.use('/admins', routes.adminRoute)
router.use('/features', routes.featureRoute)
router.use('/rooms', routes.roomRoute)
router.use('/bookings', routes.bookingRoute)
router.use('/auth', routes.authRouter)

module.exports = router;
