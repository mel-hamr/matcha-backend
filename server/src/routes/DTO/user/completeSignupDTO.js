let tags = [
  "Sports",
  "Movies",
  "Books",
  "Music",
  "Travel",
  "Fitness",
  "Food",
  "Technology",
  "Gaming",
  "Art",
  "Fashion",
  "Pets",
  "Outdoor Activities",
  "Cooking",
  "Photography",
  "DIY",
  "Wine",
  "Coffee",
  "Board Games",
  "Hiking",
];

class CompleteSignupDTO {
  gender;
  sexual_preference;
  biography;
  photos;
  tags;
  birthdate;
  images = [];
  constructor(data, photos) {
    this.gender = data.gender;
    this.sexual_preference = data.sexualPreference;
    this.biography = data.biography;
    this.birthdate = data.birthdate;
    this.photos = photos;
    this.tags = data.tags;
  }

  ///// validate and verify all fields
  checkAllFields() {
    let valid = true;
    let errorMessages = "Invalid fields";
    ///// check if all fields are present
    if (
      this.gender == undefined ||
      this.sexual_preference == undefined ||
      this.biography == undefined ||
      this.birthdate == undefined ||
      this.photos == undefined
    )
      return { status: false, message: "Missing fields" };

    ///// check if gender and sexualPreference are valid
    if (
      (this.gender != "male" && this.gender != "female") ||
      (this.sexual_preference != "male" && this.sexual_preference != "female")
    ) {
      console.log("gender or sexualPreference invalid");
      this.errorMessages = "gender or sexualPreference invalid";
      valid = false;
    }

    ///// check if biography is valid
    if (
      this.biography.length > 255 ||
      /^[A-Za-z '-:;]+$/.test(this.biography) == false
    ) {
      valid = false;
      this.errorMessages = "biographt invalid";
      console.log("biographt invalid");
    }
    ///// check if birthdate is valid

    if (
      /^\d{4}\-(0[1-9]|1[012])\-(0[1-9]|[12][0-9]|3[01])$/.test(
        this.birthdate
      ) == false
    ) {
      valid = false;
      console.log("birthday invalid");
      this.errorMessages = "birthday invalid";
    }
    ///// check if tags are valid
    if (this.tags.length < 1 || this.tags.length < 4) {
      valid = false;
      console.log("tags number invalid");
      this.errorMessages = "tags number invalid";
    }
    for (let tag of this.tags) {
      if (tags.includes(tag) == false) {
        valid = false;
        console.log("tag does not exist invalid");
        this.errorMessages = "tag does not exist invalid";
      }
    }

    ///// check if photos are valid
    if (Array.isArray(this.photos) == false) valid = false;
    for (let photo of this.photos) {
      if (Object.keys(photo).length != 6) {
        valid = false;
        console.log("photo invalid");
        this.errorMessages = "photo invalid";
        break;
      }
      if (photo.size > 2000000) {
        console.log("photo invalid");
        this.errorMessage = "photo size invalid , too large";
        valid = false;
        break;
      }
      if (
        photo.mimetype != "image/jpeg" &&
        photo.mimetype != "image/png" &&
        photo.mimetype != "image/jpg"
      ) {
        console.log("photo invalid");
        this.errorMessage = "photo type invalid";
        valid = false;
        break;
      }
      if (photo.originalname == "") {
        console.log("photo invalid");
        this.errorMessage = "photo name invalid";
        valid = false;
        break;
      }
    }

    if (this.photos.length < 1 || this.photos.length > 5) {
      valid = false;
      this.errorMessage = "photo number invalid";
      console.log("photo invalid");
    }

    if (valid) return { status: true, message: "All fields are valid" };
    else return { status: false, message: this.errorMessage };
  }
}
module.exports = CompleteSignupDTO;
