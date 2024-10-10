import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PruebaUrl extends StatelessWidget {
  PruebaUrl({super.key});
  final Uri _url = Uri.parse('https://flutter.dev');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              _launchUrl();
            },
            child: const Text('url')),
      ),
    );
  }
}
