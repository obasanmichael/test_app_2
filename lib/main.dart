

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app_2/vesti/screens/passport_upload.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

final GoRouter _router = GoRouter(
  initialLocation: '/passport-upload',
  routes: [
    GoRoute(
      path: '/passport-upload',
      builder: (BuildContext context, GoRouterState state) =>
          const PassportUploadScreen(),
    ),
   
  ],
);


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // final GoRouter _router = GoRouter(routes: [
  //   GoRoute(path: '/', builder: (context, state) => Login()),
  //   GoRoute(path: '/home', builder: (context, state) => HomeScreen())
  // ]);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (_, child) {
          return MaterialApp.router(
            theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)),
            routerConfig: _router,
          );
        });
  }
}
