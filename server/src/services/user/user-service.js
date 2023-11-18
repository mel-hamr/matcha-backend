const generalCrude = require("../../data/db/crud");
const auth = require("../auth/jwt.utils");
const userRepo = require("../../data/user/user-repository");
const verifocationEmailHelper = require("./helper/verification-email-helper");
const bcrypt = require("bcrypt");
const axios = require("axios");

const userSignIn = async (userWo, res) => {
  let newUser;
  let user;
  user = await userRepo.getUserByUsernameOrEmail(userWo.username,userWo.email_address);
  if (user) {
    if(user.email_address == userWo.email_address)
      res.status(400).send("email address already used");
    else if(user.username == userWo.username)
        res.status(400).send("username already used");
    return
  }

  if(!userWo.lantiude && !userWo.longitude){
    const firstResponse = await axios.get('https://httpbin.org/ip');
    const publicIpAddress = firstResponse.data.origin;
    const response = await fetch(`http://ip-api.com/json/${publicIpAddress}`);
    data = await response.json();
    userWo.latitude = data.lat;
    userWo.longitude = data.lon;
  }
  newUser = await generalCrude.createRecord(userWo, "users");
  if (newUser) {
    console.log("====================================");
    console.log(newUser);
    
    // let accessToken = auth.signJWT(
    //   {
    //     username: userWo.username,
    //     email_address: userWo.email_address,
    //     user_id: newUser.id,
    //   },
    //   "5m"
    // );
    // let session = await generalCrude.createRecord(
    //   { user_id: newUser.id, username: newUser.username, valid: true },
    //   "sessions",
    //   res
    // );
    // console.log(session);
    // let refreshToken = auth.signJWT({ session_id: session.id }, "1d");

    // // set access token in cookie
    // res.cookie("accessToken", accessToken, {
    //   maxAge: 300000, // 5 minutes
    //   httpOnly: true,
    // });
    // // set refresh token in cookie
    // res.cookie("refreshToken", refreshToken, {
    //   maxAge: 60 * 60 * 24 * 1000, // 1 year
    //   httpOnly: true,
    // });
    verifocationEmailHelper.sendVerificationEmail(newUser, res);  
    res.status(200).send({ message: "user created successfully"});
    // res.redirect('http://localhost:4200')
  } else {
    res.status(400).send("error happend while creating user");
    return
  }
};

const verifyUserEmail = async (userId, uniqueString, res) => {
  let user_verification = await generalCrude.getRecordBy(
    "user_verification",
    "user_id",
    userId,
  );
  // check if user verification record exists
  if (user_verification) {
    //check if user verification record is expiret
    if (user_verification.expires_at < new Date()) {
      generalCrude.deleteRecord("user_verification", user_verification.id);
      generalCrude.deleteRecord("users", userId);
      let message = "Verification link has expired. Please sign up again.";
      res.redirect(`/user/verified/?error=true&message=${message}`);
    }
    // if user verification record is not expired
    else {
      bcrypt
        .compare(uniqueString, user_verification.unique_string)
        .then((result) => {
          if (result) {
            generalCrude.updateRecord(
              "users",
              userId,
              {
                verified: true,
              }
            );
            generalCrude.deleteRecord(
              "user_verification",
              user_verification.id
            );
            res.redirect(`/user/verified/`);
          } else {
            let message =
              " invalid verification details passed. Check your inbox";
            res.redirect(`/user/verified/?error=true&message=${message}`);
          }
        })
        .catch((error) => {
          let message = "An error occured while comapring unique string";
          res.redirect(`/user/verified/?error=true&message=${message}`);
        });
    }
  } else {
    let message =
      "Account record doesn't exist or has been verified already. Plaese sign up or login.";
    res.redirect(`/user/verified/?error=true&message=${message}`);
  }
};

module.exports = { userSignIn, verifyUserEmail };
