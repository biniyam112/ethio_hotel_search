const { HotelController } = require("../controllers/controller"),
  { uploads } = require("../middlewares/middlewares"),
  router = require("express").Router();


router.post(
  "/",
  uploads.upload.array("images", 3),
  HotelController.create_hotel
);
router.get("/:hotelId", HotelController.find_one_hotel);
router.get("/", HotelController.find_all_hotels);
router.put(
  "/:hotelId",
  uploads.upload.array("images", 3),
  HotelController.update_hotel
);
router.delete("/:hotelId", HotelController.delete_hotel);

module.exports = router;
