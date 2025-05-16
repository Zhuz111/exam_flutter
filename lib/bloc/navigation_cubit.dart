import 'package:bloc/bloc.dart';

enum NavigationTab { home, tasks, notifications, profile }

class NavigationCubit extends Cubit<NavigationTab> {
  NavigationCubit() : super(NavigationTab.home);

  void selectTab(NavigationTab tab) => emit(tab);
}