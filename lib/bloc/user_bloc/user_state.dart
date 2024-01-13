part of 'user_bloc.dart';

@immutable
abstract class UserState {
  UserModel user;
  UserState({this.user = UserModel.emptyUserData});
}

class UserInitial extends UserState {}

class UserLoadedState extends UserState {
  UserModel user;
  UserLoadedState({required this.user});
}

class UserLoadingState extends UserState {}

class ErrorState extends UserState {
  String error;
  ErrorState({required this.error});
}

class DataAddedState extends UserState {
  TaskModel taskModel;
  DataAddedState({required this.taskModel});
}

class TaskFetchState extends UserState {
  List<TaskModel> taskModel;
  TaskFetchState({required this.taskModel});
}

class DataUpdateState extends UserState {
  TaskModel taskModel;
  DataUpdateState({required this.taskModel});
}

class DataDeletedState extends UserState{}
class TaskCompletionUpdatedState extends UserState{}
