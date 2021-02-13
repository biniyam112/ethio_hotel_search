const multer = require("multer"),
  path = require("path"),
  uuidv4 = require("uuid/v4");

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "./uploads/");
  }, 
  filename: (req, file, cb) => {
    var filename = file.originalname.toLowerCase().split(" ").join("-");
    cb(null, uuidv4() + "-" + filename);
  },
});

const fileFilter = (req, file, cb) => {
  if (!file.originalname.match(/\.(jpeg|JPEG|jpg|JPG|png|PNG)$/)) {
    req.fileValidationError = "only image files are allowed";
    cb(null, false);
    return cb(new Error("only image files are allowed"));
  }
  cb(null, true);
};

module.exports = {
  upload: multer({ storage: storage, fileFilter: fileFilter }),
};
