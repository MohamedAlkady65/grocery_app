class LandingItemModel {
  final String imgUrl;
  final String text;

  LandingItemModel(
      {required this.imgUrl, required this.text});

  factory LandingItemModel.formJson(Map<String, dynamic> data) {
    return LandingItemModel(
        imgUrl: data['imgUrl'], text: data['text']);
  }

  Map<String, dynamic> toJson() {
    return {'imgUrl': imgUrl, 'text': text};
  }
}
