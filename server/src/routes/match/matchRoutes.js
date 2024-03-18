const express = require("express");
const generalCrude = require("../../data/db/crud");
const router = express.Router();
const matchsService = require("../../services/matchs/matchs-service");

router.get("/getMatch", async (req, res) => {});

router.post("/sendRequest", async (req, res) => {
  let result = await matchsService.sendMatchRequest(
    req.session.user_id,
    req.body.reciverId
  );

  res.status(200).send({ message: result });
});

router.post("/getMatchStatus", async (req, res) => {
  let result = await matchsService.getMatchStatus(
    req.session.user_id,
    req.body.reciverId
  );
  res.status(200).send({ message: result });
});

router.post("/cancelMatch", async (req, res) => {
  let result = await matchsService.cancelMatch(
    req.session.user_id,
    req.body.reciverId
  );
  res.status(200).send({ message: result });
})

module.exports = router;
