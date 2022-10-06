import 'package:flutter/material.dart';

class TitleBar extends StatelessWidget {
  String title = "";
  TitleBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(children: [
            Expanded(
              child: Text(
                title,
                maxLines: 2,
                softWrap: false,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ]),
          const SizedBox(height: 4),
          Divider(
              thickness: 2,
              indent: 10,
              endIndent: 10,
              color: Colors.white.withOpacity(0.3))
        ],
      ),
    );
  }
}
