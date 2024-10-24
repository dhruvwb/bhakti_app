const express = require("express");
const { Program } = require("../model/program"); // Adjust the path as necessary
const upload = require("../uploadMiddleware"); // Adjust the path to your Multer configuration
const router = express.Router();
// const app = express();
// Create Program Endpoint with File Uploads
router.post(
  "/programs",
  upload.fields([
    { name: "images", maxCount: 5 },
    { name: "audioTracks", maxCount: 5 },
  ]),
  async (req, res) => {
    try {
      const {
        title,
        subtitle,
        lock,
        description,
        sections,
        musicTitle,
        musicSubtitle,
      } = req.body;

      let parsedSections;
      try {
        parsedSections = JSON.parse(sections);
      } catch (error) {
        console.error("Error parsing sections:", error);
        return res.status(400).json({ error: "Invalid sections format." });
      }

      // Create a new program instance
      const program = new Program({
        title,
        subtitle,
        lock,
        description,
        sections: parsedSections,
        musicTitle, // Include audio title
        musicSubtitle,
      });

      // Process images
      if (req.files["images"]) {
        const images = req.files["images"].map((file) => ({
          programId: program._id,
          filePath: file.path,
        }));
        program.images = images;
      }

      // Process audio tracks
      if (req.files["audioTracks"]) {
        const audioTracks = req.files["audioTracks"].map((file) => ({
          programId: program._id,
          title: file.originalname,
          filePath: file.path,
        }));
        program.audioTracks = audioTracks;
      }

      // Save the program with images and audio tracks
      await program.save();

      res
        .status(201)
        .json({ message: "Program created successfully", program });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: "Error creating program", error });
    }
  }
);

// Get Programs Endpoint
router.get("/getProgramList", async (req, res) => {
  try {
    // Fetch all programs, returning only title and subtitle
    const programs = await Program.find({}, "title subtitle lock images");
    res.status(200).json(programs);
  } catch (error) {
    console.error("Error fetching programs:", error);
    res.status(500).json({ message: "Error fetching programs", error });
  }
});

// Get Program Details by ID Endpoint
router.get("/getProgramDetails/:id", async (req, res) => {
  try {
    const { id } = req.params; // Extract the ID from the request parameters

    // Fetch the program by ID, returning description and sections
    const program = await Program.findById(id, "description sections");

    if (!program) {
      return res.status(404).json({ message: "Program not found" });
    }

    res.status(200).json(program);
  } catch (error) {
    console.error("Error fetching program details:", error);
    res.status(500).json({ message: "Error fetching program details", error });
  }
});

router.get("/getMusic/:id", async (req, res) => {
  try {
    const { id } = req.params; // Extract the ID from the request parameters

    // Fetch the program by ID, returning musicTitle, musicSubtitle, and audioTracks
    const program = await Program.findById(
      id,
      "musicTitle musicSubtitle audioTracks"
    );

    if (!program) {
      return res.status(404).json({ message: "Program not found" });
    }

    res.status(200).json({
      musicTitle: program.musicTitle,
      musicSubtitle: program.musicSubtitle,
      audioTracks: program.audioTracks,
    });
  } catch (error) {
    console.error("Error fetching music details:", error);
    res.status(500).json({ message: "Error fetching music details", error });
  }
});

module.exports = router;
