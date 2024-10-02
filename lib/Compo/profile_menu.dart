import 'package:flutter/material.dart';
class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key,
    required this.onPressed,
    required this.title,
    required this.value,
    this.icon = Icons.chevron_right_rounded,
});

  final IconData icon;
  final VoidCallback onPressed;
  final String title , value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical:10),
        child: Row(
          children: [
            Expanded(flex:3,child: Text(title,style: TextStyle(overflow: TextOverflow.ellipsis,fontSize: 14),)),
            Expanded(flex:5,child: Text(value,style: TextStyle(overflow: TextOverflow.ellipsis,fontSize: 17,fontWeight: FontWeight.w600),)),
            Expanded(child:  Icon( icon ,size: 18,)),
          ],
        ),
      ),
    );
  }
}
