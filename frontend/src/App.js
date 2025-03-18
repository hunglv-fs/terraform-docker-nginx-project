import React, { useEffect, useState } from "react";

function App() {
  const [dbData, setDbData] = useState(null);
  const [redisData, setRedisData] = useState(null);

  useEffect(() => {
    fetch("http://localhost:4000/db-test")
      .then((res) => res.json())
      .then((data) => setDbData(data))
      .catch((err) => console.error("Error fetching DB data:", err));

    fetch("http://localhost:4000/redis-test")
      .then((res) => res.json())
      .then((data) => setRedisData(data))
      .catch((err) => console.error("Error fetching Redis data:", err));
  }, []);

  return (
    <div style={{ textAlign: "center", padding: "20px" }}>
      <h1>React Frontend</h1>

      <h2>PostgreSQL Data</h2>
      {dbData ? <pre>{JSON.stringify(dbData, null, 2)}</pre> : <p>Loading...</p>}

      <h2>Redis Data</h2>
      {redisData ? <pre>{JSON.stringify(redisData, null, 2)}</pre> : <p>Loading...</p>}
    </div>
  );
}

export default App;
