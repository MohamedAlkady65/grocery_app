import 'package:grocery_app/constants/const.dart';
import 'package:grocery_app/data/models/ip_info_model.dart';
import 'package:grocery_app/helper/dio_helper.dart';

class IpServices {
  IpServices() : _dio = DioHelper(baseUrl: kIpGeoLocatioBaseUrl);
  final DioHelper _dio;

  Future<IpInfoModel> setIpInfo() async {
    final response = await _dio.get(url: "?apiKey=$kIpGeoLocatioApiKey");
    return IpInfoModel.fromJson(response.data);
  }
}
