import 'package:flutter/material.dart';
import 'package:flutter_application_2/base_screen.dart';
import 'package:flutter_application_2/tv_show_form_screen.dart';
import 'package:flutter_application_2/my_theme_model.dart';
import 'package:flutter_application_2/tv_show_model.dart';
import 'package:flutter_application_2/tv_show_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TvShowModel()),
        ChangeNotifierProvider(create: (context) => MyThemeModel()),
      ],
      child: const MainApp(),
    ),
  );
}

final GoRouter _router = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) => BaseScreen(child: child),
      routes: [
        GoRoute(path: '/', builder: (context, state) => const TvShowScreen()),
        GoRoute(
          path: '/add',
          builder: (context, state) => const TvShowFormScreen(),
        ),
        GoRoute(
          path: '/edit/:index',
          builder: (context, state) {
            final index = int.parse(state.pathParameters['index']!);
            final tvShow = context.read<TvShowModel>().tvShows[index];
            return TvShowFormScreen(tvShow: tvShow);
          },
        ),
      ],
    ),
  ],
);

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<MyThemeModel>(context);

    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      theme: themeModel.myTheme.customTheme,
      darkTheme: themeModel.myTheme.customThemeDark,
      themeMode: themeModel.isDark ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
