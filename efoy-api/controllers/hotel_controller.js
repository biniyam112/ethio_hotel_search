const { Hotel } = require("../models/models");
const path = require("path");
module.exports = {
  create_hotel: (req, res) => {
    const { name, location, stars, description ,adminId} = req.body;
    if (req.fileValidationError) {
      res.status(500).json({
        error: true,
        success: false,
        message: req.fileValidationError,
      });
    } else if (!req.files) {
      res.status(500).json({
        error: true,
        success: false,
        message: "error on uploading images",
      });
    } else if (name && location && stars && description &&adminId) {
      console.log(req.files);
      var images = req.files;
      Hotel.create({ name, location, stars, description,adminId })
        .then((hotel) => {
          if (hotel) {
            images.forEach((image) => {
              hotel.images.push(path.join("/uploads/", image.filename));
            });
            hotel.save();

            res.status(201).json({
              error: false,
              success: true,
              message: "hotel created",
              hotel,
            });
          }
        })
        .catch((err) => {
          res
            .status(500)
            .json({ error: true, mesage: "error on creating hotel " });
        });
    } else {
      res.status(400).json({
        error: true,
        mesage: "name, location ,stars, or description should not be blank",
      });
    }
  },
  find_all_hotels: (req, res) => {
    Hotel.find().then((hotels) => {
      if (hotels) {
        res.status(200).json({
          error: false,
          success: true,
          message: "success on fetching hotels",
          hotels,
        });
      } else {
        res.status(404).json({
          error: true,
          success: false,
          message: "error on fetching hotel data hotels not found",
        });
      }
    });
  },
  find_one_hotel: (req, res) => {
    var hotelId = req.params.hotelId;

    if (hotelId) {
      Hotel.findById(hotelId)
        .populate({ path: "events" })
        .then((hotel) => {
          if (hotel) {
            res.status(200).json({ error: false, success: true, data: hotel });
          } else {
            res.status(404).json({
              error: true,
              success: false,
              message: `error on fetching hotel data with hotel id ${hotelId}`,
            });
          }
        })
        .catch((err) => {
          if (err.name === "NotFound" || err.kind === "ObjectId") {
            res.status(404).json({
              error: true,
              success: false,
              message: `hotel  not found with hotel id ${hotelId} ${err.message}`,
            });
          } else {
            res
              .status(500)
              .json({ error: true, success: false, message: err.message });
          }
        });
    } else {
      res.status(500).json({
        error: true,
        success: false,
        message: `undefined hotel id ${hotelId}`,
      });
    }
  },
  update_hotel: (req, res) => {
    var hotelId = req.params.hotelId;

    const { name, location, stars, description } = req.body;

    if (req.fileValiationError) {
      res.status(500).json({
        error: true,
        success: false,
        message: req.fileValidationError,
      });
    } else if (!req.files) {
      res.status(500).json({
        error: true,
        success: false,
        message: "error on uploading images",
      });
    } else if (name && location && stars && description && hotelId) {
      Hotel.findByIdAndUpdate(
        hotelId,
        { name, location, stars, description },
        { new: true }
      )
        .then((hotel) => {
          var images = req.files;
          if (hotel) {
            images.forEach((image) => {
              hotel.images.push(path.join("/uploads/", image.filename));
            });
            hotel.save();
            res.status(200).json({ error: false, success: true, data: hotel });
          } else {
            res.status(404).json({
              error: true,
              success: false,
              message: `error on updating hotel data with id ${hotelId}`,
            });
          }
        })
        .catch((err) => {
          if (err.kind === "ObjectId") {
            res.status(404).json({
              error: true,
              success: false,
              message: `hotel not found with hotel id ${hotelId}`,
            });
          } else {
            res.status(500).json({
              error: true,
              success: false,
              message: `error on updating hotel data with hotel id ${hotelId} ${err.message}`,
            });
          }
        });
    } else {
      res.status(400).json({
        error: true,
        success: false,
        message: "content can not be empty",
      });
    }
  },
  delete_hotel: (req, res) => {
    var hotelId = req.params.hotelId;

    if (hotelId) {
      Hotel.findByIdAndRemove(hotelId)
        .then((hotel) => {
          if (!hotel) {
            res.status(404).json({
              error: true,
              success: false,
              message: `hotel with id ${hotelId} NotFound`,
            });
          } else {
            res.status(200).json({
              error: false,
              success: true,
              message: "Hotel delted successfully",
            });
          }
        })
        .catch((err) => {
          if (err.kind === "ObjectId" || err.name === "NotFound") {
            res
              .status(404)
              .json({ error: true, success: false, message: err.message });
          } else {
            res.status(500).json({
              error: true,
              success: false,
              message: `couldn't delete hotel with id ${hotelId} ${err.mesage}`,
            });
          }
        });
    } else {
      res
        .status(500)
        .json({ error: true, success: false, message: `hotel id undefined ` });
    }
  },
  deleteAll: (req, res) => {},
};
