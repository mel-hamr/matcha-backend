const express = require("express");
const crud = require("./src/data/db/crud")
const dataBase = require("./src/data/db/createDB")
const userRouter =require('./src/routes/user/route')
var bodyParser = require('body-parser');

const app = express();
const port = 3000;

// body parser
app.use(bodyParser.json())

app.use('/user' , userRouter)
app.get("/", (req, res) => {
  res.send("hello world");
  console.log("hello world");
});

app.post("/add", crud.createRecord);
app.post("/update", crud.updateRecord);

class tickersDTO {
  platform
  ticker
  baseAsset
  quoteAsset
}
app.get("/start/intiate", async (req, res) => {
    // await dataBase.createDatabase()
    await dataBase.createTables()
  res.status(200).send("data base created succsesfully")
});  

app.listen(port, () => console.log("hello from server port 3000"));

// how to get body form request in express ?



