const express = require("express");
const crud = require("./data/db/crud");
const dataBase = require("./data/db/createDB");
// const userRouter =require('./src/routes/user/route')
var bodyParser = require("body-parser");

const app = express();
const port = 3000;
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

const httpServer = require("http").createServer(app);

const chatService = require("./services/chat/chat.service");

const io = require("socket.io")(httpServer, {
    cors: { origin: "*" },
});

// body parser

app.get("/", (req, res) => {
    res.send("hello world");
    console.log("hello world");
});

app.post("/add", (req, res, data) => {
    // console.log(req.body);
    return crud.createRecord(req.body, "users", res);
});
app.post("/update", crud.updateRecord);

app.get("/start/intiate", async (req, res) => {
    // await dataBase.createDatabase();
    await dataBase.createTables();
    res.status(200).send("data base created succsesfully");
});

io.on("connection", (socket) => {
    socket.join(socket.handshake.query.roomID.toString());

    socket.on("sendFriendMessage", (message) => {
        chatService.sendMessage(message);
        console.log(message.receiver_id);
        socket
            .to(message.sender_id.toString())
            .to(message.receiver_id.toString())
            .emit("receiveFriendMessage", message);
    });

    socket.on("disconnect", () => {
        console.log("a user disconnected!");
    });
});

httpServer.listen(port, () => console.log("hello from server port 3000"));
