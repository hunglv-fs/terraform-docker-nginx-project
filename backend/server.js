require("dotenv").config();
const express = require("express");
const pool = require("./db");
const redisClient = require("./redis");
const cors = require("cors");
const app = express();
app.use(express.json());
app.use(cors());

const PORT = 4000;

// Test route
app.get("/", async (req, res) => {
  res.json({ message: "Node API is running!" });
});

// Test PostgreSQL connection
app.get("/db-test", async (req, res) => {
  try {
    const result = await pool.query("SELECT NOW()");
    res.json({ success: true, time: result.rows[0].now });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Test Redis connection
app.get("/redis-test", async (req, res) => {
  try {
    await redisClient.set("test_key", "Hello from Redis!");
    const value = await redisClient.get("test_key");
    res.json({ success: true, value });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
