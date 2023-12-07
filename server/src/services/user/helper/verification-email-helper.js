const nodemailer = require("nodemailer");
const { v4: uuidv4 } = require("uuid");
const bcrypt = require("bcrypt");
const generalCrude = require("../../../data/db/crud");

let transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: process.env.AUTH_EMAIL,
    pass: process.env.AUTH_PASSWORD,
  },
});

transporter.verify((error, success) => {
  if (error) {
    console.log(error);
  } else {
    console.log("Server is ready to send Mails");
    console.log(success);
  }
});

const sendVerificationEmail = async ({ id, email_address }, res) => {
  const appUrl = process.env.APP_URL;
  const uniqueString = uuidv4() + id;

  const mailOptions = {
    from: process.env.AUTH_EMAIL,
    to: email_address,
    subject: "Verify your email",
    html: `<h1>Verify your email</h1>
    <p>Click <a href="${appUrl}/user/verify-email/${id}/${uniqueString}">here</a> to verify your email.</p>`,
  };

  bcrypt
    .hash(uniqueString, 10)
    .then((hashedUniqueString) => {
      generalCrude
        .createRecord(
          {
            user_id: id,
            unique_string: hashedUniqueString,
          },
          "user_verification",
        )
        .then((data) => {
          transporter.sendMail(mailOptions, (error, info) => {
            if (error) {
              res.status(400).send("error while sending email");
            } else {
              console.log("Email sent: " + info.response);
            }
          });
        });
    })
    .catch((err) => {
      res.status(400).send("error while hashing unique string");
      console.log(err);
    });
};

module.exports = { sendVerificationEmail };
