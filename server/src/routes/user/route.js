const express = require("express");
const generalCrude = require("../../data/db/crud");
const router = express.Router();
const userSerivce = require("../../services/user/user-service");
const path = require("path");
const userSignInDTO = require("../DTO/user/userSignInDTO");

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
0;
router.get("/verified", (req, res) => {
  res.sendFile(path.join(__dirname + "../../../common/views/verified.html"));
});

router.post("/login", (req, res) => {});

module.exports = router;
