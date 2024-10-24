const mongoose = require("mongoose");

// Define the schema for images
const imageSchema = new mongoose.Schema({
  programId: { type: mongoose.Schema.Types.ObjectId, ref: "Program" },
  filePath: { type: String, required: true }, // Path to the image
});

// Define the schema for audio tracks
const audioTrackSchema = new mongoose.Schema({
  programId: { type: mongoose.Schema.Types.ObjectId, ref: "Program" },
  title: { type: String, required: true }, // Title of the audio track
  filePath: { type: String, required: true }, // Path to the audio file
});

// Define the main Program schema
const programSchema = new mongoose.Schema({
  title: { type: String, required: true },
  subtitle: { type: String, required: true },
  lock: { type: Boolean, required: true },
  description: { type: String, required: true },
  sections: [
    {
      title: String,
      description: Array,
    },
  ],
  images: [imageSchema], // Embed images
  audioTracks: [audioTrackSchema], // Embed audio tracks
  musicTitle: { type: String, required: true }, // New field for audio title
  musicSubtitle: { type: String, required: true }, // New field for audio subtitle
});

// Create and export the models
const Program = mongoose.model("Program", programSchema);
const Image = mongoose.model("Image", imageSchema);
const AudioTrack = mongoose.model("AudioTrack", audioTrackSchema);

module.exports = { Program, Image, AudioTrack };
