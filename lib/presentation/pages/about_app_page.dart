import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/constants.dart';
import 'package:flutter/material.dart';

class AboutAppPage extends StatelessWidget {
  static const NAME_ROUTE = '/about-page';

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.blue,
                  child: Center(
                    child: Image.asset(
                      ASSET,
                      width: 128,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(32.0),
                  color: Colors.yellow,
                  child: Text(
                    ABOUT_APP,
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ],
          ),
          SafeArea(
            child: IconButton(
              onPressed: () => Navigator.pop(ctx),
              icon: Icon(Icons.arrow_back),
            ),
          )
        ],
      ),
    );
  }
}
