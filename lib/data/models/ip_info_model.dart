class IpInfoModel {
  IpInfoModel({
    required this.countryCode2,
    required this.countryCode3,
    required this.countryName,
    required this.callingCode,
    required this.countryFlag,
    required this.currency,
    required this.currentTimeUnix,
  });

  late final String countryCode2;
  late final String countryCode3;
  late final String countryName;
  late final String callingCode;
  late final String countryFlag;
  late final Currency currency;
  late final int currentTimeUnix;
  late final Duration offset;

  IpInfoModel.fromJson(Map<String, dynamic> json) {
    countryCode2 = json['country_code2'];
    countryCode3 = json['country_code3'];
    countryName = json['country_name'];
    callingCode = json['calling_code'];
    countryFlag = json['country_flag'];
    currency = Currency.fromJson(json['currency']);
    currentTimeUnix = (json['time_zone']['current_time_unix'] * 1000).floor();

    DateTime utc =
        DateTime.fromMillisecondsSinceEpoch(currentTimeUnix, isUtc: true);

    offset = DateTime.now().toLocal().difference(DateTime(
        utc.year, utc.month, utc.day, utc.hour, utc.minute, utc.second));
  }

  @override
  String toString() {
    return "$countryCode2, $countryCode3, $countryName, $callingCode, ${currency.code}";
  }
}

class Currency {
  Currency({
    required this.code,
    required this.name,
    required this.symbol,
  });
  late final String code;
  late final String name;
  late final String symbol;

  Currency.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    symbol = json['symbol'];
  }
}

class TimeZone {
  TimeZone({
    required this.offset,
    required this.offsetWithDst,
    required this.currentTime,
    required this.currentTimeUnix,
    required this.isDst,
  });
  late final int offset;
  late final int offsetWithDst;
  late final String currentTime;
  late final double currentTimeUnix;
  late final bool isDst;

  TimeZone.fromJson(Map<String, dynamic> json) {
    offset = json['offset'];
    offsetWithDst = json['offset_with_dst'];
    currentTime = json['current_time'];
    currentTimeUnix = json['current_time_unix'];
    isDst = json['is_dst'];
  }
}
