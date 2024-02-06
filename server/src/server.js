const express = require("express");
const crud = require("./data/db/crud");
const dataBase = require("./data/db/createDB");
const userRouter = require("./routes/user/route");
const chatRouter = require("./routes/chat/chat");
const chatService = require("./services/chat/chat.service");
const notificationRouter = require("./routes/notification/notification.router");
const authservice = require("./services/auth/jwt.utils");
const deserializeUser = require("./middlewares/auth/deserializeUser")
var cookieParser = require("cookie-parser");
var bodyParser = require("body-parser");
var cors = require("cors");

const app = express();
const port = 3000;
// cookie parser
app.use(cookieParser());

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.json())
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
app.use(deserializeUser);

const httpServer = require("http").createServer(app);

const io = require("socket.io")(httpServer, {
    cors: { origin: "http://localhost:4200", credentials: true },
});

// body parser
app.use("/user", userRouter);
app.get("/", (req, res) => {
    console.log("-----------------------");
    console.log(req.cookies);
    res.status(200).send({ name: "hello world" });
  });
  

app.use("/chat", chatRouter);
app.use("/notification", notificationRouter);
app.post("/add", crud.createRecord);
app.post("/update", crud.updateRecord);
app.get("/start/intiate", async (req, res) => {
    await dataBase.createDatabase();
    await dataBase.createTables();
    res.status(200).send("data base created succsesfully");
});

io.on("connection", (socket) => {
    let err;

    socket.join(socket.handshake.query.roomID.toString());

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
    socket.on("disconnect", () => {
        console.log("a user disconnected!");
    });
});

app.use((err, req, res, next) => {
    console.log("=============> error handler <=============");
    res.status(500).send(err.message);
  });
  
httpServer.listen(port, () => console.log("hello from server port 3000"));
