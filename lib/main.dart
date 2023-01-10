import 'package:flutter/material.dart';
import 'Screens/Detail.dart';
import 'Screens/Recette.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My First App',
      /*initialRoute: '/',
      onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),*/
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        primarySwatch: Colors.green,
      ),
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home:  MyHomePage(title: 'Pizza App',),
    );
  }
}

/*class RouteGenerator{
  static Route<dynamic> ? generateRoute (RouteSettings settings){
    switch (settings.name){
      case '/':
        return MaterialPageRoute(builder: (context)=>MyHomePage(title: 'My Pizza App'));
        break;
      case '/detail':
        return  PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) =>
            DatailPage(r: settings.arguments),
            transitionsBuilder: (context, animation, secondaryAnimation, child){
              var begin = Offset(0.0, 1.0);
              var end = Offset.zero;
              var curve = Curves.easeInCirc;

              var tween = Tween(begin: begin, end: end).
              chain(CurveTween(curve: curve));
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );});
      default:
        return MaterialPageRoute(builder: (context)=>Scaffold(
          appBar: AppBar(title: Text('Error  404'),centerTitle: true,),
          body: Center(child: Text("Page not found"),),
        ));
    }
  }
}*/

