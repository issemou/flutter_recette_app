import 'dart:math';

import 'package:first_app/models/recette.dart';
import 'package:flutter/material.dart';

import '../../Screens/Recette.dart';
import '../../repository/localDB/recetteDAO.dart';

class RecetteForm extends StatefulWidget {
  const RecetteForm({Key? key}) : super(key: key);

  @override
  State<RecetteForm> createState() => _RecetteFormState();
}

class _RecetteFormState extends State<RecetteForm> {

  static const String IMAGE_URL = "assets/images/menu_background.jpg";
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final userController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Recette Form'),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 16.0, left: 16.0, right: 16.0, bottom: 8.0),
              child: TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Titre',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))
                  )
                ),
                validator: (value) {
                  if(value!.isEmpty){
                    return 'Please entre le titre';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 16.0, left: 16.0, right: 16.0, bottom: 8.0),
              child: TextFormField(
                controller: userController,
                decoration: const InputDecoration(
                    labelText: 'user name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))
                    )
                ),
                validator: (value) {
                  if(value!.isEmpty){
                    return 'Please entre le nom du proprietaire';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 16.0, left: 16.0, right: 16.0, bottom: 8.0),
              child: TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))
                    )
                ),
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: 5,
                validator: (value) {
                  if(value!.isEmpty){
                    return 'Please entre la description';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 8,),
            Center(
              child: ElevatedButton(
                onPressed: () {
                    if(formKey.currentState!.validate()){
                      recette r = recette(
                          titleController.value.text,
                          userController.value.text,
                          IMAGE_URL,
                          descriptionController.value.text,
                          true,
                          new Random().nextInt(100)
                      );
                      RecetteDatabase.instance.insertRecette(r);
                      Navigator.push(context,
                          PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) =>
                            MyHomePage(title: 'Pizza App',),
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
                    }
                },
                child: Text('Save'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
