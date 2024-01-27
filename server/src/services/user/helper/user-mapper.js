mapCompleteSingupDTOToUpdateUserDTO = (completeSignupDTO) => {
  let updateUserDTO = {
    gender: completeSignupDTO.gender,
    sexual_preference: completeSignupDTO.sexual_preference,
    biography: completeSignupDTO.biography,
    birthdate: completeSignupDTO.birthdate,
    tags: completeSignupDTO.tags,
    images: completeSignupDTO.images,
    profile_completion_status : true
  };
  return updateUserDTO;
};

module.exports = { mapCompleteSingupDTOToUpdateUserDTO}