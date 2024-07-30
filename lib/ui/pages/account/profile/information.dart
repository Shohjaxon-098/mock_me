import '../../../../utils/tools/file_important.dart';

Widget information(
  context,
  emailController,
  dateController,
  onTap,
  phoneController,
  userId,
) {
  return Container(
    width: width(context) / 1.2,
    height: height(context) / 3.6,
    decoration: BoxDecoration(
      color: whiteColor,
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 24,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Qo’shimcha ma’lumotlar',
          style: TextStyle(
            fontSize: 5 * devisePixel(context),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Image.asset(
              "assets/icons/mail.png",
              width: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                "Email",
                style: TextStyle(
                  color: Colors.black45,
                  fontWeight: FontWeight.w600,
                  fontSize: 4.5 * devisePixel(context),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                emailController.text,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 3.8 * devisePixel(context),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Image.asset(
              "assets/icons/calendar.png",
              width: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                "Tug’ilgan y,o,s",
                style: TextStyle(
                  color: Colors.black45,
                  fontWeight: FontWeight.w600,
                  fontSize: 4.5 * devisePixel(context),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                dateController.text,
                style: TextStyle(
                  fontSize: 3.8 * devisePixel(context),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            GestureDetector(
              onTap: onTap,
              child: Image.asset(
                "assets/images/edit.png",
                width: 18,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Image.asset(
              "assets/icons/call.png",
              width: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                "Telefon raqam",
                style: TextStyle(
                  color: Colors.black45,
                  fontWeight: FontWeight.w600,
                  fontSize: 4.5 * devisePixel(context),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                "+998 ${phoneController.text}",
                style: TextStyle(
                  fontSize: 3.8 * devisePixel(context),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Image.asset(
              "assets/icons/id.png",
              width: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                "ID",
                style: TextStyle(
                  color: Colors.black45,
                  fontWeight: FontWeight.w600,
                  fontSize: 3.8 * devisePixel(context),
                ),
              ),
            ),
            const Spacer(),
            Text(
              "$userId",
              style: TextStyle(
                fontSize: 4.5 * devisePixel(context),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
