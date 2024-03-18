const matchRepo = require("../../data/matchs/matchs-repository");

const sendMatchRequest = async (userId, reciverId) => {
  let reciverRequest = await matchRepo.getMatchRequestByUSendeReciverID(
    reciverId,
    userId
  );
  if (reciverRequest) {
    await matchRepo.matchUsers(userId, reciverId);
    matchRepo.deleteMatchRequestBySenderReciverID(reciverId, userId);
    return "user matched";
  } else {
    let senderRequest = await matchRepo.getMatchRequestByUSendeReciverID(
      userId,
      reciverId
    );
    if (senderRequest) {
      console.log("match request already sent");
      return "match request already sent";
    }
    await matchRepo.sendMatchRequest(userId, reciverId);
    return "match request sent";
  }
};

const getMatchStatus = async (userId, reciverId) => {
  let matchStatus = await matchRepo.getMatch(userId, reciverId);
  if (matchStatus) {
    return "matched";
  }
  let matchRequestStatus = await matchRepo.getMatchRequestByUSendeReciverID(
    userId,
    reciverId
  );
  if (matchRequestStatus) {
    return "pending";
  }
  return "unmatched";
};

const cancelMatch = async (initiatorId, reciverId) => {
  let matchStatus = await matchRepo.getMatch(initiatorId, reciverId);
  if (matchStatus) {
    await matchRepo.deleteMatchBySenderReciverID(initiatorId, reciverId);
    return "unmatched";
  }
  let matchRequestStatus = await matchRepo.getMatchRequestByUSendeReciverID(
    initiatorId,
    reciverId
  );
  if (matchRequestStatus) {
    await matchRepo.deleteMatchRequestBySenderReciverID(initiatorId, reciverId);
    return "unmatched";
  }
  return "no match";
};

module.exports = { sendMatchRequest, getMatchStatus, cancelMatch };
