import '../../../../utils/tools/file_important.dart';

Widget buildDateField(TextEditingController controller, String hint) {
  return Container(
    width: 73,
    child: TextField(
      controller: controller,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      keyboardType: TextInputType.number,
    ),
  );
}
