import 'package:collection/collection.dart';

class Counrties {
  static void init() {
    english = List<Map<String, String>>.generate(
        countries.length,
        (index) => {
              "name": countries[index]["nameEn"]!,
              "code": countries[index]["code"]!
            });

    arabic = List<Map<String, String>>.generate(
        countries.length,
        (index) => {
              "name": countries[index]["nameAr"]!,
              "code": countries[index]["code"]!
            }).sorted(
      (a, b) => a["name"]!.compareTo(b["name"]!),
    );
  }

  static late final List<Map<String, String>> english;
  static late final List<Map<String, String>> arabic;

  static const List<Map<String, String>> countries = [
    {
      "nameEn": "Afghanistan",
      "nameAr": "أفغانستان",
      "code": "AF",
      "continent": "Asia"
    },
    {
      "nameEn": "Åland Islands",
      "nameAr": "جزر آلاند",
      "code": "AX",
      "continent": "Europe"
    },
    {
      "nameEn": "Albania",
      "nameAr": "ألبانيا",
      "code": "AL",
      "continent": "Europe"
    },
    {
      "nameEn": "Algeria",
      "nameAr": "الجزائر",
      "code": "DZ",
      "continent": "Africa"
    },
    {
      "nameEn": "American Samoa",
      "nameAr": "ساموا الأمريكية",
      "code": "AS",
      "continent": "Oceania"
    },
    {
      "nameEn": "AndorrA",
      "nameAr": "أندورا",
      "code": "AD",
      "continent": "Europe"
    },
    {
      "nameEn": "Angola",
      "nameAr": "أنغولا",
      "code": "AO",
      "continent": "Africa"
    },
    {
      "nameEn": "Anguilla",
      "nameAr": "أنغويلا",
      "code": "AI",
      "continent": "North America"
    },
    {
      "nameEn": "Antarctica",
      "nameAr": "القطب الجنوبي",
      "code": "AQ",
      "continent": "Antarctica"
    },
    {
      "nameEn": "Antigua and Barbuda",
      "nameAr": "أنتيغوا وبربودا",
      "code": "AG",
      "continent": "North America"
    },
    {
      "nameEn": "Argentina",
      "nameAr": "الأرجنتين",
      "code": "AR",
      "continent": "South America"
    },
    {
      "nameEn": "Armenia",
      "nameAr": "أرمينيا",
      "code": "AM",
      "continent": "Asia"
    },
    {
      "nameEn": "Aruba",
      "nameAr": "أروبا",
      "code": "AW",
      "continent": "North America"
    },
    {
      "nameEn": "Australia",
      "nameAr": "أستراليا",
      "code": "AU",
      "continent": "Oceania"
    },
    {
      "nameEn": "Austria",
      "nameAr": "النمسا",
      "code": "AT",
      "continent": "Europe"
    },
    {
      "nameEn": "Azerbaijan",
      "nameAr": "أذربيجان",
      "code": "AZ",
      "continent": "Asia"
    },
    {
      "nameEn": "Bahamas",
      "nameAr": "الباهاما",
      "code": "BS",
      "continent": "North America"
    },
    {
      "nameEn": "Bahrain",
      "nameAr": "البحرين",
      "code": "BH",
      "continent": "Asia"
    },
    {
      "nameEn": "Bangladesh",
      "nameAr": "بنغلاديش",
      "code": "BD",
      "continent": "Asia"
    },
    {
      "nameEn": "Barbados",
      "nameAr": "بربادوس",
      "code": "BB",
      "continent": "North America"
    },
    {
      "nameEn": "Belarus",
      "nameAr": "بيلاروس",
      "code": "BY",
      "continent": "Europe"
    },
    {
      "nameEn": "Belgium",
      "nameAr": "بلجيكا",
      "code": "BE",
      "continent": "Europe"
    },
    {
      "nameEn": "Belize",
      "nameAr": "بليز",
      "code": "BZ",
      "continent": "North America"
    },
    {"nameEn": "Benin", "nameAr": "بنين", "code": "BJ", "continent": "Africa"},
    {
      "nameEn": "Bermuda",
      "nameAr": "برمودا",
      "code": "BM",
      "continent": "North America"
    },
    {"nameEn": "Bhutan", "nameAr": "بوتان", "code": "BT", "continent": "Asia"},
    {
      "nameEn": "Bolivia",
      "nameAr": "بوليفيا",
      "code": "BO",
      "continent": "South America"
    },
    {
      "nameEn": "Bosnia and Herzegovina",
      "nameAr": "البوسنة والهرسك",
      "code": "BA",
      "continent": "Europe"
    },
    {
      "nameEn": "Botswana",
      "nameAr": "بوتسوانا",
      "code": "BW",
      "continent": "Africa"
    },
    {
      "nameEn": "Bouvet Island",
      "nameAr": "جزيرة بوفيه",
      "code": "BV",
      "continent": "Antarctica"
    },
    {
      "nameEn": "Brazil",
      "nameAr": "البرازيل",
      "code": "BR",
      "continent": "South America"
    },
    {
      "nameEn": "British Indian Ocean Territory",
      "nameAr": "إقليم المحيط الهندي البريطاني",
      "code": "IO",
      "continent": "Asia"
    },
    {
      "nameEn": "Brunei Darussalam",
      "nameAr": "بروناي دار السلام",
      "code": "BN",
      "continent": "Asia"
    },
    {
      "nameEn": "Bulgaria",
      "nameAr": "بلغاريا",
      "code": "BG",
      "continent": "Europe"
    },
    {
      "nameEn": "Burkina Faso",
      "nameAr": "بوركينا فاسو",
      "code": "BF",
      "continent": "Africa"
    },
    {
      "nameEn": "Burundi",
      "nameAr": "بوروندي",
      "code": "BI",
      "continent": "Africa"
    },
    {
      "nameEn": "Cambodia",
      "nameAr": "كمبوديا",
      "code": "KH",
      "continent": "Asia"
    },
    {
      "nameEn": "Cameroon",
      "nameAr": "الكاميرون",
      "code": "CM",
      "continent": "Africa"
    },
    {
      "nameEn": "Canada",
      "nameAr": "كندا",
      "code": "CA",
      "continent": "North America"
    },
    {
      "nameEn": "Cape Verde",
      "nameAr": "الرأس الأخضر",
      "code": "CV",
      "continent": "Africa"
    },
    {
      "nameEn": "Cayman Islands",
      "nameAr": "جزر كايمان",
      "code": "KY",
      "continent": "North America"
    },
    {
      "nameEn": "Central African Republic",
      "nameAr": "جمهورية أفريقيا الوسطى",
      "code": "CF",
      "continent": "Africa"
    },
    {"nameEn": "Chad", "nameAr": "تشاد", "code": "TD", "continent": "Africa"},
    {
      "nameEn": "Chile",
      "nameAr": "شيلي",
      "code": "CL",
      "continent": "South America"
    },
    {"nameEn": "China", "nameAr": "الصين", "code": "CN", "continent": "Asia"},
    {
      "nameEn": "Christmas Island",
      "nameAr": "جزيرة الكريسماس",
      "code": "CX",
      "continent": "Asia"
    },
    {
      "nameEn": "Cocos (Keeling) Islands",
      "nameAr": "جزر كوكوس (كيلينغ)",
      "code": "CC",
      "continent": "Asia"
    },
    {
      "nameEn": "Colombia",
      "nameAr": "كولومبيا",
      "code": "CO",
      "continent": "South America"
    },
    {
      "nameEn": "Comoros",
      "nameAr": "جزر القمر",
      "code": "KM",
      "continent": "Africa"
    },
    {
      "nameEn": "Congo",
      "nameAr": "الكونغو",
      "code": "CG",
      "continent": "Africa"
    },
    {
      "nameEn": "Congo, The Democratic Republic of the",
      "nameAr": "جمهورية الكونغو الديمقراطية",
      "code": "CD",
      "continent": "Africa"
    },
    {
      "nameEn": "Cook Islands",
      "nameAr": "جزر كوك",
      "code": "CK",
      "continent": "Oceania"
    },
    {
      "nameEn": "Costa Rica",
      "nameAr": "كوستاريكا",
      "code": "CR",
      "continent": "North America"
    },
    {
      "nameEn": "Cote D'Ivoire",
      "nameAr": "ساحل العاج",
      "code": "CI",
      "continent": "Africa"
    },
    {
      "nameEn": "Croatia",
      "nameAr": "كرواتيا",
      "code": "HR",
      "continent": "Europe"
    },
    {
      "nameEn": "Cuba",
      "nameAr": "كوبا",
      "code": "CU",
      "continent": "North America"
    },
    {"nameEn": "Cyprus", "nameAr": "قبرص", "code": "CY", "continent": "Europe"},
    {
      "nameEn": "Czech Republic",
      "nameAr": "الجمهورية التشيكية",
      "code": "CZ",
      "continent": "Europe"
    },
    {
      "nameEn": "Denmark",
      "nameAr": "الدانمارك",
      "code": "DK",
      "continent": "Europe"
    },
    {
      "nameEn": "Djibouti",
      "nameAr": "جيبوتي",
      "code": "DJ",
      "continent": "Africa"
    },
    {
      "nameEn": "Dominica",
      "nameAr": "دومينيكا",
      "code": "DM",
      "continent": "North America"
    },
    {
      "nameEn": "Dominican Republic",
      "nameAr": "جمهورية الدومينيكان",
      "code": "DO",
      "continent": "North America"
    },
    {
      "nameEn": "Ecuador",
      "nameAr": "الإكوادور",
      "code": "EC",
      "continent": "South America"
    },
    {"nameEn": "Egypt", "nameAr": "مصر", "code": "EG", "continent": "Africa"},
    {
      "nameEn": "El Salvador",
      "nameAr": "السلفادور",
      "code": "SV",
      "continent": "North America"
    },
    {
      "nameEn": "Equatorial Guinea",
      "nameAr": "غينيا الاستوائية",
      "code": "GQ",
      "continent": "Africa"
    },
    {
      "nameEn": "Eritrea",
      "nameAr": "إريتريا",
      "code": "ER",
      "continent": "Africa"
    },
    {
      "nameEn": "Estonia",
      "nameAr": "إستونيا",
      "code": "EE",
      "continent": "Europe"
    },
    {
      "nameEn": "Ethiopia",
      "nameAr": "إثيوبيا",
      "code": "ET",
      "continent": "Africa"
    },
    {
      "nameEn": "Falkland Islands (Malvinas)",
      "nameAr": "جزر فوكلاند (مالفيناس)",
      "code": "FK",
      "continent": "South America"
    },
    {
      "nameEn": "Faroe Islands",
      "nameAr": "جزر فارو",
      "code": "FO",
      "continent": "Europe"
    },
    {"nameEn": "Fiji", "nameAr": "فيجي", "code": "FJ", "continent": "Oceania"},
    {
      "nameEn": "Finland",
      "nameAr": "فنلندا",
      "code": "FI",
      "continent": "Europe"
    },
    {
      "nameEn": "France",
      "nameAr": "فرنسا",
      "code": "FR",
      "continent": "Europe"
    },
    {
      "nameEn": "French Guiana",
      "nameAr": "غويانا الفرنسية",
      "code": "GF",
      "continent": "South America"
    },
    {
      "nameEn": "French Polynesia",
      "nameAr": "بولينيزيا الفرنسية",
      "code": "PF",
      "continent": "Oceania"
    },
    {
      "nameEn": "French Southern Territories",
      "nameAr": "الأقاليم الجنوبية لفرنسا",
      "code": "TF",
      "continent": "Antarctica"
    },
    {
      "nameEn": "Gabon",
      "nameAr": "الغابون",
      "code": "GA",
      "continent": "Africa"
    },
    {
      "nameEn": "Gambia",
      "nameAr": "غامبيا",
      "code": "GM",
      "continent": "Africa"
    },
    {
      "nameEn": "Georgia",
      "nameAr": "جورجيا",
      "code": "GE",
      "continent": "Asia"
    },
    {
      "nameEn": "Germany",
      "nameAr": "ألمانيا",
      "code": "DE",
      "continent": "Europe"
    },
    {"nameEn": "Ghana", "nameAr": "غانا", "code": "GH", "continent": "Africa"},
    {
      "nameEn": "Gibraltar",
      "nameAr": "جبل طارق",
      "code": "GI",
      "continent": "Europe"
    },
    {
      "nameEn": "Greece",
      "nameAr": "اليونان",
      "code": "GR",
      "continent": "Europe"
    },
    {
      "nameEn": "Greenland",
      "nameAr": "جرينلاند",
      "code": "GL",
      "continent": "North America"
    },
    {
      "nameEn": "Grenada",
      "nameAr": "غرينادا",
      "code": "GD",
      "continent": "North America"
    },
    {
      "nameEn": "Guadeloupe",
      "nameAr": "جوادلوب",
      "code": "GP",
      "continent": "North America"
    },
    {"nameEn": "Guam", "nameAr": "غوام", "code": "GU", "continent": "Oceania"},
    {
      "nameEn": "Guatemala",
      "nameAr": "غواتيمالا",
      "code": "GT",
      "continent": "North America"
    },
    {
      "nameEn": "Guernsey",
      "nameAr": "غيرنسي",
      "code": "GG",
      "continent": "Europe"
    },
    {
      "nameEn": "Guinea",
      "nameAr": "غينيا",
      "code": "GN",
      "continent": "Africa"
    },
    {
      "nameEn": "Guinea-Bissau",
      "nameAr": "غينيا بيساو",
      "code": "GW",
      "continent": "Africa"
    },
    {
      "nameEn": "Guyana",
      "nameAr": "غيانا",
      "code": "GY",
      "continent": "South America"
    },
    {
      "nameEn": "Haiti",
      "nameAr": "هايتي",
      "code": "HT",
      "continent": "North America"
    },
    {
      "nameEn": "Heard Island and Mcdonald Islands",
      "nameAr": "جزيرة هيرد وجزر ماكدونالد",
      "code": "HM",
      "continent": "Antarctica"
    },
    {
      "nameEn": "Holy See (Vatican City State)",
      "nameAr": "الكرسي الرسولي (دولة الفاتيكان)",
      "code": "VA",
      "continent": "Europe"
    },
    {
      "nameEn": "Honduras",
      "nameAr": "هندوراس",
      "code": "HN",
      "continent": "North America"
    },
    {
      "nameEn": "Hong Kong",
      "nameAr": "هونغ كونغ",
      "code": "HK",
      "continent": "Asia"
    },
    {
      "nameEn": "Hungary",
      "nameAr": "هنغاريا",
      "code": "HU",
      "continent": "Europe"
    },
    {
      "nameEn": "Iceland",
      "nameAr": "أيسلندا",
      "code": "IS",
      "continent": "Europe"
    },
    {"nameEn": "India", "nameAr": "الهند", "code": "IN", "continent": "Asia"},
    {
      "nameEn": "Indonesia",
      "nameAr": "إندونيسيا",
      "code": "ID",
      "continent": "Asia"
    },
    {
      "nameEn": "Iran, Islamic Republic Of",
      "nameAr": "جمهورية إيران الإسلامية",
      "code": "IR",
      "continent": "Asia"
    },
    {"nameEn": "Iraq", "nameAr": "العراق", "code": "IQ", "continent": "Asia"},
    {
      "nameEn": "Ireland",
      "nameAr": "أيرلندا",
      "code": "IE",
      "continent": "Europe"
    },
    {
      "nameEn": "Isle of Man",
      "nameAr": "جزيرة مان",
      "code": "IM",
      "continent": "Europe"
    },
    {
      "nameEn": "Italy",
      "nameAr": "إيطاليا",
      "code": "IT",
      "continent": "Europe"
    },
    {
      "nameEn": "Jamaica",
      "nameAr": "جامايكا",
      "code": "JM",
      "continent": "North America"
    },
    {"nameEn": "Japan", "nameAr": "اليابان", "code": "JP", "continent": "Asia"},
    {
      "nameEn": "Jersey",
      "nameAr": "جيرسي",
      "code": "JE",
      "continent": "Europe"
    },
    {"nameEn": "Jordan", "nameAr": "الأردن", "code": "JO", "continent": "Asia"},
    {
      "nameEn": "Kazakhstan",
      "nameAr": "كازاخستان",
      "code": "KZ",
      "continent": "Asia"
    },
    {"nameEn": "Kenya", "nameAr": "كينيا", "code": "KE", "continent": "Africa"},
    {
      "nameEn": "Kiribati",
      "nameAr": "كيريباتي",
      "code": "KI",
      "continent": "Oceania"
    },
    {
      "nameEn": "Korea, Democratic People\"S Republic of",
      "nameAr": "كوريا، جمهورية الشعب الديمقراطية",
      "code": "KP",
      "continent": "Asia"
    },
    {
      "nameEn": "Korea, Republic of",
      "nameAr": "كوريا، جمهورية",
      "code": "KR",
      "continent": "Asia"
    },
    {"nameEn": "Kuwait", "nameAr": "الكويت", "code": "KW", "continent": "Asia"},
    {
      "nameEn": "Kyrgyzstan",
      "nameAr": "قيرغيزستان",
      "code": "KG",
      "continent": "Asia"
    },
    {
      "nameEn": "Lao People\"S Democratic Republic",
      "nameAr": "جمهورية لاو الديمقراطية الشعبية",
      "code": "LA",
      "continent": "Asia"
    },
    {
      "nameEn": "Latvia",
      "nameAr": "لاتفيا",
      "code": "LV",
      "continent": "Europe"
    },
    {"nameEn": "Lebanon", "nameAr": "لبنان", "code": "LB", "continent": "Asia"},
    {
      "nameEn": "Lesotho",
      "nameAr": "ليسوتو",
      "code": "LS",
      "continent": "Africa"
    },
    {
      "nameEn": "Liberia",
      "nameAr": "ليبيريا",
      "code": "LR",
      "continent": "Africa"
    },
    {
      "nameEn": "Libyan Arab Jamahiriya",
      "nameAr": "الجماهيرية العربية الليبية",
      "code": "LY",
      "continent": "Africa"
    },
    {
      "nameEn": "Liechtenstein",
      "nameAr": "ليختنشتاين",
      "code": "LI",
      "continent": "Europe"
    },
    {
      "nameEn": "Lithuania",
      "nameAr": "ليتوانيا",
      "code": "LT",
      "continent": "Europe"
    },
    {
      "nameEn": "Luxembourg",
      "nameAr": "لوكسمبورغ",
      "code": "LU",
      "continent": "Europe"
    },
    {"nameEn": "Macao", "nameAr": "ماكاو", "code": "MO", "continent": "Asia"},
    {
      "nameEn": "Macedonia, The Former Yugoslav Republic of",
      "nameAr": "مقدونيا، جمهورية يوغوسلافيا السابقة",
      "code": "MK",
      "continent": "Europe"
    },
    {
      "nameEn": "Madagascar",
      "nameAr": "مدغشقر",
      "code": "MG",
      "continent": "Africa"
    },
    {
      "nameEn": "Malawi",
      "nameAr": "ملاوي",
      "code": "MW",
      "continent": "Africa"
    },
    {
      "nameEn": "Malaysia",
      "nameAr": "ماليزيا",
      "code": "MY",
      "continent": "Asia"
    },
    {
      "nameEn": "Maldives",
      "nameAr": "المالديف",
      "code": "MV",
      "continent": "Asia"
    },
    {"nameEn": "Mali", "nameAr": "مالي", "code": "ML", "continent": "Africa"},
    {"nameEn": "Malta", "nameAr": "مالطا", "code": "MT", "continent": "Europe"},
    {
      "nameEn": "Marshall Islands",
      "nameAr": "جزر مارشال",
      "code": "MH",
      "continent": "Oceania"
    },
    {
      "nameEn": "Martinique",
      "nameAr": "مارتينيك",
      "code": "MQ",
      "continent": "North America"
    },
    {
      "nameEn": "Mauritania",
      "nameAr": "موريتانيا",
      "code": "MR",
      "continent": "Africa"
    },
    {
      "nameEn": "Mauritius",
      "nameAr": "موريشيوس",
      "code": "MU",
      "continent": "Africa"
    },
    {
      "nameEn": "Mayotte",
      "nameAr": "مايوت",
      "code": "YT",
      "continent": "Africa"
    },
    {
      "nameEn": "Mexico",
      "nameAr": "المكسيك",
      "code": "MX",
      "continent": "North America"
    },
    {
      "nameEn": "Micronesia, Federated States of",
      "nameAr": "ميكرونيزيا، ولايات موحدة",
      "code": "FM",
      "continent": "Oceania"
    },
    {
      "nameEn": "Moldova, Republic of",
      "nameAr": "مولدوفا، جمهورية",
      "code": "MD",
      "continent": "Europe"
    },
    {
      "nameEn": "Monaco",
      "nameAr": "موناكو",
      "code": "MC",
      "continent": "Europe"
    },
    {
      "nameEn": "Mongolia",
      "nameAr": "منغوليا",
      "code": "MN",
      "continent": "Asia"
    },
    {
      "nameEn": "Montserrat",
      "nameAr": "مونتسيرات",
      "code": "MS",
      "continent": "North America"
    },
    {
      "nameEn": "Morocco",
      "nameAr": "المغرب",
      "code": "MA",
      "continent": "Africa"
    },
    {
      "nameEn": "Mozambique",
      "nameAr": "موزمبيق",
      "code": "MZ",
      "continent": "Africa"
    },
    {
      "nameEn": "Myanmar",
      "nameAr": "ميانمار",
      "code": "MM",
      "continent": "Asia"
    },
    {
      "nameEn": "Namibia",
      "nameAr": "ناميبيا",
      "code": "NA",
      "continent": "Africa"
    },
    {
      "nameEn": "Nauru",
      "nameAr": "ناورو",
      "code": "NR",
      "continent": "Oceania"
    },
    {"nameEn": "Nepal", "nameAr": "نيبال", "code": "NP", "continent": "Asia"},
    {
      "nameEn": "Netherlands",
      "nameAr": "هولندا",
      "code": "NL",
      "continent": "Europe"
    },
    {
      "nameEn": "Netherlands Antilles",
      "nameAr": "جزر الأنتيل الهولندية",
      "code": "AN",
      "continent": "North America"
    },
    {
      "nameEn": "New Caledonia",
      "nameAr": "كاليدونيا الجديدة",
      "code": "NC",
      "continent": "Oceania"
    },
    {
      "nameEn": "New Zealand",
      "nameAr": "نيوزيلندا",
      "code": "NZ",
      "continent": "Oceania"
    },
    {
      "nameEn": "Nicaragua",
      "nameAr": "نيكاراغوا",
      "code": "NI",
      "continent": "North America"
    },
    {
      "nameEn": "Niger",
      "nameAr": "النيجر",
      "code": "NE",
      "continent": "Africa"
    },
    {
      "nameEn": "Nigeria",
      "nameAr": "نيجيريا",
      "code": "NG",
      "continent": "Africa"
    },
    {"nameEn": "Niue", "nameAr": "نيوي", "code": "NU", "continent": "Oceania"},
    {
      "nameEn": "Norfolk Island",
      "nameAr": "جزيرة نورفولك",
      "code": "NF",
      "continent": "Oceania"
    },
    {
      "nameEn": "Northern Mariana Islands",
      "nameAr": "جزر ماريانا الشمالية",
      "code": "MP",
      "continent": "Oceania"
    },
    {
      "nameEn": "Norway",
      "nameAr": "النرويج",
      "code": "NO",
      "continent": "Europe"
    },
    {"nameEn": "Oman", "nameAr": "عُمان", "code": "OM", "continent": "Asia"},
    {
      "nameEn": "Pakistan",
      "nameAr": "باكستان",
      "code": "PK",
      "continent": "Asia"
    },
    {
      "nameEn": "Palau",
      "nameAr": "بالاو",
      "code": "PW",
      "continent": "Oceania"
    },
    {
      "nameEn": "Palestinian Territory, Occupied",
      "nameAr": "الأراضي الفلسطينية المحتلة",
      "code": "PS",
      "continent": "Asia"
    },
    {
      "nameEn": "Panama",
      "nameAr": "بنما",
      "code": "PA",
      "continent": "North America"
    },
    {
      "nameEn": "Papua New Guinea",
      "nameAr": "بابوا غينيا الجديدة",
      "code": "PG",
      "continent": "Oceania"
    },
    {
      "nameEn": "Paraguay",
      "nameAr": "باراغواي",
      "code": "PY",
      "continent": "South America"
    },
    {
      "nameEn": "Peru",
      "nameAr": "بيرو",
      "code": "PE",
      "continent": "South America"
    },
    {
      "nameEn": "Philippines",
      "nameAr": "الفلبين",
      "code": "PH",
      "continent": "Asia"
    },
    {
      "nameEn": "Pitcairn",
      "nameAr": "بيتكيرن",
      "code": "PN",
      "continent": "Oceania"
    },
    {
      "nameEn": "Poland",
      "nameAr": "بولندا",
      "code": "PL",
      "continent": "Europe"
    },
    {
      "nameEn": "Portugal",
      "nameAr": "البرتغال",
      "code": "PT",
      "continent": "Europe"
    },
    {
      "nameEn": "Puerto Rico",
      "nameAr": "بورتوريكو",
      "code": "PR",
      "continent": "North America"
    },
    {"nameEn": "Qatar", "nameAr": "قطر", "code": "QA", "continent": "Asia"},
    {
      "nameEn": "Reunion",
      "nameAr": "لا ريونيون",
      "code": "RE",
      "continent": "Africa"
    },
    {
      "nameEn": "Romania",
      "nameAr": "رومانيا",
      "code": "RO",
      "continent": "Europe"
    },
    {
      "nameEn": "Russian Federation",
      "nameAr": "الاتحاد الروسي",
      "code": "RU",
      "continent": "Europe"
    },
    {
      "nameEn": "RWANDA",
      "nameAr": "رواندا",
      "code": "RW",
      "continent": "Africa"
    },
    {
      "nameEn": "Saint Helena",
      "nameAr": "سانت هيلانة",
      "code": "SH",
      "continent": "Africa"
    },
    {
      "nameEn": "Saint Kitts and Nevis",
      "nameAr": "سانت كيتس ونيفيس",
      "code": "KN",
      "continent": "North America"
    },
    {
      "nameEn": "Saint Lucia",
      "nameAr": "سانت لوسيا",
      "code": "LC",
      "continent": "North America"
    },
    {
      "nameEn": "Saint Pierre and Miquelon",
      "nameAr": "سانت بيير وميكلون",
      "code": "PM",
      "continent": "North America"
    },
    {
      "nameEn": "Saint Vincent and the Grenadines",
      "nameAr": "سانت فنسنت والغرينادين",
      "code": "VC",
      "continent": "North America"
    },
    {
      "nameEn": "Samoa",
      "nameAr": "ساموا",
      "code": "WS",
      "continent": "Oceania"
    },
    {
      "nameEn": "San Marino",
      "nameAr": "سان مارينو",
      "code": "SM",
      "continent": "Europe"
    },
    {
      "nameEn": "Sao Tome and Principe",
      "nameAr": "ساو تومي وبرينسيبي",
      "code": "ST",
      "continent": "Africa"
    },
    {
      "nameEn": "Saudi Arabia",
      "nameAr": "المملكة العربية السعودية",
      "code": "SA",
      "continent": "Asia"
    },
    {
      "nameEn": "Senegal",
      "nameAr": "السنغال",
      "code": "SN",
      "continent": "Africa"
    },
    {
      "nameEn": "Serbia and Montenegro",
      "nameAr": "صربيا والجبل الأسود",
      "code": "CS",
      "continent": "Europe"
    },
    {
      "nameEn": "Seychelles",
      "nameAr": "سيشيل",
      "code": "SC",
      "continent": "Africa"
    },
    {
      "nameEn": "Sierra Leone",
      "nameAr": "سيراليون",
      "code": "SL",
      "continent": "Africa"
    },
    {
      "nameEn": "Singapore",
      "nameAr": "سنغافورة",
      "code": "SG",
      "continent": "Asia"
    },
    {
      "nameEn": "Slovakia",
      "nameAr": "سلوفاكيا",
      "code": "SK",
      "continent": "Europe"
    },
    {
      "nameEn": "Slovenia",
      "nameAr": "سلوفينيا",
      "code": "SI",
      "continent": "Europe"
    },
    {
      "nameEn": "Solomon Islands",
      "nameAr": "جزر سليمان",
      "code": "SB",
      "continent": "Oceania"
    },
    {
      "nameEn": "Somalia",
      "nameAr": "الصومال",
      "code": "SO",
      "continent": "Africa"
    },
    {
      "nameEn": "South Africa",
      "nameAr": "جنوب أفريقيا",
      "code": "ZA",
      "continent": "Africa"
    },
    {
      "nameEn": "South Georgia and the South Sandwich Islands",
      "nameAr": "جورجيا الجنوبية وجزر ساندويتش الجنوبية",
      "code": "GS",
      "continent": "Antarctica"
    },
    {
      "nameEn": "Spain",
      "nameAr": "إسبانيا",
      "code": "ES",
      "continent": "Europe"
    },
    {
      "nameEn": "Sri Lanka",
      "nameAr": "سريلانكا",
      "code": "LK",
      "continent": "Asia"
    },
    {
      "nameEn": "Sudan",
      "nameAr": "السودان",
      "code": "SD",
      "continent": "Africa"
    },
    {
      "nameEn": "Suriname",
      "nameAr": "سورينام",
      "code": "SR",
      "continent": "South America"
    },
    {
      "nameEn": "Svalbard and Jan Mayen",
      "nameAr": "سفالبارد ويان ماين",
      "code": "SJ",
      "continent": "Europe"
    },
    {
      "nameEn": "Swaziland",
      "nameAr": "سوازيلاند",
      "code": "SZ",
      "continent": "Africa"
    },
    {
      "nameEn": "Sweden",
      "nameAr": "السويد",
      "code": "SE",
      "continent": "Europe"
    },
    {
      "nameEn": "Switzerland",
      "nameAr": "سويسرا",
      "code": "CH",
      "continent": "Europe"
    },
    {
      "nameEn": "Syrian Arab Republic",
      "nameAr": "الجمهورية العربية السورية",
      "code": "SY",
      "continent": "Asia"
    },
    {
      "nameEn": "Taiwan, Province of China",
      "nameAr": "تايوان، إقليم الصين",
      "code": "TW",
      "continent": "Asia"
    },
    {
      "nameEn": "Tajikistan",
      "nameAr": "طاجيكستان",
      "code": "TJ",
      "continent": "Asia"
    },
    {
      "nameEn": "Tanzania, United Republic of",
      "nameAr": "تنزانيا، جمهورية متحدة",
      "code": "TZ",
      "continent": "Africa"
    },
    {
      "nameEn": "Thailand",
      "nameAr": "تايلاند",
      "code": "TH",
      "continent": "Asia"
    },
    {
      "nameEn": "Timor-Leste",
      "nameAr": "تيمور الشرقية",
      "code": "TL",
      "continent": "Asia"
    },
    {"nameEn": "Togo", "nameAr": "توغو", "code": "TG", "continent": "Africa"},
    {
      "nameEn": "Tokelau",
      "nameAr": "توكيلاو",
      "code": "TK",
      "continent": "Oceania"
    },
    {
      "nameEn": "Tonga",
      "nameAr": "تونغا",
      "code": "TO",
      "continent": "Oceania"
    },
    {
      "nameEn": "Trinidad and Tobago",
      "nameAr": "ترينيداد وتوباغو",
      "code": "TT",
      "continent": "North America"
    },
    {
      "nameEn": "Tunisia",
      "nameAr": "تونس",
      "code": "TN",
      "continent": "Africa"
    },
    {"nameEn": "Turkey", "nameAr": "تركيا", "code": "TR", "continent": "Asia"},
    {
      "nameEn": "Turkmenistan",
      "nameAr": "تركمانستان",
      "code": "TM",
      "continent": "Asia"
    },
    {
      "nameEn": "Turks and Caicos Islands",
      "nameAr": "جزر تركس وكايكوس",
      "code": "TC",
      "continent": "North America"
    },
    {
      "nameEn": "Tuvalu",
      "nameAr": "توفالو",
      "code": "TV",
      "continent": "Oceania"
    },
    {
      "nameEn": "Uganda",
      "nameAr": "أوغندا",
      "code": "UG",
      "continent": "Africa"
    },
    {
      "nameEn": "Ukraine",
      "nameAr": "أوكرانيا",
      "code": "UA",
      "continent": "Europe"
    },
    {
      "nameEn": "United Arab Emirates",
      "nameAr": "الإمارات العربية المتحدة",
      "code": "AE",
      "continent": "Asia"
    },
    {
      "nameEn": "United Kingdom",
      "nameAr": "المملكة المتحدة",
      "code": "GB",
      "continent": "Europe"
    },
    {
      "nameEn": "United States",
      "nameAr": "الولايات المتحدة",
      "code": "US",
      "continent": "North America"
    },
    {
      "nameEn": "United States Minor Outlying Islands",
      "nameAr": "الجزر البعيدة الصغيرة للولايات المتحدة",
      "code": "UM",
      "continent": "Oceania"
    },
    {
      "nameEn": "Uruguay",
      "nameAr": "أوروغواي",
      "code": "UY",
      "continent": "South America"
    },
    {
      "nameEn": "Uzbekistan",
      "nameAr": "أوزبكستان",
      "code": "UZ",
      "continent": "Asia"
    },
    {
      "nameEn": "Vanuatu",
      "nameAr": "فانواتو",
      "code": "VU",
      "continent": "Oceania"
    },
    {
      "nameEn": "Venezuela",
      "nameAr": "فنزويلا",
      "code": "VE",
      "continent": "South America"
    },
    {
      "nameEn": "Viet Nam",
      "nameAr": "فيتنام",
      "code": "VN",
      "continent": "Asia"
    },
    {
      "nameEn": "Virgin Islands, British",
      "nameAr": "جزر العذراء البريطانية",
      "code": "VG",
      "continent": "North America"
    },
    {
      "nameEn": "Virgin Islands, U.S.",
      "nameAr": "جزر العذراء الأمريكية",
      "code": "VI",
      "continent": "North America"
    },
    {
      "nameEn": "Wallis and Futuna",
      "nameAr": "واليس وفوتونا",
      "code": "WF",
      "continent": "Oceania"
    },
    {
      "nameEn": "Western Sahara",
      "nameAr": "الصحراء الغربية",
      "code": "EH",
      "continent": "Africa"
    },
    {"nameEn": "Yemen", "nameAr": "اليمن", "code": "YE", "continent": "Asia"},
    {
      "nameEn": "Zambia",
      "nameAr": "زامبيا",
      "code": "ZM",
      "continent": "Africa"
    },
    {
      "nameEn": "Zimbabwe",
      "nameAr": "زيمبابوي",
      "code": "ZW",
      "continent": "Africa"
    }
  ];
}
