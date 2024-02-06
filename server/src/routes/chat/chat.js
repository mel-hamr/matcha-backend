const express = require("express");
const chatRouter = express.Router();
const chatService = require("../../services/chat/chat.service");

chatRouter.get("/messages", async (req, res) => {
    const cnvId = req.query.cnvId;
    const userID = req.query.userID;

    // console.log(cnvId);
    const messages = await chatService.getMessages(cnvId, userID);
    res.status(200).send(messages);
});

chatRouter.get("/conversations", async (req, res) => {
    const userID = req.query.userID;
    // console.log("room", userID);
    const conversations = await chatService.getConversations(userID);
    res.status(200).send(conversations);
});

chatRouter.get("/notifications", async (req, res) => {
    const userID = req.query.userID;
    const notification = await chatService.getNotifications(userID);
    res.status(200).send(notification);
});

module.exports = chatRouter;
