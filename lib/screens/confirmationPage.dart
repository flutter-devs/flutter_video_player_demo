import 'package:flutter/material.dart';
import 'package:flutter_video_player_demo/services/authService.dart';

class ConfirmationPage extends StatefulWidget {
  final username;
  ConfirmationPage({Key key, this.username}) : super(key: key);

  @override
  _ConfirmationPageState createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  String code = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              height: 300,
              width: MediaQuery.of(context).size.width - 30.0,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.7),
                  )
                ],
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: 'Enter Code'),
                    onChanged: (val) {
                      setState(() {
                        code = val;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: () {
                        AuthService()
                            .confirmUser(widget.username, code, context);
                      },
                      child: Center(
                        child: Text('Send Code'),
                      )),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
