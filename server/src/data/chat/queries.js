const getConversationQuery = `SELECT * FROM conversation WHERE (participant_a = $1 AND participant_b = $2) OR (participant_a = $2 AND participant_b = $1) `;

module.exports = { getConversationQuery}