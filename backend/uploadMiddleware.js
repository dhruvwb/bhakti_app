const multer = require("multer");
const path = require("path");

// Storage configuration for images and audio files
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    if (file.mimetype.startsWith("image")) {
      cb(null, "./uploads/images");
    } else if (file.mimetype.startsWith("audio")) {
      cb(null, "./uploads/audio");
    } else {
      cb(new Error("Invalid file type"), false);
    }
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + path.extname(file.originalname)); // Generate a unique name
  },
});

// File filter to accept only images and MP3 files
const fileFilter = (req, file, cb) => {
  if (file.mimetype.startsWith("image") || file.mimetype === "audio/mpeg") {
    cb(null, true);
  } else {
    cb(new Error("Invalid file type, only images and MP3 allowed"), false);
  }
};

// Initialize Multer
const upload = multer({
  storage: storage,
  fileFilter: fileFilter,
});

module.exports = upload;
