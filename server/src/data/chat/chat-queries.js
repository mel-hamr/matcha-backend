const { createRecord, updateRecord } = require("../db/crud");
const chatQueries = require("../chat/queries");
const client = require("../db/createDB");
const matchaClient = client.matchaClient;

const saveConvertaion = async (message) => {
    let conversation;
    if (!matchaClient._connected) matchaClient.connect().catch((e) => {});

    conversationExist = await matchaClient.query(
        chatQueries.getConversationQuery,
        [message.sender_id, message.receiver_id]
    );
    console.log("cnv exist", conversationExist.rows);
    if (!conversationExist.rows) {
        let conversation = {
            Participant_a: message.sender_id,
            Participant_b: message.receiver_id,
            last_message: message.message,
            date: message.date,
            is_read: false,
            unread_messages: 0,
        };
        conversation = await createRecord(conversation, "conversation");
    } else {
        conversation = await updateRecord(
            "conversation",
            conversationExist.rows[0].id,
            {
                last_message: message.message,
                date: message.date,
                is_read: false,
                unread_messages: conversationExist.rows[0].unread_messages + 1,
            }
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
    console.log("save message", message);

    return await createRecord(msg, "message");
};

const getConversation = async (userID) => {
    if (!matchaClient._connected) matchaClient.connect();

    const conversations = await matchaClient.query(
        chatQueries.getUserConversationsQuery,
        [userID]
    );
    // console.log("conversation", conversations.rows);
    return conversations.rows[0];
};

const getConversations = async (userID) => {
    if (!matchaClient._connected) matchaClient.connect();

    const conversations = await matchaClient.query(
        chatQueries.getUserConversationsQuery,
        [userID]
    );
    // console.log("conversation", conversations.rows);
    return conversations.rows;
};

const getMessages = async (cnvId) => {
    // if (!matchaClient._connected) matchaClient.connect();

    const conversation = await matchaClient.query(
        chatQueries.getConversationMessages,
        [cnvId]
    );
    return conversation.rows;
};

// const sendMessage = async (cnvId, sendeId, receiverId, message, date) => {
//     const sendMessage = await matchaClient.query(chatQueries.sendMessage, [
//         cnvId,
//         sendeId,
//         receiverId,
//         message,
//         date,
//     ]);
// };

module.exports = {
    saveConvertaion,
    saveMessage,
    getConversations,
    getMessages,
};
