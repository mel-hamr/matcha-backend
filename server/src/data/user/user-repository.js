const client = require("../db/createDB");
const userQueries = require("./user-queries");
const matchaPool = client.matchaPool;
const generalCrude = require("../db/crud");

const getUserByUsernameOrEmail = async (username, email_address) => {
  let result = await matchaPool.query(userQueries.getByUsernameOrEmail, [
    username,
    email_address,
  ]);
  return result.rows[0];
};

const ceateRateUserRecord = async (rater_user_id, rated_user_id, rating) => {
  let result = await generalCrude.createRecord(
    { rater_user_id, rated_user_id, rating },
    "rating"
  );

  return result;
};

const getRatingByRaterAndRated = async (rater_user_id, rated_user_id) => {
  let result = await matchaPool.query(userQueries.getRatingByRaterAndRated, [
    rater_user_id,
    rated_user_id,
  ]);
  return result.rows[0];
};
const updateUserRating = async (rating, id) => {
  let result = await matchaPool.query(userQueries.updateUserRating, [rating, id]);
  return result.rows[0];
};

const getUserByUsername = async (username) => {
  let result = await matchaPool.query(userQueries.getUserByUsername, [username]);
  return result.rows[0];

}
module.exports = {
  getUserByUsernameOrEmail,
  ceateRateUserRecord,
  getRatingByRaterAndRated,
  updateUserRating,
  getUserByUsername
};
