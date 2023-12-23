const express = require("express");
const generalCrude = require("../../data/db/crud");
const router = express.Router();
const userSerivce = require("../../services/user/user-service");
const path = require("path");
const userSignInDTO = require("../DTO/user/userSignInDTO");

router.post("/login", async (req, res) => {
    let { username, password } = req.body;
    if (username && password) userSerivce.userLogin(username, password, res);
    else res.status(400).send("Please enter username and password");
});

router.post("/signup", async (req, res) => {
    userDTO = new userSignInDTO(req.body);
    let { status, message } = userDTO.checkAllFields(res);
    console.log(userDTO);
    if (status) {
        await userSerivce.userSignIn(userDTO, res);
    } else res.status(400).send(message);
});

router.get("/getUser", async (req, res) => {
    res.send(await generalCrude.getRecordById("users", req.body.id));
});

router.get("/verify-email/:id/:uniqueString", async (req, res) => {
    const id = req.params.id;
    const uniqueString = req.params.uniqueString;
    await userSerivce.verifyUserEmail(id, uniqueString, res);
});

router.get("/verified", (req, res) => {
    res.sendFile(path.join(__dirname + "../../../common/views/verified.html"));
});

router.post("/getVerification", async (req, res) => {
    console.log(
        "getVerification called ",
        await generalCrude.getRecordById("users", req.body.id).verified
    );
    res.status(200).send({
        verified: (await generalCrude.getRecordById("users", req.body.id))
            .verified,
    });
});

module.exports = router;
