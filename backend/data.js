const mongoose = require("mongoose");
const Program = require("./models/program");

// Connect to MongoDB
mongoose.connect("mongodb://localhost:27017/inner_bhakti", {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

const programs = [
  {
    title: "Work Stress 1",
    subtitle: "20 day plan",
    lock: false,
    image: "path/to/image1.jpg",
    description:
      "The Medito course will help you to learn more about yourself and the world around you. Join us on this transformative journey of mindfulness, compassion, and insight.",
    sections: [
      { title: "Getting started", description: "A few short intro sessions" },
      { title: "Learning to sit", description: "Building up to 10 minutes" },
      { title: "Mindfulness", description: "Build your practice" },
    ],
    audioTracks: [
      { title: "Track 1", file: "path/to/audio1.mp3" },
      { title: "Track 2", file: "path/to/audio2.mp3" },
    ],
  },
  {
    title: "Work Stress 2",
    subtitle: "20 day plan",
    lock: true,
    image: "path/to/image2.jpg",
    description:
      "This program focuses on managing work stress through mindfulness and relaxation techniques.",
    sections: [
      {
        title: "Intro to Stress Management",
        description: "Understanding stress",
      },
      {
        title: "Techniques for Relaxation",
        description: "Learn techniques to relax",
      },
      { title: "Long-term Strategies", description: "Build your resilience" },
    ],
    audioTracks: [{ title: "Track 3", file: "path/to/audio3.mp3" }],
  },
];

// Function to seed the database
async function seedDB() {
  await Program.deleteMany({}); // Clear existing data
  await Program.insertMany(programs); // Insert sample data
  console.log("Data added!");
  mongoose.connection.close(); // Close connection
}

// Run the seed function
seedDB();
