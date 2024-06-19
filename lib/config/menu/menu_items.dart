import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String subTitle;
  final String link;
  final IconData icon;

  const MenuItem(
      {required this.title,
      required this.subTitle,
      required this.link,
      required this.icon});
}

const appMenuItems = <MenuItem>[
  MenuItem(
      title: 'Aliso',
      subTitle: 'Alnus Glutinosa',
      link: '/AlisoScreen',
      icon: Icons.abc),
  MenuItem(
      title: 'Pino', subTitle: 'Pino', link: '/PinoScreen', icon: Icons.face),
  MenuItem(
      title: 'Ciprés',
      subTitle: 'Cipres',
      link: '/CipresScreen',
      icon: Icons.e_mobiledata),
  MenuItem(
      title: 'Pona',
      subTitle: 'Pona',
      link: '/PonaScreen',
      icon: Icons.h_mobiledata_rounded),
];
