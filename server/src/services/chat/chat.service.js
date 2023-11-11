const {
    saveConvertaion,
    saveMessage,
} = require("../../data/chat/chat-queries");

const sendMessage = async (data, err) => {
    try {
        data.date = new Date();
        const conversation = await saveConvertaion(data);
        data.cnvId = conversation.id;
        await saveMessage(data);
    } catch (e) {
        console.log(e);
    }
};

const getConversation = async (data) => {
    const messages = await getConversation(data);
    return messages;
};

module.exports = {
    sendMessage,
    getConversation,
};
