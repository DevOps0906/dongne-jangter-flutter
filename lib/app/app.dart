import 'package:flutter/material.dart';

import 'router.dart';
import 'theme.dart';

class DongneJangterApp extends StatelessWidget {
  const DongneJangterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '동네장터',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      routerConfig: appRouter,
    );
  }
}
