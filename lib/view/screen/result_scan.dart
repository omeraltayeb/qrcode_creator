import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultScan extends StatelessWidget {
  const ResultScan({super.key, this.value});
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan results'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        if (value!.startsWith('http://') ||
                            value!.startsWith('https://')) {
                          final Uri url = Uri.parse(value!);
                          await launchUrl(url,
                              mode: LaunchMode.externalApplication);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Could not launch $value!')),
                          );
                        }
                      },
                      child: Text(
                        value!,
                        style: TextStyle(
                          color: value!.startsWith('http://') ||
                                  value!.startsWith('https://')
                              ? Colors.blue
                              : Colors.black,
                          decoration: value!.startsWith('http://') ||
                                  value!.startsWith('https://')
                              ? TextDecoration.underline
                              : TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        if (value!.isNotEmpty) {
                          FlutterClipboard.copy(value!);
                        }
                      },
                      icon: Icon(Icons.copy))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
