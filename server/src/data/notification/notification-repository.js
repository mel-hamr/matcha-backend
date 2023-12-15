const client = require("../../data/db/createDB");
const notificationQuery = require("./notification-query");
const matchaPool = client.matchaPool;

const addNotification = async (userId, notificationId) => {
    let result = await matchaPool.query(
        notificationQuery.addNotificationQuery,
        [userId]
    );
    return result.rows[0];
}
const getNotifications = async (userId) => {
    let result = await matchaPool.query(
        notificationQuery.getNotificationQuery,
        [userId]
    );
    return result.rows;
};

const getNotificationCount = async (userId) => {
    let result = await matchaPool.query(
        notificationQuery.notificationCountQuery,
        [userId]
    );
    return result.rows[0];
};

const updateNotification = async (userId, notificationId) => {
    let result = await matchaPool.query(
        notificationQuery.updateNotificationQuery,
        [userId, notificationId]
    );
    return result.rows[0];
}

module.exports = { addNotification, getNotificationCount, getNotifications, updateNotification };
