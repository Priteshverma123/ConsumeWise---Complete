import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingMenu extends StatelessWidget {
  const SettingMenu({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
    this.trailing,
    this.onTap,
});

  final IconData icon;
  final VoidCallback? onTap;
  final String title ,subTitle;
  final Widget ? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon,size:28,color: Colors.black87,),
      title: Text(title,style: TextStyle(fontWeight: FontWeight.w800,fontSize: 18),),
      subtitle: Text(subTitle,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
