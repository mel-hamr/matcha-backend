const {
    createRecord,
    getAllRecords,
    updateRecord,
    deleteRecord,
    getRecordById,
    getRecordBy,
} = require("../crud");

const saveConvertaion = async (message) => {
    const conversation = {
        Participant_a: message.sender_id,
        Participant_b: message.receiver_id,
        last_message: message.message,
        is_read: false,
    };
    return await createRecord(conversation, "conversation");
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
module.exports = {
    saveConvertaion,
    saveMessage,
};
