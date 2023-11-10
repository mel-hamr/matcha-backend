const {
    saveConvertaion,
    saveMessage,
} = require("../../data/db/chat/chat-queries");

const sendMessage = async (data) => {
    data.date = new Date();
    const conversation = await saveConvertaion(data);
    data.cnvId = conversation.id;
    await saveMessage(data);
};

module.exports = {
    sendMessage,
};
