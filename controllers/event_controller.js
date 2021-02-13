const event_model = require("../models/event_model");
const { Event } = require("../models/models");
const path = require("path");

module.exports = {
  create_event: (req, res) => {
    const { title, description, hotel } = req.body;

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
        message: "empty images body",
      });
    } else if (title && description && hotel) {
      Event.create({ title, description, hotel })
        .then((event) => {
          const images = req.files;

          images.forEach((image) => {
            event.images.push(path.join("/uploads/", image.filename));
          });
          event.save();
          res.status(201).json({ error: false, success: true, data: event });
        })
        .catch((error) => {
          res.status(500).json({
            error: true,
            success: false,
            message: `error on creating an event ${error.message}`,
          });
        });
    } else {
      res.status(500).json({
        error: true,
        success: false,
        message: "content can't be empty",
      });
    }
  },
  get_events: (req, res) => {
    // var hotel_id = req.params.hotel;
    Event.find()
      .then((events) => {
        if (events) {
          res.status(200).json({ error: false, success: true, data: events });
        } else {
          res.status(404).json({
            error: true,
            success: false,
            message: ` events events not found`,
          });
        }
      })
      .catch((err) => {
        res.status(404).json({
          error: true,
          success: false,
          message: `error on fetching events ${err.message}`,
        });
      });
  },

  get_one_event: (req, res) => {
    var event_id = req.params.eventId;
    if (event_id) {
      Event.findById(event_id)
        .then((event) => {
          res.status(200).json({ error: false, success: true, data: event });
        })
        .catch((err) => {
          res.status(404).json({
            error: true,
            success: false,
            message: `event not found ${err.message}`,
          });
        });
    } else {
      res
        .status(404)
        .json({ error: true, success: false, message: "undefined event id" });
    }
  },
  update_event: (req, res) => {
    var event_id = req.params.eventId;

    // var hotel_id=req.params.hotel;
    const { title, description, hotel } = req.body;
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
        message: "empty images body",
      });
    } else if (title && description && hotel && event_id) {
      Event.findByIdAndUpdate(
        event_id,
        { title, description, hotel },
        { new: true }
      )
        .then((event) => {
          console.log(event);
          const images = req.files;
          console.log(images);

          if (event) {
            images.forEach((image) => {
              event.images.push(path.join("/uploads/", image.filename));
            });
            event.save();
            res.status(201).json({ error: false, success: true, data: event });
          } else {
            res
              .status(404)
              .json({
                error: true,
                success: false,
                message: "event not found",
              });
          }
        })
        .catch((err) => {
          if (err.kind === "ObjectId" || err.name === "NotFound") {
            res.status(404).json({
              error: true,
              success: false,
              message: `Event with the id ${event_id} Not found`,
            });
          } else {
            res.status(500).json({
              error: true,
              success: false,
              message: `error on updating event ${err.message}`,
            });
          }
        });
    }
  },
  delete_event: (req, res) => {
    const event_id = req.params.eventId;
    if (event_id) {
      Event.findByIdAndRemove(event_id)
        .then((event) => {
          if (!event) {
            res.status(404).json({
              error: true,
              success: false,
              message: `event with id ${event_id} Not found`,
            });
          } else {
            res.status(200).json({
              error: false,
              success: true,
              message: "Event deleted successfully",
            });
          }
        })
        .catch((err) => {
          if (err.name === "NotFound" || err.kind === "ObjectId") {
            res
              .status(404)
              .json({ error: true, success: false, message: `${err.message}` });
          } else {
            res
              .status(500)
              .json({ error: true, success: false, message: `${err.message}` });
          }
        });
    } else {
      res
        .status(500)
        .json({ error: true, success: false, message: `undefined event id ` });
    }
  },
};
