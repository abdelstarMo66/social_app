abstract class AppStates {}

class InitialState extends AppStates {}

class ChangeBottomNavBarState extends AppStates{}

class numMyPostsState extends AppStates{}

class GetUserLoadingState extends AppStates {}

class GetUserSuccessState extends AppStates {}

class GetUserErrorState extends AppStates {
  final String error;

  GetUserErrorState(this.error);
}

class GetAllUserLoadingState extends AppStates {}

class GetAllUserSuccessState extends AppStates {}

class GetAllUserErrorState extends AppStates {
  final String error;

  GetAllUserErrorState(this.error);
}

class GetPostsLoadingState extends AppStates {}

class GetPostsSuccessState extends AppStates {}

class GetPostsErrorState extends AppStates {
  final String error;

  GetPostsErrorState(this.error);
}

class ProfileImageSuccessState extends AppStates{}

class ProfileImageErrorState extends AppStates{}

class CoverImageSuccessState extends AppStates{}

class CoverImageErrorState extends AppStates{}

class UpdateProfileImageSuccessState extends AppStates{}

class UpdateProfileImageErrorState extends AppStates{}

class UpdateCoverImageSuccessState extends AppStates{}

class UpdateCoverImageErrorState extends AppStates{}

class UpdateUserDataLoadingState extends AppStates{}

class UpdateUserDataErrorState extends AppStates{}

//posts
class AddPostSuccessState extends AppStates{}

class AddPostLoadingState extends AppStates{}

class AddPostErrorState extends AppStates{}

class DeletePostSuccessState extends AppStates{}

class DeletePostErrorState extends AppStates{}

class UpdatePostImageSuccessState extends AppStates{}

class UpdatePostImageErrorState extends AppStates{}

class PostImageSuccessState extends AppStates{}

class PostImageErrorState extends AppStates{}

class removePostImageState extends AppStates{}

class SendMessageSuccessState extends AppStates{}

class SendMessageErrorState extends AppStates{}

class GetMessageSuccessState extends AppStates{}

class ChatImageSuccessState extends AppStates{}

class ChatImageErrorState extends AppStates{}

class removeChatImageState extends AppStates{}
