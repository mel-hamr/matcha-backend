const notificationRouter = require("express").Router();

const notificationService = require("../../services/notification/notification.service");

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



module.exports = notificationRouter;
