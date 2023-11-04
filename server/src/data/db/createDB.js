const { Client } = require("pg");
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
    await matchaClient.connect();
    const result = await matchaClient.query(querys.createTable);
    return true;
  } catch (error){
    console.log(error)
    return false;
  }
};


module.exports = {
  createDatabase,createTables,matchaClient
};
// how to create a express get request ?