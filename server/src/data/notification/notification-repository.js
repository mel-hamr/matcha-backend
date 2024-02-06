
const client = require('../../data/db/createDB');
const notificationQery = require('./notification-query');
const matchaPool = client.matchaPool;


const getNotificationCount = async (userId) => {
    let result = await matchaPool.query(notificationQery.notificationCountQuery, [userId]);
    return result.rows[0];
}

module.exports = {getNotificationCount};