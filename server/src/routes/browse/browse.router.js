const browseRouter = require("express").Router();
const browseService = require("../../services/browse/browse.service");

browseRouter.get("/suggestions", async (req, res) => {
    const userId = req.query.userId;
    return browseService.getSuggestionList(userId);
});


module.exports = browseRouter;