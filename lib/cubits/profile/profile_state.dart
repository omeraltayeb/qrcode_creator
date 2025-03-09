abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {}

class ProfileFailure extends ProfileState {
  final String message;
  ProfileFailure(this.message);
}
