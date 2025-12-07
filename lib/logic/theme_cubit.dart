import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(ThemeMode.dark));

  void toggleTheme() {
    emit(ThemeState(state.themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark));
  }
}
