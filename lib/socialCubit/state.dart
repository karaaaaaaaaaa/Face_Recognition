abstract class cubitStates {}

class initstate extends cubitStates {}

class GetuserSuccessstate extends cubitStates {}

class Getuserloadingstate extends cubitStates {}

class Getusererrorstate extends cubitStates {
  final String error;

  Getusererrorstate(this.error);
}

class GetPostSuccessstate extends cubitStates {}

class GetPostloadingstate extends cubitStates {}

class GetPosterrorstate extends cubitStates {
  final String error;

  GetPosterrorstate(this.error);
}
class GetAlluserSuccessstate extends cubitStates {}

class GetAlluserloadingstate extends cubitStates {}

class GetAllusererrorstate extends cubitStates {
  final String error;

  GetAllusererrorstate(this.error);
}

class SocialLikePostsSuccessState extends cubitStates {}

class SocialLikePostsErrorState extends cubitStates {
  final String error;

  SocialLikePostsErrorState(this.error);
}

class SocialcommentPostsSuccessState extends cubitStates {}

class SocialcommentPostsErrorState extends cubitStates {
  final String error;

  SocialcommentPostsErrorState(this.error);
}

class bottomnavstate extends cubitStates {}

class bottomnavPOSTstate extends cubitStates {}

class SocialEditUserProfileImageSuccessState extends cubitStates {}

class SocialEditUserProfileImageErrorState extends cubitStates {}

class SocialEditUserCoverImageSuccessState extends cubitStates {}

class SocialEditUserCoverImageErrorState extends cubitStates {}

class SocialuploadUserProfileImageSuccessState extends cubitStates {}

class SocialuploadUserProfileImageErrorState extends cubitStates {}

class SocialuploadUserCoverImageSuccessState extends cubitStates {}

class SocialuploadUserCoverImageErrorState extends cubitStates {}

class SocialUpdateErrorState extends cubitStates {}

class SocialUpdateLoadingState extends cubitStates {}

class SocialCreatepostErrorState extends cubitStates {}

class SocialCreatepostLoadingState extends cubitStates {}

class SocialCreatepostSuccessState extends cubitStates {}

class SocialcreatepostImageSuccessState extends cubitStates {}

class SocialcreatepostImageErrorState extends cubitStates {}

class SocialdeleteepostImageState extends cubitStates {}

class SocialGetCommentPostsLoadingState extends cubitStates {}

class SocialGetCommentPostsSuccessState extends cubitStates {
  final String uid;

  SocialGetCommentPostsSuccessState(this.uid);
}

class SocialGetCommentPostsErrorState extends cubitStates {
  final String error;

  SocialGetCommentPostsErrorState(this.error);
}
class getMessageSuccessState extends cubitStates {}
class SendMessageSuccessState extends cubitStates {}
class SendMessageErrorState extends cubitStates {}

