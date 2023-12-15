const notification = require("../../data/notification/notification-repository");

const getNotificationCount = async (userId) => {
    let result = await notification.getNotificationCount(userId);
    return result;
};

module.exports = { getNotificationCount };
