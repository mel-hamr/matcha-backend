const express = require("express");
const crud = require("./data/db/crud");
const dataBase = require("./data/db/createDB");
const userRouter = require("./routes/user/route");
// const userRouter =require('./src/routes/user/route')
const userServices = require("./services/user/user-service");
const chatService = require("./services/chat/chat.service");
var bodyParser = require("body-parser");
var cors = require("cors");

const app = express();
const port = 3000;
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.use(
    cors({
        origin: "http://localhost:4200",
        credentials: true,
    })
);

const httpServer = require("http").createServer(app);

const io = require("socket.io")(httpServer, {
    cors: { origin: "http://localhost:4200", credentials: true },
});

// body parser
app.use("/user", userRouter);

app.get("/", (req, res) => {
    res.send("hello world");
});

app.post("/add", (req, res, data) => {
    // console.log(req.body);
    return crud.createRecord(req.body, "users", res);
});
app.post("/update", crud.updateRecord);

app.get("/start/intiate", async (req, res) => {
    await dataBase.createDatabase();
    await dataBase.createTables();
    res.status(200).send("data base created succsesfully");
});

app.get("/messages", async (req, res) => {
    const cnvId = req.query.cnvId;
    const messages = await chatService.getMessages(cnvId);
    res.status(200).send(messages);
});

// app.get("/sendMessage", async (req, res) => {
//     console.log(req.body);
//     // chatService.sendMessage()
//     res.send(200).send('sent')
// })

app.get("/conversations", async (req, res) => {
    const userID = req.query.userID;
    // console.log("room", userID);
    const conversations = await chatService.getConversations(userID);
    res.status(200).send(conversations);
});

io.on("connection", (socket) => {
    let err;
    socket.join(socket.handshake.query.roomID.toString());

    console.log(socket.handshake.headers.cookie);
    socket.on("sendFriendMessage", (message) => {
        console.log("sender", message);
        if (
            message.sender_id !== undefined &&
            message.receiver_id !== undefined &&
            message.message !== undefined
        ) {
            // need to check if sender and receiver are friends
            chatService.sendMessage(message, err);
            // console.log(
            //     message.sender_id.toString(),
            //     socket.handshake.query.roomID
            // );
            if (
                message.sender_id.toString() === socket.handshake.query.roomID
            ) {
                message.isMe = true;
                socket
                    .to(message.sender_id.toString())
                    .emit("receiveFriendMessage", message);
            } else {
                message.isMe = false;
                socket
                    .to(message.sender_id.toString())
                    .emit("receiveFriendMessage", message);
            }

            // socket
            //     .to(message.sender_id.toString())
            //     .to(message.receiver_id.toString())
            //     .emit("receiveFriendMessage", message);
        }
    });

    socket.on("disconnect", () => {
        console.log("a user disconnected!");
    });
});

httpServer.listen(port, () => console.log("hello from server port 3000"));
