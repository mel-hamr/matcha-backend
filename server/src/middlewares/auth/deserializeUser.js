const { verifyJWT, signJWT } = require("../../services/auth/jwt.utils");
const generalCrude = require("../../data/db/crud");
const e = require("express");

async function deserializeUser(req, res, next) {
  const { accessToken, refreshToken } = req.cookies;

  if (!accessToken && !refreshToken) {
    return res.status(401).send("unauthorized");
  }
  else {

    if (accessToken) {
      const { payload, expired } = verifyJWT(accessToken);
      if (expired == false && payload) 
      {
        req.session = payload;
        return next();
      }
    }
    
    if (!accessToken || (expired == true && refreshToken)) {
      const decodedRefreshToken = verifyJWT(refreshToken);
      if (decodedRefreshToken.expired == true) {
        return res.status(401).send("unauthorized");
      }
      const session = await generalCrude.getRecordById(
        "sessions",
        decodedRefreshToken.payload.session_id
        );
        if (!session || !session.valid) {
          return res.status(401).send("unauthorized");
        }
        const newAccessToken = signJWT(session, "5m");
        res.cookie("accessToken", newAccessToken, {
          maxAge: 300000,
          httpOnly: true,
        });
        req.session = verifyJWT(newAccessToken).payload;
      }

      return next();
    }
      
      // if (!accessToken) {
  //   if (refreshToken) {
  //     const decodedRefreshToken = verifyJWT(refreshToken);
  //     console.log("decodedRefreshToken", decodedRefreshToken);

  //     if (decodedRefreshToken.expired == true) {
  //       return res.status(401).send("unauthorized");
  //     }
  //     const session = await generalCrude.getRecordById(
  //       "sessions",
  //       decodedRefreshToken.payload.session_id
  //     );
  //     console.log("session", session);
  //     if (!session || !session.valid) {
  //       return res.status(401).send("unauthorized");
  //     }
  //     const newAccessToken = signJWT(session, "5m");
  //     res.cookie("accessToken", newAccessToken, {
  //       maxAge: 300000,
  //       httpOnly: true,
  //     });
  //     // @ts-ignore
  //     req.user = verifyJWT(newAccessToken).payload;
  //   }
  //   return res.status(401).send("unauthorized");
  // }

  // const { payload, expired } = verifyJWT(accessToken);

  // // For a valid access token
  // if (payload) {
  //   // @ts-ignore
  //   req.user = payload;
  //   return next();
  // }

  // expired but valid access token
  // const { payload: refresh } =
  //   expired && refreshToken ? verifyJWT(refreshToken) : { payload: null };

  // if (!refresh) {
  //   return next();
  // }

  // // @ts-ignore
  // //   const session = getSession(refresh.sessionId);
  // const session = await generalCrude.getRecordById(
  //   "sessions",
  //   refresh.sessionId
  // );
  // console.log(session);
  // if (!session) {
  //   return next();
  // }

  // const newAccessToken = signJWT(session, "5m");

  // res.cookie("accessToken", newAccessToken, {
  //   maxAge: 300000, // 5 minutes
  //   httpOnly: true,
  // });

  // // @ts-ignore
  // req.user = verifyJWT(newAccessToken).payload;

  // return next();
}

// array of paths that do not require deserialization
const PATHS = ["/user/login", "/user/signup", "/start/intiate"];

var deserializerFilter = function (middleware) {
  return function (req, res, next) {
    if (PATHS.includes(req.path)) {
      return next();
    } else if (req.path.includes("/user/verify-email")) {
      return next();
    } else if (req.path.includes("/user/verified")) {
      return next();
    } else {
      return middleware(req, res, next);
    }
  };
};
module.exports = { deserializeUser, deserializerFilter };
