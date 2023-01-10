import 'package:first_app/utils/home/for_recetteList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/recette.dart';
import '../repository/localDB/recetteDAO.dart';
import '../utils/formulaire/recette_form.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<recette>> ? recettes;

  @override
  void initState(){
    super.initState();
    recettes =  RecetteDatabase.instance.recettes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: FutureBuilder<List<recette>>(
        future: recettes,
        builder: (BuildContext context, AsyncSnapshot<List<recette>> snapshot){
            if (snapshot.hasData){
              List<recette> ? recettes = snapshot.data;
              return  ListView.builder(
                  itemCount: recettes!.length,
                  itemBuilder: (context, index){
                    final r = recettes[index];
                    return Dismissible(
                      key: Key(r.titre),
                        onDismissed: (direction){
                          setState(() {
                            RecetteDatabase.instance.deleRecette(r.titre);
                            recettes.removeAt(index);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("${r.titre} supprimer avec succes"))
                          );
                        },
                        background: Container(color: Colors.redAccent,),
                        child: RecetteItemWidget(r: recettes[index]));
                  });
            }else{
                return const Center(child: CircularProgressIndicator(semanticsLabel: 'Loading Data',),);
            }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,
              PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) =>
                 const RecetteForm(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child){
                    var begin = const Offset(0.0, 1.0);
                    var end = Offset.zero;
                    var curve = Curves.easeInCirc;

                    var tween = Tween(begin: begin, end: end).
                    chain(CurveTween(curve: curve));
                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );  }));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}