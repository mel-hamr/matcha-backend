const notificationRepository = require("../../data/notification/notification-repository");

const addNotification = async (userId, type, text) => {
    return await notificationRepository.addNotification(userId, type, text);
};

const getNotifications = async (userId) => {
    let result = await notificationRepository.getNotifications(userId);
    return result;
};

const resetNotificationRead = async (userId) => {
    let result = await notificationRepository.resetNotificationRead(userId);
    return result;
};

const getNotificationCount = async (userId) => {
    let result = await notificationRepository.getNotificationCount(userId);
    return result;
};

const updateNotification = async (userId, notificationId) => {
    let result = await notificationRepository.updateNotification(
        userId,
        notificationId
    );
    return result;
};

module.exports = {
    addNotification,
    getNotificationCount,
    getNotifications,
    updateNotification,
    resetNotificationRead,
};
