class recette{
  String titre;
  String user;
  String imageUrl;
  String description;
  bool IsFavorite ;
  int favoriteCount;

  recette(this.titre, this.user, this.imageUrl, this.description, this.IsFavorite,this.favoriteCount);

  Map<String , dynamic> toMap(){
    return {
      'titre' : titre,
      'user' : user,
      'imageUrl' : imageUrl,
      'description': description,
      'isFavorite': IsFavorite,
      'favoriteCount': favoriteCount
    };
  }

  factory recette.fromMap(Map<String, dynamic> map)=>recette(
      map['titre'],
      map['user'],
      map['imageUrl'],
      map['description'],
      map['isFavorite']==1,
      map['favoriteCount']);
}