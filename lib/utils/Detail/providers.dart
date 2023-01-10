import 'package:first_app/repository/localDB/recetteDAO.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/recette.dart';

/*class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({Key? key, required this.isFavorited, required this.favoriteCount}) : super(key: key);
   final bool isFavorited ;
   final int favoriteCount;
  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState(favoriteCount, this.isFavorited);
}

class _FavoriteWidgetState extends State<FavoriteWidget> {

  bool _isFavorited = false;
  int _favoriteCount = 0;
  _FavoriteWidgetState(this._favoriteCount, this._isFavorited);

   void _toggleFavorite(){
     setState(() {
       if(_isFavorited){
         _isFavorited = false;
         _favoriteCount--;
       }else{
         _isFavorited = true;
         _favoriteCount++;
       }
     });
   }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(icon: Icon( _isFavorited ? Icons.favorite : Icons.favorite_outline_outlined, size: 20,),
          onPressed: _toggleFavorite,),
        Text('$_favoriteCount')
      ],
    );
  }
}*/


class FavoriteChangeNotifier with ChangeNotifier{
 recette r;

  FavoriteChangeNotifier(this.r);

  bool get isFavorited => r.IsFavorite;

  int get favoriteCount => r.favoriteCount + (r.IsFavorite ? 1 : 0);

  set isFavorited(bool isFavorited){
    r.IsFavorite = isFavorited;
    RecetteDatabase.instance.updateRecette(r);
    notifyListeners();
  }
}


class FavoriteIconWidget extends StatefulWidget {
  const FavoriteIconWidget({Key? key}) : super(key: key);

  @override
  State<FavoriteIconWidget> createState() => _FavoriteIconWidgetState();
}

class _FavoriteIconWidgetState extends State<FavoriteIconWidget> {
  late bool _isFavorited;

  void _toggleFavorite(FavoriteChangeNotifier _notifier){
    setState(() {
      if(_isFavorited){
        _isFavorited = false;
      }else{
        _isFavorited = true;
      }
      _notifier.isFavorited = _isFavorited;
    });
  }
  @override
  Widget build(BuildContext context) {
    FavoriteChangeNotifier _notifier = Provider.of<FavoriteChangeNotifier>(context);
    _isFavorited = _notifier.isFavorited;
    return  IconButton(icon: Icon( _isFavorited ? Icons.favorite : Icons.favorite_outline_outlined, size: 20,),
          onPressed:()=> _toggleFavorite(_notifier),
        );
    }
}


class FavoriteTextWidget extends StatefulWidget {
  const FavoriteTextWidget({Key? key}) : super(key: key);
  @override
  State<FavoriteTextWidget> createState() => _FavoriteTextWidgetState();
}

class _FavoriteTextWidgetState extends State<FavoriteTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteChangeNotifier>(
      builder: (context,  notifier, _)=> Text(notifier.favoriteCount.toString()),
    );
  }
}
