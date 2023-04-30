import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hello_doctor/utils/config.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget{
  const CustomAppBar({
    Key? key,
    this.appTitle,
    this.route,
    this.icon,
    this.actions,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60); // custom height of app bar

  final String? appTitle;
  final String? route;
  final FaIcon? icon;
  final List<Widget>? actions;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: Colors.white, // background color of app bar is white
      elevation: 0,
      title: Center(
        child: Text(
          widget.appTitle!,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
      leading: widget.icon != null ? Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Config.primaryColor,
        ),
        child: IconButton(
          onPressed: () {
            if(widget.icon != null) {
              // if route is given, then move to that route
              Navigator.of(context).pushNamed(widget.route!);
            } else {
              // else simply pop to previous screen
              Navigator.of(context).pop();
            }
          },
          icon: widget.icon!,
          iconSize: 16,
          color: Colors.white,
        ),
      ) : null,
      // if action is not given, return null
      actions: widget.actions ?? null,
    );
  }
}
