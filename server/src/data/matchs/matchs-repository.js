const client = require("../../data/db/createDB");
const matchaPool = client.matchaPool;
const matchQuery = require("./matchs-query");
const generalCrude = require("../db/crud");

const getMatchRequestByUSendeReciverID = async (senderID, reciverID) => {
  let result = await matchaPool.query(
    matchQuery.getMatchRequestBySenderReciverID,
    [senderID, reciverID]
  );
  return result.rows[0];
};

const getMatch = async (user1_id, user2_id) => {
  let result = await matchaPool.query(matchQuery.getMatchByUsers, [
    user1_id,
    user2_id,
  ]);
  return result.rows[0];
};

const matchUsers = async (user1_id, user2_id) => {
  let result = await generalCrude.createRecord(
    {
      user1_id: user1_id,
      user2_id: user2_id,
    },
    "matchs"
  );
  return result;
};

const deleteMatchBySenderReciverID = async (senderID, reciverID) => {
  let result = await matchaPool.query(
    matchQuery.deleteMatchBySenderReciverID,
    [senderID, reciverID]
  );
  return result;
};

const sendMatchRequest = async (senderId, reciverId) => {
  let result = await generalCrude.createRecord(
    {
      sender_id: senderId,
      reciver_id: reciverId,
    },
    "match_requests"
  );
  return result;
};

const deleteMatchRequestBySenderReciverID = async (senderID, reciverID) => {
  let result = await matchaPool.query(
    matchQuery.deleteMatchRequestBySenderReciverID,
    [senderID, reciverID]
  );
  return result;
};

module.exports = {
  getMatchRequestByUSendeReciverID,
  matchUsers,
  sendMatchRequest,
  getMatch,
  deleteMatchRequestBySenderReciverID,
  deleteMatchBySenderReciverID
};
