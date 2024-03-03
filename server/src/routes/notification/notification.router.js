const notificationRouter = require("express").Router();

const notificationService = require("../../services/notification/notification.service");

notificationRouter.post("/add", async (req, res) => {
    const userId = req.query.userId;
    const notificationId = req.body.notificationId;
    const notification = await notificationService.addNotification(
        userId,
        notificationId
    );
    res.status(200).send(notification);
});

notificationRouter.put("/resetAllRead", async (req, res) => {
    console.log('resetAllRead');
    const userId = 1;
    console.log('resetAllRead', userId);
    const notification = await notificationService.resetNotificationRead(
        userId
    );
    res.status(200).send(notification);
});

const calculateDate = (date) => {
    // NOTE this function is duplicated in chat.service.js
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

notificationRouter.get("/", async (req, res) => {
    const userId = req.query.userId;
    console.log(userId);
    const notifications = await notificationService.getNotifications(userId);
    notifications.map((notification) => {
        console.log(calculateDate(notification.created_at));
        notification.created_at = calculateDate(notification.created_at);
    });
    res.status(200).send(notifications);
});

notificationRouter.get("/count", async (req, res) => {
    const userId = req.query.userId;
    const count = await notificationService.getNotificationCount(userId);
    res.status(200).send(count);
});

notificationRouter.post("/update", async (req, res) => {
    const userId = req.query.userId;
    const notificationId = req.body.notificationId;
    const notification = await notificationService.updateNotification(
        userId,
        notificationId
    );
    res.status(200).send(notification);
});

module.exports = notificationRouter;
