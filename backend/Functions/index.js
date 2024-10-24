const express = require("express");
const mongoose = require("mongoose");
const programRouter = require("./api"); // Import the program routes
const dotenv = require("dotenv");
const WebSocket = require("ws");
const cors = require("cors");
const router = express.Router();
const serverless = require("serverless-http");

dotenv.config();

const app = express();
app.use(express.json()); // Middleware to parse JSON
app.use(cors());
// Connect to MongoDB
mongoose
  .connect(process.env.MongoDB, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
  .then(() => console.log("Db connection Successful"))
  .catch((err) => {
    console.log(err);
  });

// Use the program routes
app.use("/api", programRouter);

// Start the HTTP server
const PORT = process.env.PORT || 5000;
const server = app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

// Create a WebSocket server
// const wss = new WebSocket.Server({ server });

// // Handle WebSocket connections
// wss.on("connection", (ws) => {
//   console.log("New client connected");

//   // Send a message to the connected client
//   ws.send("Welcome to the WebSocket server!");

//   // Handle incoming messages from clients
//   ws.on("message", (message) => {
//     console.log(`Received: ${message}`);
//     // Echo the message back to the client
//     ws.send(`You said: ${message}`);
//   });

//   // Handle client disconnection
//   ws.on("close", () => {
//     console.log("Client disconnected");
//   });
// });

app.use("/.netlify/functions/api", router);
module.exports.handler = serverless(app);
