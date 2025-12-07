import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/core/app_theme.dart';
import 'package:my_portfolio/logic/theme_cubit.dart';
import 'package:my_portfolio/logic/portfolio_bloc.dart';
import 'package:my_portfolio/presentation/main_screen.dart';
import 'package:my_portfolio/presentation/widgets/custom_cursor.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:my_portfolio/presentation/screens/splash_screen.dart';

void main() {
  runApp(const MyPortfolioApp());
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => PortfolioBloc()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Arjun Jai Portfolio',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.themeMode,
            builder: (context, child) => CustomCursor(
              child: ResponsiveBreakpoints.builder(
                child: child!,
                breakpoints: [
                  const Breakpoint(start: 0, end: 450, name: 'MOBILE'),
                  const Breakpoint(start: 451, end: 800, name: 'TABLET'),
                  const Breakpoint(start: 801, end: 1920, name: 'DESKTOP'),
                  const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
                ],
              ),
            ),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
