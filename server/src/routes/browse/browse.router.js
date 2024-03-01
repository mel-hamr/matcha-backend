const browseRouter = require("express").Router();
const browseService = require("../../services/browse/browse.service");

browseRouter.get("/suggestions", async (req, res) => {
    const userId = req.query.userId;
    const suggestionList = await browseService.getSuggestionList(userId);
    // console.log(suggestionList);
    res.status(200).send(suggestionList);
});

module.exports = browseRouter;
