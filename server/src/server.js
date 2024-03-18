const express = require("express");
const crud = require("./data/db/crud");
const dataBase = require("./data/db/createDB");
const userRouter = require("./routes/user/userRoute");
const matchRouter = require("./routes/match/matchRoutes");
const chatRouter = require("./routes/chat/chat");
const browseRouter = require("./routes/browse/browse.router");
const chatService = require("./services/chat/chat.service");
const notificationService = require("./services/notification/notification.service");

const notificationRouter = require("./routes/notification/notification.router");
// const userMiddleware = require("./middlewares/auth/requireUser");
const deserializer = require("./middlewares/auth/deserializeUser");
var cookieParser = require("cookie-parser");
var bodyParser = require("body-parser");
var cors = require("cors");

const app = express();
const port = 3000;
// cookie parser
app.use(cookieParser());

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static("public"));
app.use(
    cors({
        origin: "http://localhost:4200",
        credentials: true,
    })
);

app.use((req, res, next) => {
    res.header("Access-Control-Allow-Origin", "http://localhost:4200");
    res.header(
        "Access-Control-Allow-Headers",
        "Origin, X-Requested-With, Content-Type, Accept"
    );
    next();
});

app.use(deserializer.deserializerFilter(deserializer.deserializeUser));

const httpServer = require("http").createServer(app);

const io = require("socket.io")(httpServer, {
    cors: { origin: "http://localhost:4200", credentials: true },
});

// body parser
app.use("/user", userRouter);
app.use("/match", matchRouter);
app.get("/", (req, res) => {
    // console.log(req.cookies);
    res.status(200).send({ name: "hello world" });
});

app.use("/chat", chatRouter);
app.use("/notification", notificationRouter);
app.post("/add", crud.createRecord);
app.post("/update", crud.updateRecord);
app.get("/start/intiate", async (req, res) => {
    // await dataBase.createDatabase();
    await dataBase.createTables();
    res.status(200).send("data base created succsesfully");
});

app.use("/browse", browseRouter);
// io.use((socket, next) => {
//     return next(new Error("unauthorized"));
// });
io.on("connection", (socket) => {
    let err;
    // socket id
    socket.join(socket.handshake.query.roomID.toString());

    // connected users
    socket.on("connectedUsersForSpecificUser", (data) => {
        connectedUsers = [];
        userId = data.userId;
        userFriendsIds = data.userFriendsIds;

        userFriendsIds.forEach((id) => {
            // check if user is online
            if (io.sockets.adapter.rooms.get(id.toString()) !== undefined) {
                connectedUsers.push(id);
            }
        });
        socket.emit("connectedUsers", connectedUsers);
    });

    socket.on("sendFriendMessage", (message) => {
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
                message.isMe = false;
                socket
                    .to(message.receiver_id.toString())
                    .emit("newNotification", message);
                socket
                    .to(message.receiver_id.toString())
                    .emit("receiveFriendMessage", message);
            }
            // socket
            //     .to(message.sender_id.toString())
            //     .to(message.receiver_id.toString())
            //     .emit("receiveFriendMessage", message);
        }
    });

    socket.on("userVisited", (data) => {
        // viewProfileFriend { userId: 8, userName: 'Thor' }
        notificationService.addNotification(
            data.userId,
            "visited_profile",
            `${data.userName} visited your profile`
        );
        socket
            .to(data.userId.toString())
            .emit("profileViwed", `${data.userName} visited your profile`);
    });

    socket.on("likeFriendProfile", (data) => {
        socket.to(data.receiver_id.toString()).emit("likeFriend", data);
    });

    socket.on("disconnect", () => {
        console.log("a user disconnected!");
    });
});

app.use((err, req, res, next) => {
    console.log("=============> error handler <=============");
    res.status(500).send(err.message);
});

httpServer.listen(port, () => console.log("hello from server port 3000"));
