const getMatchRequestBySenderReciverID =
  "select * from match_requests where sender_id = $1 and reciver_id = $2";

  const deleteMatchBySenderReciverID = 
  " delete from matchs where user1_id = $1 and user2_id = $2 or user1_id = $2 and user2_id = $1";

const deleteMatchRequestBySenderReciverID =
  "delete from match_requests where sender_id = $1 and reciver_id = $2";

const getMatchByUsers =
  " select * from matchs where user1_id = $1 and user2_id = $2 or user1_id = $2 and user2_id = $1";

module.exports = {
  getMatchRequestBySenderReciverID,
  deleteMatchRequestBySenderReciverID,
  getMatchByUsers,
  deleteMatchBySenderReciverID
};
