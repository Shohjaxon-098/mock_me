
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget buildSection({
  required String title,
  required String count,
  required bool isExpanded,
  VoidCallback? onTap,
  IconData? iconClosed,
  IconData? iconOpened,
}) {
  final IconData currentIcon = isExpanded
      ? (iconOpened ?? Icons.expand_more) // Default path for expanded
      : (iconClosed ?? Icons.chevron_right);

  return Padding(
    padding: EdgeInsets.only(bottom: 12),
    child: SizedBox(
      width: double.infinity,
      height: 24,
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF1E1E1E),
                fontWeight: FontWeight.normal,
              ),
              overflow: TextOverflow.ellipsis,
            ),

          ),
          if(iconClosed != null && iconOpened != null)
          InkWell(
            onTap: onTap,
            child: Icon(
              currentIcon,
              size: 24,
            ),
          ),
          SizedBox(width: iconClosed != null && iconOpened != null ? 165 : 0,),
          Text(
            count,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF1E1E1E),
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  );
}

Widget buildSubject({required String title, required String count}){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF1E1E1E),
            fontWeight: FontWeight.normal,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          count,
        textAlign: TextAlign.right,
        style: TextStyle(
          fontSize: 12,
          color: Color(0xFF1E1E1E),
          fontWeight: FontWeight.bold,
        ),
        overflow: TextOverflow.ellipsis,
        )
      ],
    ),
  );
}