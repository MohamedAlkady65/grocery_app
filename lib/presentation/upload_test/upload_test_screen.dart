import 'package:flutter/material.dart';


class UplaodTestScreen extends StatefulWidget {
  const UplaodTestScreen({super.key});
  static const String id = "UplaodTest";

  @override
  State<UplaodTestScreen> createState() => _UplaodTestScreenState();
}

class _UplaodTestScreenState extends State<UplaodTestScreen> {
  String? se = "EG";
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

// onPressed: () async {
//             print("start");
//             await Future.forEach(categoriesDataListUploaded, (element) async {
//               print(element['title']);
//               await Collections.categoriesCollection.add(CategoryModel(
//                   title: element['title'],
//                   imgUrl: element['imgUrl'],
//                   isSvg: true));
//             });
//             print("end");
//           },

//  onPressed: () async {
//           print("start");
//           int co = 1;
//           await Future.forEach(productsUpload, (element) async {
//             print(co);
//             element.title = "Product $co";
//             await Collections.productsCollection.add(element);
//             co++;
//           });
//           print("end");
//         },
