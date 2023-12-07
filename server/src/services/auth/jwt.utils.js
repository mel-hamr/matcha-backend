const jwt = require("jsonwebtoken");
require("dotenv").config();

const privateKey = process.env.JWT_SECRET;

const publicKey = process.env.JWT_PUBLIC_KEY;

const signJWT = (payload, expiresIn) => {
  const token = jwt.sign(payload, privateKey, {
    algorithm: "RS256",
    expiresIn: expiresIn,
  });
  return token;
};

const verifyJWT = (token) => {
  try {
    const decoded = jwt.verify(token, publicKey);
    return { payload: decoded, expired: false };
  } catch (err) {
    console.log(err);
    return { payload: null, expired: err.message.includes("jwt expired") };
  }
};

const decodeJWT = (token) => {
    const decoded = jwt.decode(token, { complete: true });
    if(decoded.payload.iat < decoded.payload.exp) return { payload: null, expired: true };
    return { payload: decoded, expired: false };
}
module.exports = {
  signJWT,
  decodeJWT,
};
