import 'package:flutter/material.dart';
import 'package:flutter_video_player_demo/Utils/localData.dart';
import 'package:flutter_video_player_demo/screens/authPage.dart';
import 'package:flutter_video_player_demo/screens/profile.dart';
import 'package:flutter_video_player_demo/video_items.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isAuthenticated = false;
  void initState() {
    super.initState();
    setState(() {
      Utils.getBooleanValue("isAuthenticated").then((value) {
        setState(() {
          isAuthenticated = value;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Flutter Video Player Demo'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ListView(
            children: <Widget>[
              VideoItems(
                videoPlayerController: VideoPlayerController.asset(
                  'assets/video_6.mp4',
                ),
                looping: true,
                autoplay: true,
              ),
              VideoItems(
                videoPlayerController: VideoPlayerController.network(
                    //'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4'
                    'https://amplify-awsamp-dev-01624-deployment.s3.ap-south-1.amazonaws.com/Videos/UserVideos/image_picker457634646972079356.mp4'),
                looping: false,
                autoplay: true,
              ),
              VideoItems(
                videoPlayerController: VideoPlayerController.asset(
                  'assets/video_3.mp4',
                ),
                looping: false,
                autoplay: false,
              ),
              VideoItems(
                videoPlayerController: VideoPlayerController.asset(
                  'assets/video_2.mp4',
                ),
                autoplay: true,
              ),
              VideoItems(
                videoPlayerController: VideoPlayerController.network(
                    "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4"),
                looping: true,
                autoplay: false,
              ),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () {
                print('Pressed! ' + isAuthenticated.toString());
                //Navigate to profile dashboard or signupPage
                (isAuthenticated)
                    ? Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ProfilePage()))
                    : Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => AuthPage()));
              },
              child: CircleAvatar(
                backgroundColor: Colors.redAccent,
              ),
            ),
          )
        ],
      ),
    );
  }
}
