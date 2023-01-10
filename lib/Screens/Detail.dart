
import 'package:first_app/models/recette.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

import '../utils/Detail/providers.dart';

class DatailPage extends StatefulWidget {
  const DatailPage({Key? key, required this.r}) : super(key: key);
  final recette ? r ;

  @override
  State<DatailPage> createState() => _DatailPageState(r!);
}

class _DatailPageState extends State<DatailPage> {

  recette r;
  _DatailPageState(this.r);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavoriteChangeNotifier(r),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detail recette Pizza'),
          centerTitle: true,
        ),
        body: ListView(
            children: [
              _ImageBackground(r.imageUrl),
               TitleSection(r.titre, r.user, r.IsFavorite, r.favoriteCount),
              _SectionComment(),
              _DescriptionSection(r.description)
            ]
        ),
      ),
    );
  }

  Widget TitleSection(String titre, String username, bool isfav, int favcount){
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Row(
          children:[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Text(titre, style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25
                      ),)),
                  Text(username, style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16
                  ),),
                ],
              ),
            ),
            FavoriteIconWidget(),
            FavoriteTextWidget()
          ]
      ),
    );
  }
  Widget _SectionComment(){
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(Colors.grey, Icons.comment, 'Commentaire'),
          _buildButtonColumn(Colors.grey, Icons.share, 'Paratger'),
        ],
      ),
    );
  }
  Column _buildButtonColumn(Color color, IconData icon, String label){
    return Column(
      children: [
        Padding(padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),child: Icon(icon, color: color, size: 30,)),
        Text(label, style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: color
        ),)
      ],
    );
  }
  Widget _DescriptionSection(String desc){
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Center(child: Text(desc,softWrap: true, style: const TextStyle(fontWeight: FontWeight.w100, fontSize: 19), )));
  }
  Widget _ImageBackground(String Url){
    return CachedNetworkImage(
      imageUrl :Url,
      placeholder : (context, url)=>const Center(child: CircularProgressIndicator(),),
      errorWidget:(context, url, error)=>const Icon(Icons.error),
      width: 600,
      height: 240,
      fit: BoxFit.cover,
    );
  }
}