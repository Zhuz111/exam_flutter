import 'package:bloc/bloc.dart';
import 'package:exam_project/api/api_services.dart';
import 'package:flutter/foundation.dart'; // Для @immutable
import '../models/task_model.dart';
import 'package:exam_project/services/api_service.dart';

enum TasksStatus { initial, loading, success, failure }

@immutable
class TasksState {
  final TasksStatus status;
  final List<TaskModel> tasks;
  final String? error;

  const TasksState({
    this.status = TasksStatus.initial,
    this.tasks = const [],
    this.error,
  });

  TasksState copyWith({
    TasksStatus? status,
    List<TaskModel>? tasks,
    String? error,
    bool clearError = false, // если нужно сбрасывать ошибку
  }) {
    return TasksState(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      error: clearError ? null : error ?? this.error,
    );
  }
}

class TasksCubit extends Cubit<TasksState> {
  final ApiService apiService;

  TasksCubit(this.apiService) : super(const TasksState());

  Future<void> fetchTasks() async {
    emit(state.copyWith(status: TasksStatus.loading, clearError: true));
    try {
      final tasks = await apiService.getTasks();
      emit(state.copyWith(status: TasksStatus.success, tasks: tasks));
    } catch (e) {
      emit(state.copyWith(status: TasksStatus.failure, error: e.toString()));
    }
  }
}

class ApiService {
  getTasks() {}
}