import 'package:flutter/material.dart';
import '../presentation/screens/add_product.dart';
import '../presentation/screens/home.dart';
import 'constants.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter();

  static Map<String, Widget Function(BuildContext)> routs = {
     Constants.homeRout:(context)=> Home(),
     Constants.addProductRout: (context) =>  AddProductScreen(),
  };

  static GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: Constants.homeRout,
        builder: (BuildContext context, GoRouterState state) {
          return   Home();
        },
      ),
      GoRoute(
        path: Constants.addProductRout,
        builder: (BuildContext context, GoRouterState state) {
          return  AddProductScreen();
        },
      ),

    ],
  );

  static void goTo(context, screen) {
    Navigator.pushNamed(
      context,
      screen,
    );
  }

  static void pop(context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  static void popAll(context) {
    Navigator.of(context).popUntil(ModalRoute.withName(Constants.homeRout));
  }

  static void goToWithReplacement(context, screen) {
    Navigator.pushReplacement(
      context,
      screen,
    );
  }
}
