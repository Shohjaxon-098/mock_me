// ignore_for_file: prefer_typing_uninitialized_variables


import 'package:talaba_uz/utils/tools/file_important.dart';

List<String> regionList = [
  "tashkent",
  "andijan",
  "fergana",
  "namangan",
  "sirdarya",
  "jizzax",
  "samarqand",
  "qashqadarya",
  "navoi",
  "buxoro",
  "xorazm",
  "qoraqalpogiston",
];
List<String> scienceList = [
  "Matematika",
  "Tarix",
  "Ona tili",
  "Fizika",
  "Kimyo",
  "Biologiya",
  "Geografiya",
  "Ingliz tili",
];
List<dynamic> listImage = [
  "assets/images/image263.jpg",
  "assets/images/image264.jpg",
  "assets/images/image264.jpg"
];
List pages = [
  const Home(),
  const DiagnostPage(),
  const ChartPage(),
  const AccountPage(),
];
var jsonList;
var jsonDegree;
var jsonImageList;
Map<String, String> subjectChoices = {
  'math': 'Matematika',
  'english': 'English',
  'russian': 'Rus tili',
  'chemist': 'Kimyo',
  'biology': 'Biologiya',
  'mothlang': 'Ona tili',
  'history': 'Tarix',
  'geography': 'Geografiya',
  'special': 'Maburiy testlar',
  'physics': 'Fizika',
};
List icons = [
  SvgPicture.asset("assets/icons/homeBottomNoActive.svg"),
  SvgPicture.asset("assets/icons/testlarBottomNoActive.svg"),
  SvgPicture.asset("assets/icons/chartBottomNoActive.svg"),
  SvgPicture.asset("assets/icons/accountBottomNoActive.svg"),
];
