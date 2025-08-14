import 'package:flutter/material.dart';
import 'package:flutter_application_2/custom_drawer.dart';
import 'package:flutter_application_2/my_theme_model.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<MyThemeModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [Text('Eu Amo Séries 🎬')],
        ),
        actions: [
          IconButton(
            icon: Icon(themeModel.isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => themeModel.swicthTheme(),
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: child,
    );
  }
}
