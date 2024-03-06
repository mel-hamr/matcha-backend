const express = require("express");
const generalCrude = require("../../data/db/crud");
const router = express.Router();
const userSerivce = require("../../services/user/user-service");
const path = require("path");
const userSignInDTO = require("../DTO/user/userSignInDTO");
const CompleteSignupDTO = require("../DTO/user/completeSignupDTO");
// const requireUser = require("../../middlewares/auth/requireUser");

///// multer
const multer = require("multer");
const storage = multer.memoryStorage();
const upload = multer({ storage: storage });

////// imagekit
console.log("image kit url", process.env.IMAGE_KIT_URL);
console.log("image kit public key", process.env.IMAGE_KIT_PUBLIC_KEY);
console.log("image kit private key", process.env.IMAGE_KIT_PRIVATE_KEY);
var ImageKit = require("imagekit");

var imagekit = new ImageKit({
  publicKey: process.env.IMAGE_KIT_PUBLIC_KEY,

  privateKey: process.env.IMAGE_KIT_PRIVATE_KEY,

  urlEndpoint: process.env.IMAGE_KIT_URL,
});
/////// routes

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
    verified: (await generalCrude.getRecordById("users", req.body.id)).verified,
  });
});

router.post("/test", upload.array("photos", 5), async (req, res) => {
  try {
    req.body.tags = JSON.parse(req.body.tags);
  } catch (err) {
    res.status(400).send("invalid tags format");
    return;
  }
  let completeSingupDTO = new CompleteSignupDTO(req.body, req.files);
  // console.log(completeSingupDTO);
  let { status, message } = completeSingupDTO.checkAllFields();
  if (status == false) {
    res.status(400).send(message);
    return;
  }
  for (let photo of completeSingupDTO.photos) {
    var uploadResponse = await imagekit
      .upload({
        file: photo.buffer, // It accepts remote URL, base_64 string or file buffer
        fileName: Date.now() + photo.originalname, // required
        isPrivateFile: false,
      })
      .catch((err) => {
        console.log(err);
      });
    completeSingupDTO.images.push(uploadResponse.url);
  }
  userSerivce.completeSignup(req, res, completeSingupDTO);
});

router.post("/completeSignupStatus", async (req, res) => {
  let user = await generalCrude.getRecordBy(
    "users",
    "username",
    req.user.username
  );
  if (!user) {
    res.status(400).send("user not found");
    return;
  }
  res.status(200).send({ signCompleteStatus: user.profile_completion_status });
});

router.get("/checkSession", async (req, res) => {
  // console.log("check session called");
  userSerivce.checkSession(req, res);
});

router.get("/", (req, res) => {
  userSerivce.getUserByUsername(res, req.query.username);
});

module.exports = router;
