import 'package:first_app/models/recette.dart';
import 'package:flutter/material.dart';

import '../../Screens/Detail.dart';

class RecetteItemWidget extends StatelessWidget {
  const RecetteItemWidget({Key? key, required this.r}) : super(key: key);
  final recette r;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15,
      margin: EdgeInsets.all(12),
      child: Row(
        children: [
        Image.asset(r.imageUrl, width: 100,height: 100,fit: BoxFit.cover,),
          Padding(
            padding: EdgeInsets.all(10), 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(bottom: 8),
                  child: Text(r.titre, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(r.user, style: const TextStyle(color: Colors.grey, fontSize: 16),),
                    Padding(
                      padding: EdgeInsets.only(left: 90),
                      child: RaisedButton(
                        elevation: 10,
                        hoverElevation: 30,
                        highlightElevation: 10,
                        color: Colors.green,
                        onPressed: (){
                          Navigator.push(context,
                              PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) =>
                                DatailPage(r:r),
                                transitionsBuilder: (context, animation, secondaryAnimation, child){
                                        var begin = Offset(0.0, 1.0);
                                        var end = Offset.zero;
                                        var curve = Curves.easeInCirc;
                                        
                                        var tween = Tween(begin: begin, end: end).
                                          chain(CurveTween(curve: curve));
                                        return SlideTransition(
                                            position: animation.drive(tween),
                                          child: child,
                                        );  }));
                        /*Navigator.pushNamed(context, '/detail', arguments: r);*/
                          },
                        child: const Text('More', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w100),),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}


