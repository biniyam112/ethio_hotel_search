const { route } = require("./hotel_route");

const router = require("express").Router(),
  { EventController } = require("../controllers/controller"),
  { uploads } = require("../middlewares/middlewares");

router.get("/", EventController.get_events);
router.post(
  "/",
  uploads.upload.array("images", 3),
  EventController.create_event
);

router.get("/:eventId", EventController.get_one_event);
router.put(
  "/:eventId",
  uploads.upload.array("images", 3),
  EventController.update_event
);
router.delete("/:eventId", EventController.delete_event);

module.exports = router;
