const client = require("../db/createDB");
const matchaClient = client.matchaClient;
const userQueries = require("./user-queries");

const getUserByUsernameOrEmail = async (username,email_address) => {
  if (!matchaClient._connected) matchaClient.connect();
  let result = await matchaClient.query(userQueries.getByUsernameOrEmail, [username,email_address]);
  return result.rows[0];
};

module.exports = { getUserByUsernameOrEmail };
