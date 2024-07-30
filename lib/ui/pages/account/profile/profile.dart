import 'package:talaba_uz/ui/pages/account/profile/profile_dialog.dart';
import 'package:talaba_uz/utils/tools/file_important.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  final TextEditingController dayController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  String email = '';
  String name = '';
  String surname = '';
  String region = '';
  String phone = '';
  String date = '';
  String image = '';
  int userId = 0;
  String selectedRegion = '';
  String _selectedDate = '';
  Uint8List? _image;
  File? selectedImage;
  bool readOnlyName = true;
  bool readOnlySurname = true;
  bool readOnlyRegion = true;
  Dio _dio = Dio();
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // ignore: unused_element
  Future<void> _navigateToProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AccountPage(),
      ),
    );
    if (result == true) {
      _loadData(); // Reload the data after profile update
    }
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email') ??
          email; // If userId is null, use empty string as default value
      name = prefs.getString('name') ?? name;
      surname = prefs.getString('surname') ?? surname;
      region = prefs.getString('region') ?? region;
      phone = prefs.getString('phone_number') ?? phone;
      date = prefs.getString('birth') ?? date;
      userId = prefs.getInt('id') ?? userId;

      nameController.text = name;
      surnameController.text = surname;
      nameController.text = name;
      emailController.text = email;
      phoneController.text = phone;
      dateController.text = date;
      regionController.text = region;
      print(dateController.text);
    });
  }

  Future<void> _updateName() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final url = "$baseUrl/api/v1/accounts/update/$userId/";
      await prefs.setString('name', nameController.text);

      final response = await _dio.patch(
        url,
        data: {
          'name': nameController.text,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        print('Name updated successfully');
      } else {
        print('Failed to update profile: ${response.statusCode}');
      }
    } on DioError catch (e) {
      print(
          'Error: ${e.response?.statusCode ?? 'No status code'} ${e.message}');
      print('Error data: ${e.response?.data}');
    }
  }

  Future<void> _updateSurname() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final url = "$baseUrl/api/v1/accounts/update/$userId/";
      await prefs.setString('surname', surnameController.text);

      print("Request URL: $url");

      final response = await _dio.patch(
        url,
        data: {
          'surname': surnameController.text,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        print('Surname updated successfully');
      } else {
        print('Failed to update profile: ${response.statusCode}');
      }
    } on DioError catch (e) {
      print(
          'Error: ${e.response?.statusCode ?? 'No status code'} ${e.message}');
      print('Error data: ${e.response?.data}');
    }
  }

  Future<void> _updateRegion() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final url = "$baseUrl/api/v1/accounts/update/$userId/";
      await prefs.setString('region', selectedRegion);

      final response = await _dio.patch(
        url,
        data: {
          'region': selectedRegion,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        print('Region updated successfully');
      } else {
        print('Failed to update profile: ${response.statusCode}');
      }
    } on DioError catch (e) {
      print(
          'Error: ${e.response?.statusCode ?? 'No status code'} ${e.message}');
      print('Error data: ${e.response?.data}');
    }
  }

  Future<void> _updateDate() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final url = "$baseUrl/api/v1/accounts/update/$userId/";
      await prefs.setString('birth', _selectedDate);

      final response = await _dio.patch(
        url,
        data: {
          'birth': _selectedDate,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        print('Birth updated successfully');
      } else {
        print('Failed to update profile: ${response.statusCode}');
      }
    } on DioError catch (e) {
      print(
          'Error: ${e.response?.statusCode ?? 'No status code'} ${e.message}');
      print('Error data: ${e.response?.data}');
    }
  }

  Future<void> _pickImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    try {
      final XFile? returnImage =
          await _picker.pickImage(source: ImageSource.gallery);
      if (returnImage != null) {
        final Uint8List imageBytes = await File(returnImage.path).readAsBytes();
        setState(() {
          selectedImage = File(returnImage.path);
          _image = imageBytes;
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  void _showDatePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tug\'ilgan sana'),
          content: SizedBox(
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildDateField(yearController, 'YYYY'),
                buildDateField(monthController, 'MM'),
                buildDateField(dayController, 'DD'),
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SizedBox(
                width: width(context) / 3.3,
                child: WElevatedButton(
                  text: Text(
                    "Bekor qilish",
                    style: TextStyle(color: whiteColor, fontSize: 12),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width(context) / 3.3,
              child: WElevatedButton(
                onPressed: () {
                  _selectedDate =
                      "${yearController.text}-${monthController.text.padLeft(2, '0')}-${dayController.text.padLeft(2, '0')}";
                  setState(() {
                    dateController.text = _selectedDate;
                  });
                  _updateDate();
                  Navigator.of(context).pop();
                },
                text: Text('Saqlash', style: TextStyle(color: whiteColor)),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showRegionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Hududingizni tanlang'),
              content: Container(
                width: double.maxFinite,
                height: height(context) / 2,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: regionList.length,
                  itemBuilder: (context, index) {
                    String region = regionList[index];
                    final isSelected = region == selectedRegion;

                    return ListTile(
                      title: Text(
                        region[0].toUpperCase() +
                            region.substring(1).toLowerCase(),
                      ),
                      onTap: () {
                        setState(() {
                          selectedRegion = regionList[index];
                        });
                      },
                      trailing: isSelected
                          ? Icon(Icons.check, color: blueColor)
                          : null,
                    );
                  },
                ),
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SizedBox(
                        width: width(context) / 3.3,
                        child: WElevatedButton(
                          text: Text(
                            "Bekor qilish",
                            style: TextStyle(color: whiteColor, fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width(context) / 3.3,
                      child: WElevatedButton(
                        onPressed: () {
                          _updateRegion();
                          Navigator.pop(context);
                        },
                        text: Text(
                          "Saqlash",
                          style: TextStyle(color: whiteColor, fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEFEEFC),
      appBar: AppBar(
        leadingWidth: 41,
        leading: GestureDetector(
          onTap: () {
            _navigateToProfile();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 25),
            child: SvgPicture.asset(
              "assets/icons/arrow_back.svg",
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xffEFEEFC),
        title: Text(
          'Profilim',
          style: TextStyle(
            fontSize: 6 * devisePixel(context),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
          width: width(context),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: height(context) * 0.05, top: height(context) * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 40,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : CircleAvatar(
                            radius: 40,
                          ),
                    Container(
                      width: 25,
                      height: 25,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                          onTap: () {
                            _pickImageFromGallery();
                          },
                          child: Image.asset("assets/images/camera.png")),
                    ),
                  ],
                ),
                SizedBox(
                  height: height(context) / 18,
                ),
                WidgetTextField(
                  hintText: "",
                  controller: nameController,
                  obscureText: false,
                  headText: "Ism",
                  readOnly: readOnlyName,
                  hintStyle: const TextStyle(color: Colors.black),
                  suffixIconConstraints: const BoxConstraints(),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        showEditProfileDialog(
                            "Ismingizni kiriting", nameController, () {
                          _updateName();
                          Navigator.pop(context);
                        }, context);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Image.asset(
                        "assets/images/edit.png",
                        width: 24,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                WidgetTextField(
                  controller: surnameController,
                  obscureText: false,
                  hintText: "",
                  headText: "Familiya",
                  readOnly: readOnlySurname,
                  hintStyle: const TextStyle(color: Colors.black),
                  suffixIconConstraints: const BoxConstraints(),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        showEditProfileDialog(
                            "Familiyangizni kiriting", surnameController, () {
                          _updateSurname();
                          Navigator.pop(context);
                        }, context);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Image.asset(
                        "assets/images/edit.png",
                        width: 24,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                WidgetTextField(
                  hintText: selectedRegion == ""
                      ? regionController.text
                      : selectedRegion,
                  obscureText: false,
                  headText: "Manzili",
                  readOnly: readOnlyRegion,
                  hintStyle: const TextStyle(color: Colors.black),
                  suffixIconConstraints: const BoxConstraints(),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _showRegionDialog();
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Image.asset(
                        "assets/images/edit.png",
                        width: 24,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                information(context, emailController, dateController, () {
                  setState(() {
                    _showDatePickerDialog(context);
                  });
                }, phoneController, userId),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
