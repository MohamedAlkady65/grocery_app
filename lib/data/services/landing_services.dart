import 'package:grocery_app/constants/enums.dart';
import 'package:grocery_app/data/models/landing_item_model.dart';
import 'package:grocery_app/helper/collections.dart';

class LandingServices {
  Future<({List<LandingItemModel> data, DataResponse state})>
      getLanding() async {
    try {
      final snapshot = await Collections.landing.get();
      List<LandingItemModel> data = snapshot.docs.map((e) => e.data()).toList();
      return (state: DataResponse.success, data: data);
    } catch (_) {
      return (state: DataResponse.success, data: <LandingItemModel>[]);
    }
  }
}
