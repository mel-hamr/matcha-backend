class userSignInDTO {
  constructor(body) {
    this.email_address = body.email;
    this.last_name = body.last_name;
    this.first_name = body.first_name;
    this.username = body.username;
    this.password = body.password;
    this.longitude = body.longitude;
    this.latitude = body.latitude;
    this.fame_rating = [];
    this.verified = false;
    this.profile_completion_status = false;
  }

  checkAllFields() {
    if(this.email_address)
      this.email_address = this.email_address.toLowerCase();
    if (
      !this.email_address ||
      !this.last_name ||
      !this.first_name ||
      !this.username ||
      !this.password 
    )
      return { status: false, message: "missing fields" };
    else if (
      this.email_address == "" ||
      this.last_name == "" ||
      this.first_name == "" ||
      this.username == "" ||
      this.password == ""
    )
      return { status: false, message: "empty field(s)" };
    else if (
      /^[A-Za-z '-]+$/.test(this.last_name) == false ||
      /^[A-Za-z '-]+$/.test(this.first_name) == false
    )
      return { status: false, message: "first_name or last_name uncorrect" };
    else if (/^(?=.{8,20}$)[a-zA-Z0-9._\-@]+$/g.test(this.username) == false)
      return { status: false, message: "username uncorrect" };
    else if (
      /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&-])[A-Za-z\d@$!%*?\-&]{8,20}$/gi.test(
        this.password
      ) == false
    )
      return {
        status: false,
        message:
          "Password uncorrect : Must contain at least 8 and less than 20 characters 1 upper-case 1 number 1 special char '@$!%*?&-'",
      };
    else if (
      /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/i.test(
        this.email_address
      ) == false
    )
      return { status: false, message: "email adresse uncorrect" };
    return { status: true };
  }
}

module.exports = userSignInDTO;
