const notificationRepository = require("../../data/notification/notification-repository");

const addNotification = async (userId, notificationId) => {
    let result = await notificationRepository.addNotification(
        userId,
        notificationId
    );
    return result;
};

const getNotifications = async (userId) => {
    let result = await notificationRepository.getNotifications(userId);
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

module.exports = { addNotification, getNotificationCount, getNotifications, updateNotification };
