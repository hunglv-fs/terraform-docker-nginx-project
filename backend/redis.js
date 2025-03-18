const redis = require("redis");

const redisClient = redis.createClient({
  url: `redis://${process.env.REDIS_HOST}:6379`,
});

redisClient.on("error", (err) => console.error("Redis Error:", err));

redisClient.connect();

module.exports = redisClient;
