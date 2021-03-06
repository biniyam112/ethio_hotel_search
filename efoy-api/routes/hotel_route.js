const { HotelController } = require("../controllers/controller"),
  { uploads } = require("../middlewares/middlewares"),
  router = require("express").Router();

const AuthMiddleware = require('../middlewares/auth_middlewares')

router.post(
  "/",
  uploads.upload.array("images", 3),
  HotelController.create_hotel
);
router.get("/:hotelId", HotelController.find_one_hotel);
router.get("/",  HotelController.find_all_hotels);
router.put(
  "/:hotelId",AuthMiddleware.hotel_logged_in,
  uploads.upload.array("images", 3),
  HotelController.update_hotel
);
router.delete("/:hotelId", AuthMiddleware.minimal_admin_logged_in, HotelController.delete_hotel);

module.exports = router;
