const routes = require("./index"),
  router = require("express").Router();

router.use("/hotels", routes.hotelRoute);
router.use("/events", routes.eventRoute);
module.exports = router;
