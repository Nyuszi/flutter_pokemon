import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function() onPressed;
  final bool navigateBack;

  const CustomAppBar({
    super.key,
    required this.onPressed,
    this.navigateBack = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final Uri pokeApiUrl = Uri.parse('https://pokeapi.co/');
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return AppBar(
          backgroundColor: Colors.red,
          leading: sizingInformation.isMobile
              ? IconButton(
                  icon:
                      navigateBack ? const Icon(Icons.arrow_back) : const Icon(Icons.menu),
                  color: Colors.white,
                  onPressed: () {
                    onPressed();
                  },
                )
              : Image.asset(
                  'assets/logo_png.png',
                  height: 40,
                ),
          title: sizingInformation.isMobile
              ? Center(
                  child: Image.asset(
                    'assets/logo_png.png',
                    height: 40,
                  ),
                )
              : Container(),
          actions: !sizingInformation.isMobile
              ? [
                  TextButton(
                      onPressed: () async {
                        if (!await launchUrl(pokeApiUrl)) {
                          throw Exception('Could not launch $pokeApiUrl');
                        }
                      },
                      child: const Text(
                        "PokeAPI Documentation",
                        style: TextStyle(color: Colors.white),
                      ))
                ]
              : [],
        );
      },
    );
  }
}
