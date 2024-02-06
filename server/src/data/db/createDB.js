const { Client,Pool } = require("pg");
const querys = require("./queries");

const postgresClient = new Client({
  host: "localhost",
  user: "mel-hamr",
  password: "123",
  port: 5432,
});

const matchaClient = new Client({
  host: "localhost",
  user: "mel-hamr",
  password: "123",
  database: "matcha",
  port: 5432,
});

const matchaPool = new Pool({
  user: 'mel-hamr',
  host: 'localhost',
  database: 'matcha',
  password: '123',
  port: 5432,
  max: 10, // maximum number of clients in the pool
  idleTimeoutMillis: 30000, // how long a client is allowed to remain idle before being closed
});

const createDatabase = async () => {
  try {
    await postgresClient.connect();
    const result = await postgresClient.query(querys.checkDbExist);
    if (result.rowCount === 0) {
      console.log("Database 'matcha' does not exist. Creating it...");
      await postgresClient.query(querys.createDb);
      console.log("Database 'matcha' created.");
    } else {
      console.log("Database 'matcha' already exists.");
    }
    return true;
  } catch (error) {
    console.error(error.stack);
    return false;
  }
};

const createTables = async () => {
  try {
    await matchaPool.query(querys.createTable);
    return true;
  } catch (error){
    console.log(error)
    return false;
  }
};

module.exports = {
  createDatabase,createTables,matchaClient,matchaPool
};
// how to create a express get request ?