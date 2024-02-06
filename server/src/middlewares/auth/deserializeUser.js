const { verifyJWT, signJWT } = require("../../services/auth/jwt.utils");
const generalCrude = require("../../data/db/crud");

async function deserializeUser(req, res, next) {
  const { accessToken, refreshToken } = req.cookies;
  console.log("accessToken", accessToken);
  console.log("refreshToken", refreshToken);
  if (!accessToken) {
    if (refreshToken) {
      const result = verifyJWT(refreshToken);
      console.log("result", result);

      if (result.expired == true) {
        return next();
      }
      const session = await generalCrude.getRecordById(
        "sessions",
        result.payload.session_id
      );
      console.log("session", session);
      if (!session || !session.valid) {
        return next();
      }

      const newAccessToken = signJWT(session, "5m");

      res.cookie("accessToken", newAccessToken, {
        maxAge: 300000, // 5 minutes
        httpOnly: true,
      });

      // @ts-ignore
      req.user = verifyJWT(newAccessToken).payload;
    }
    return next();
  }

  const { payload, expired } = verifyJWT(accessToken);

  // For a valid access token
  if (payload) {
    // @ts-ignore
    req.user = payload;
    return next();
  }

  // expired but valid access token

  const { payload: refresh } =
    expired && refreshToken ? verifyJWT(refreshToken) : { payload: null };

  if (!refresh) {
    return next();
  }

  // @ts-ignore
  //   const session = getSession(refresh.sessionId);
  const session = await generalCrude.getRecordById("sessions", refresh.sessionId);
  console.log(session);
  if (!session) {
    return next();
  }

  const newAccessToken = signJWT(session, "5m");

  res.cookie("accessToken", newAccessToken, {
    maxAge: 300000, // 5 minutes
    httpOnly: true,
  });

  // @ts-ignore
  req.user = verifyJWT(newAccessToken).payload;

  return next();
}

module.exports = deserializeUser;
