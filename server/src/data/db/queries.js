const checkDbExist = "SELECT 1 FROM pg_database WHERE datname = 'matcha'";
const createDb = "CREATE DATABASE matcha";
const createTable = ` 
  CREATE TABLE IF NOT EXISTS "users" (
    "id" SERIAL,
    "email_address" VARCHAR(255) NOT NULL,
    "last_name" VARCHAR(255) NOT NULL,
    "first_name" VARCHAR(255) NOT NULL,
    "password" VARCHAR(255) NOT NULL,
    "username" VARCHAR(255) NOT NULL UNIQUE,
    "gender" VARCHAR(255),
    "sexual_preference" VARCHAR(255),
    "biography" VARCHAR(255),
    "images" VARCHAR(255)[],
    "tags" VARCHAR(255)[],
    "fame_rating" INT [],
    "latitude" VARCHAR(255),
    "longitude" VARCHAR(255),
    "city" VARCHAR(255),
    "country" VARCHAR(255),
    "verified" BOOLEAN,
    "profile_completion_status" BOOLEAN,
    "is_online" BOOLEAN,
    "birthdate" DATE ,
    PRIMARY KEY ("id")
  );
  CREATE TABLE IF NOT EXISTS "views" (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id),
    view_id INT REFERENCES users(id),
    UNIQUE (user_id, view_id)
  );
  CREATE TABLE IF NOT EXISTS "matchs" (
    id SERIAL PRIMARY KEY,
    user1_id INT REFERENCES users(id),
    user2_id INT REFERENCES users(id),
    UNIQUE (user1_id, user2_id)
  );
  CREATE TABLE IF NOT EXISTS "match_requests" (
    id SERIAL PRIMARY KEY,
    sender_id INT REFERENCES users(id),
    reciver_id INT REFERENCES users(id),
    UNIQUE (sender_id, reciver_id)
  );
  CREATE TABLE IF NOT EXISTS sessions (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id),
    username VARCHAR(255),
    valid BOOLEAN
  );
  CREATE TABLE IF NOT EXISTS user_verification (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id),
    unique_string VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP + INTERVAL '1 day'
  );
  CREATE TABLE IF NOT EXISTS "conversation" (
    id SERIAL PRIMARY KEY,
    participant_a INT REFERENCES users(id),
    participant_b INT REFERENCES users(id),
    last_message VARCHAR(255),
    unread_messages INT
  );
  CREATE TABLE IF NOT EXISTS message (
    id SERIAL PRIMARY KEY,
    conversation_id INT REFERENCES conversation(id),
    sender varchar(255),
    text varchar(255),
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  );
  CREATE TABLE IF NOT EXISTS "notifacation" (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id),
    type VARCHAR(255),
    text VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_read BOOLEAN DAFAULT FALSE
  );
  CREATE TABLE IF NOT EXISTS "rating" (
    id SERIAL PRIMARY KEY,
    rater_user_id INT REFERENCES users(id),
    rated_user_id INT REFERENCES users(id),
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
`;

module.exports = {
  checkDbExist,
  createDb,
  createTable,
  checkDbExist,
  createDb,
  createTable,
};
