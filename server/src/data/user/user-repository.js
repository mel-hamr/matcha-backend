const client = require("../db/createDB");
const userQueries = require("./user-queries");
const matchaPool = client.matchaPool;

const getUserByUsernameOrEmail = async (username,email_address) => {
  
  let result = await matchaPool.query(userQueries.getByUsernameOrEmail, [username,email_address]);
  return result.rows[0];
};

module.exports = { getUserByUsernameOrEmail };
