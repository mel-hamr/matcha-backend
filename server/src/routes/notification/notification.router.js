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

notificationRouter.get("/", async (req, res) => {
    const userId = req.query.userId;
    const notifications = await notificationService.getNotifications(userId);
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
