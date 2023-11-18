const express = require("express");
const crud = require("./src/data/db/crud")
const dataBase = require("./src/data/db/createDB")
const userRouter =require('./src/routes/user/route')
var bodyParser = require('body-parser');
const cors = require('cors')
var cookieParser = require('cookie-parser')
const authservice = require('./src/services/auth/jwt.utils')

const app = express();
const port = 3000;
// cookie parser
app.use(cookieParser())
// body parser
app.use(bodyParser.json())
// cors
app.use(cors(
{
  origin: 'http://localhost:4200',
  credentials: true,
}
))
// routes
app.use('/user' , userRouter)

app.get("/", (req, res) => {
  console.log("-----------------------")
  console.log(req.cookies);
  res.status(200).send({name: "hello world"}); 
});


app.post("/", (req, res) => {
  console.log("------------POST/-----------")
  console.log(authservice.decodeJWT(req.body.token))
  res.status(200).send({name: "hello world"}); 
});
app.post("/add", crud.createRecord);
app.post("/update", crud.updateRecord);
app.get("/start/intiate", async (req, res) => {
    await dataBase.createDatabase()
    await dataBase.createTables()
  res.status(200).send("data base created succsesfully")
});  

app.use((err, req, res, next) => {
  console.log("=============> error handler <=============")
  res.status(500).send(err.message)
})
app.listen(port, () => console.log("hello from server port 3000"));

// how to get body form request in express ?



