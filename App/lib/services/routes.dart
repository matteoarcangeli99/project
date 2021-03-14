import 'package:coex_clover/views/Home.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> routes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Home());
        break;

      default:
        return errorPage();
    }
  }

  static Route<dynamic> errorPage() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              body: Container(
                child: Center(
                    child: Text('Page not found!',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ))),
              ),
            ));
  }
}
