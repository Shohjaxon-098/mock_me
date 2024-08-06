// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:talaba_uz/ui/pages/account/newPass_first.dart';
import 'package:talaba_uz/utils/tools/file_important.dart';

import '../../../utils/url_launcher/url.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String email = '';
  String name = '';
  String surname = '';

  @override
  void initState() {
    super.initState();
    _loadData();
    _loadImage();
  }

  File? _imageFile;
  Future<void> _loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('image');
    if (imagePath != null) {
      setState(() {
        _imageFile = File(imagePath);
      });
    }
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email') ??
          email; // If userId is null, use empty string as default value
      name = prefs.getString('name') ?? name;
      surname = prefs.getString('surname') ?? surname;
    });
  }

  Future<void> _refreshData() async {
    await _loadData();
    await _loadImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEFEEFC),
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text(
          'Shaxsiy akkaunt',
          style: TextStyle(
            fontSize: 6 * devisePixel(context),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {},
              child: SvgPicture.asset("assets/icons/notification.svg"),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: blueColor,
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          child: SizedBox(
            height: height(context) / 1.2,
            child: Column(
              children: [
                Container(
                  width: width(context),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(color: whiteColor),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          _imageFile == null
                              ? CircleAvatar(
                                  radius: 18,
                                  child: _imageFile == null
                                      ? Icon(
                                          Icons.person,
                                          size: 20,
                                          color: blueColor,
                                        )
                                      : null,
                                )
                              : CircleAvatar(
                                  radius: 18,
                                  backgroundImage: FileImage(_imageFile!),
                                  child: _imageFile == null
                                      ? Icon(
                                          Icons.person,
                                          size: 20,
                                          color: blueColor,
                                        )
                                      : null,
                                ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "$name $surname",
                                  style: TextStyle(
                                    fontSize: 4.5 * devisePixel(context),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  email,
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 4 * devisePixel(context),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  width: width(context),
                  decoration: BoxDecoration(color: whiteColor),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 35),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: Profile(
                                      email: email,
                                      name: name,
                                      surname: surname,
                                    ),
                                    type: PageTransitionType.rightToLeft));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: const Color(0xffff0f6ff),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                        "assets/images/profile.png"),
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  "Profilim",
                                  style: TextStyle(
                                    fontSize: 5 * devisePixel(context),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 6),
                          child: Divider(),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: const UpdatePasswordFirst(),
                                    type: PageTransitionType.rightToLeft));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: const Color(0xffff0f6ff),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(
                                        "assets/icons/lock_settings.svg"),
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  "Parolni Yangilash",
                                  style: TextStyle(
                                    fontSize: 5 * devisePixel(context),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 6),
                          child: Divider(),
                        ),
                        GestureDetector(
                          onTap: () {
                            Uri uri = Uri.parse("https://t.me/Mock_Meteam");
                            launcher(uri);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: const Color(0xffff0f6ff),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:
                                        Image.asset("assets/images/info.png"),
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  "Ma’lumot",
                                  style: TextStyle(
                                    fontSize: 5 * devisePixel(context),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 6),
                          child: Divider(),
                        ),
                        GestureDetector(
                          onTap: () {
                            Uri uri = Uri.parse("t.me/contact_mockmebot");
                            launcher(uri);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: const Color(0xffff0f6ff),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:
                                        Image.asset("assets/images/call.png"),
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  "Biz bilan bog’lanish",
                                  style: TextStyle(
                                    fontSize: 5 * devisePixel(context),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  width: width(context),
                  height: 40,
                  color: whiteColor,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: GestureDetector(
                    onTap: () {
                      var auth = Hive.box('auth');
                      auth.delete("token");
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StartPage(),
                          ),
                          (route) => false);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Akkauntdan chiqish",
                          style: TextStyle(
                              color: Color(0xffE31E24),
                              fontWeight: FontWeight.w600),
                        ),
                        Image.asset(
                          "assets/images/back.png",
                          width: 24,
                        )
                      ],
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
