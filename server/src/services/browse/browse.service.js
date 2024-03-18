const browseRepository = require("../../data/browse/browse.repository");

const getSuggestionList = async (userId) => {
    const suggestionList = await browseRepository.getSuggestionList(userId);
    return suggestionList;
};

module.exports = {
    getSuggestionList,
};
