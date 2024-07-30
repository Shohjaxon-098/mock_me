  import '../../../../utils/tools/file_important.dart';

void showEditProfileDialog(
    String title,
    TextEditingController controller,
    Function? onPrassed,
    context
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: whiteColor,
          backgroundColor: whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          content: SizedBox(
            height: height(context) * 0.09,
            width: width(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 5 * devisePixel(context),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 40,
                  child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        fillColor: backColor,
                        filled: true,
                        contentPadding: EdgeInsets.only(bottom: 10, left: 14),
                        constraints: BoxConstraints(),
                        prefixStyle: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 5 * devisePixel(context),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                      )),
                ),
              ],
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
                    onPressed: onPrassed,
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
  }
 