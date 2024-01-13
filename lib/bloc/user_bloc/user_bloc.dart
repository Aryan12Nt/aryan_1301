import 'dart:async';

import 'package:aryan_01/models/task_model.dart';
import 'package:aryan_01/models/user_model.dart';
import 'package:aryan_01/repository/user_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserRepo userRepo;
  UserBloc({required this.userRepo}) : super(UserInitial()) {
    on<UploadUserDataEvent>(_onUploadUserData);
    on<UploadTaskEvent>(_onUploadTask);
    on<FetchTaskEvent>(_onFetchTasks);
    on<UpdateTaskEvent>(_updateTask);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<UpdateTaskCompletionEvent>(_mapUpdateTaskCompletionToState);
  }
  Future<void> _onUploadUserData(
    UploadUserDataEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoadingState());

    try {
      await userRepo.uploadUserData(event.user);
      emit(UserLoadedState(user: event.user));
    } catch (e) {
      emit(
        ErrorState(error: 'Error uploading user data: $e'),
      );
    }
  }

  Future<void> _onUploadTask(
    UploadTaskEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoadingState());

    try {
      await userRepo.uploadTask(event.task, event.docId);
      emit(DataAddedState(taskModel: event.task));
      add(FetchTaskEvent());
    } catch (e) {
      emit(
        ErrorState(error: 'Error uploading user data: $e'),
      );
    }
  }

  Future<void> _updateTask(
    UpdateTaskEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoadingState());

    try {
      await userRepo.updateTask(event.task, event.docId);
      emit(DataAddedState(taskModel: event.task));
      add(FetchTaskEvent());
    } catch (e) {
      emit(
        ErrorState(error: 'Error uploading user data: $e'),
      );
    }
  }

  Future<void> _onFetchTasks(
      FetchTaskEvent event, Emitter<UserState> emit) async {
    emit(UserLoadingState());

    try {
      final List<TaskModel> taskList = await userRepo.fetchTaskData();
      emit(TaskFetchState(taskModel: taskList));
    } catch (e) {
      emit(ErrorState(error: 'Error fetching task data: $e'));
    }
  }

  Future<void> _onDeleteTask(
    DeleteTaskEvent event,
    Emitter<UserState> emit,
  ) async {
    try {
      await userRepo.deleteTask(event.docId);
      emit(DataDeletedState());
      add(FetchTaskEvent());
    } catch (e) {
      emit(ErrorState(error: 'Error deleting task: $e'));
    }
  }

  Future<void> _mapUpdateTaskCompletionToState(
    UpdateTaskCompletionEvent event,
    Emitter<UserState> emit,
  ) async {
    try {
      await userRepo.updateTaskCompletion(event.docId, event.isCompleted);
    } catch (e) {
      emit(ErrorState(error: 'Error updating task completion: $e'));
    }
  }
}
