const express = require("express");
const generalCrude = require("../../data/db/crud");
const router = express.Router();

router.get("/getMatch", async (req, res) => {});

router.post("/sendRequest", async (req, res) => {
    console.log("send Request called : ",req.user)
    console.log 
    res.status(200).send({message : "match request sent"});
});

module.exports = router;