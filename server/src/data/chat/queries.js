const getConversationQuery = `SELECT * FROM conversation WHERE (participant_a = $1 AND participant_b = $2) OR (participant_a = $2 AND participant_b = $1) `;
const getConversationsQuery = `SELECT * FROM conversation WHERE (participant_a = $1) OR (participant_b = $1) `;

const getUserConversationsQuery = `SELECT public.conversation.id, last_message, date, is_read, username, images[1] as avatar
FROM conversation
RIGHT JOIN users ON
    CASE
        WHEN conversation.participant_b = $1 THEN users.id = conversation.participant_a
        WHEN conversation.participant_a = $1 THEN users.id = conversation.participant_b
    END
WHERE conversation.participant_a = $1 OR conversation.participant_b = $1;`;
module.exports = { getConversationQuery, getConversationsQuery, getUserConversationsQuery };
