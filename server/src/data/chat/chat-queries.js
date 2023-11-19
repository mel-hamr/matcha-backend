const {
    createRecord,
    getAllRecords,
    updateRecord,
    deleteRecord,
    getRecordById,
    getRecordBy,
} = require("../db/crud");
const {
    getConversationQuery,
    getConversationsQuery,
    getUserConversationsQuery,
} = require("../chat/queries");
const client = require("../db/createDB");
const matchaClient = client.matchaClient;

const saveConvertaion = async (message) => {
    let conversation;
    if (!matchaClient._connected) matchaClient.connect().catch((e) => {});

    conversationExist = await matchaClient.query(getConversationQuery, [
        message.sender_id,
        message.receiver_id,
    ]);

    if (!conversationExist.rows.length) {
        const conversation = {
            Participant_a: message.sender_id,
            Participant_b: message.receiver_id,
            last_message: message.message,
            is_read: false,
        };
        conversation = await createRecord(conversation, "conversation");
    } else {
        conversation = await updateRecord(
            "conversation",
            conversationExist.rows[0].id,
            { last_message: message.message, is_read: false }
        );
    }
    return conversation;
};

const saveMessage = async (message) => {
    const msg = {
        conversation_id: message.cnvId,
        sender: message.sender_id,
        text: message.message,
        date: message.date,
    };
    return await createRecord(msg, "message");
};

const getConversation = async (userID) => {
    if (!matchaClient._connected) matchaClient.connect();

    const conversations = await matchaClient.query(getUserConversationsQuery, [
        userID,
    ]);
    console.log("conversation", conversations.rows);
    return conversations.rows[0];
};


const getConversations = async (userID) => {
    if (!matchaClient._connected) matchaClient.connect();

    const conversations = await matchaClient.query(getUserConversationsQuery, [
        userID,
    ]);
    console.log("conversation", conversations.rows);
    return conversations.rows;
};

module.exports = {
    saveConvertaion,
    saveMessage,
    getConversations,
};
