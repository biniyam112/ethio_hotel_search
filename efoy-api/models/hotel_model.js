const mongoose = require("mongoose"),
  { Schema } = mongoose;
const HotelSchema = new Schema(
  {
    name: {
      type: String,
      required: true,
      unique: true,
    },
    location: {
      type: String,
      required: true,
    },
    stars: {
      type: Number,
      required: true,
    },
    description: {
      type: String,
      required: true,
    },
    adminId:{
      type:mongoose.Schema.Types.ObjectId,
      required:true
    },
    images: [
      {
        type: String,
        required: true,
      },
    ],
  },
  { timestamps: true },
  {
    toJSON: { virtual: true },
    toObject: { virtual: true },
  }
);

HotelSchema.virtual("rooms", {
  ref: "Room",
  localField: "_id",
  foreignField: "hotel",
});

HotelSchema.virtual("events", {
  ref: "Events",
  localField: "_id",
  foreignField: "hotel",
});
HotelSchema.virtual("bookings", {
  ref: "Booking",
  localField: "_id",
  foreignField: "hotel",
});

HotelSchema.set("toObject", { virtuals: true });
HotelSchema.set("toJSON", { virtuals: true });
module.exports = mongoose.model("Hotels", HotelSchema);
