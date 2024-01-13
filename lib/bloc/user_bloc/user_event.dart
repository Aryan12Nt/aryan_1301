part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class UploadUserDataEvent extends UserEvent {
  UserModel user;
  UploadUserDataEvent({required this.user});
}

class UploadTaskEvent extends UserEvent {
  TaskModel task;
  String docId;
  UploadTaskEvent({required this.task, required this.docId});
}

class FetchTaskEvent extends UserEvent {
  List<Object?> get props => [];
}

class UpdateTaskEvent extends UserEvent {
  TaskModel task;
  String docId;
  UpdateTaskEvent({required this.task, required this.docId});
}

class DeleteTaskEvent extends UserEvent {
  String docId;
  DeleteTaskEvent({required this.docId});
}
 class UpdateTaskCompletionEvent extends UserEvent {
  final String docId;
  final bool isCompleted;

  UpdateTaskCompletionEvent({required this.docId, required this.isCompleted});
}
class FetchProfileEvent extends UserEvent {
  List<Object?> get props => [];
}
