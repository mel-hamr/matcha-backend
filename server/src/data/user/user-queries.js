const getByUsernameOrEmail = `SELECT * FROM users WHERE username = $1 OR email_address = $2`;

const getRatingByRaterAndRated = `SELECT * FROM rating WHERE rater_user_id = $1 AND rated_user_id = $2`;

const updateUserRating = `UPDATE rating SET rating = $1 WHERE id = $2 RETURNING *`;

const getUserByUsername = `
    SELECT 
        u.*,
        COALESCE(r.avg_rating, 0) AS rating
    FROM 
        users u
    LEFT JOIN (
        SELECT 
            rated_user_id,
            AVG(rating) AS avg_rating
        FROM 
            rating
        GROUP BY 
            rated_user_id
    ) r ON u.id = r.rated_user_id
    WHERE
        u.username = $1
`;
module.exports = {
  getByUsernameOrEmail,
  getRatingByRaterAndRated,
  updateUserRating,
  getUserByUsername,
};
