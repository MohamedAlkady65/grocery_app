class CategoryModel {
  final String id;
  final String title;
  final String imgUrl;

  CategoryModel(
      {this.id = "",
      required this.title,
      required this.imgUrl,
     });

  factory CategoryModel.fromJson(
      {required Map<String, dynamic> data, required String uid}) {
    return CategoryModel(
        id: uid,
        title: data['title'],
        imgUrl: data['imgUrl'],
       );
  }

  toJson() {
    return {'title': title, 'imgUrl': imgUrl, };
  }

  @override
  String toString() {
    return " id => $id title => $title ,  imgUrl => $imgUrl  ";
  }
}
