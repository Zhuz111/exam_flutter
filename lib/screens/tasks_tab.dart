// ignore: unused_import
import 'package:exam_project/api/api_services.dart';
import 'package:exam_project/services/api_serveces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/tasks_cubit.dart';
import 'package:dio/dio.dart';

class TasksTab extends StatelessWidget {
  const TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TasksCubit(ApiServices(Dio()) as ApiService)..fetchTasks(),
      child: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) {
          if (state.status == TasksStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == TasksStatus.failure) {
            return Center(child: Text('Ошибка: ${state.error}'));
          } else if (state.status == TasksStatus.success) {
            return AnimatedList(
              initialItemCount: state.tasks.length,
              itemBuilder: (context, index, animation) {
                final task = state.tasks[index];
                return SizeTransition(
                  sizeFactor: animation,
                  child: ListTile(
                    title: Text(task.title),
                    trailing: Icon(
                      task.completed
                          ? Icons.check_circle
                          : Icons.circle_outlined,
                      color: task.completed ? Colors.green : null,
                    ),
                  ),
                );
              },
            );
          }
          return const Center(child: Text('Нет данных'));
        },
      ),
    );
  }
}