const chatRepository = require("../../data/chat/chat-queries");

const sendMessage = async (data, err) => {
    data.date = new Date();
    const conversation = await chatRepository.saveConvertaion(data);
    data.cnvId = conversation.id;
    await chatRepository.saveMessage(data);
};

const getConversation = async (userID) => {
    const conversations = await chatRepository.getConversation(userID);
    return conversations;
};

const getMessages = async (cnvId, userID) => {
    // id: number;
    // message: string;
    // date: Date;
    // isMe: boolean;
    // console.log('cnvId',cnvId);
    let conversation = await chatRepository.getMessages(cnvId);
    conversation = conversation.map((message) => {
        // if(message.sender === userID)
        // console.log("sender", userID);
        return {
            id: message.id,
            message: message.text,
            date: message.date,
            isMe: message.sender === userID ? true : false,
        };
    });
    // console.log(conversation);
    return conversation;
};
const getConversations = async (userID) => {
    const conversations = await chatRepository.getConversations(userID);
    // console.log(conversations);
    const updatedConversations = conversations.map((conversation) => ({
        id: conversation.id,
        name: conversation.username,
        avatar: conversation.avatar,
        user_id: conversation.user_id,
        lastMessage: conversation.last_message,
        date: calculateDate(conversation.date),
        isRead: conversation.is_read,
    }));

    // console.log(updatedConversations);
    return updatedConversations;
};

const calculateDate = (date) => {
    const currentDate = new Date();
    const dateDiffrentInMs = currentDate.getTime() - date.getTime();
    let ret;
    // console.log(dateDiffrentInMs);
    if (dateDiffrentInMs < 60 * 60 * 1000) {
        ret = Math.trunc(dateDiffrentInMs / (60 * 1000)) + "m ago";
    } else if (dateDiffrentInMs < 24 * 60 * 60 * 1000) {
        ret = Math.trunc(dateDiffrentInMs / (60 * 60 * 1000)) + "h ago";
    } else if (dateDiffrentInMs < 7 * 24 * 60 * 60 * 1000) {
        ret = Math.trunc(dateDiffrentInMs / (24 * 60 * 60 * 1000)) + "d ago";
    } else if (dateDiffrentInMs < 30 * 24 * 60 * 60 * 1000) {
        ret =
            Math.trunc(dateDiffrentInMs / (7 * 24 * 60 * 60 * 1000)) + "w ago";
    }
    // console.log(Math.trunc(dateDiffrentInMs / (60 * 60 * 1000)));
    return ret;
};

module.exports = {
    sendMessage,
    getConversations,
    getMessages,
};
