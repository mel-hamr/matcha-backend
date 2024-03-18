const client = require("../db/createDB");
const matchaPool = client.matchaPool;
const browseQuery = require("./browse.query");

const getSuggestionList = async (userId) => {
    const suggestionsList = await matchaPool.query(
        browseQuery.suggestionListQuery
    );
    console.log(suggestionsList.rows);
    return suggestionsList.rows;
};

module.exports = {
    getSuggestionList,
};
