const getByUsernameOrEmail  = `SELECT * FROM users WHERE username = $1 OR email_address = $2`

module.exports = { getByUsernameOrEmail }