import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:my_movies/home_screen.dart';
import 'package:my_movies/my_provider.dart';
import 'package:provider/provider.dart';

class MyIntroductionScreen extends StatefulWidget {
  const MyIntroductionScreen({super.key});

  @override
  State<MyIntroductionScreen> createState() => _MyIntroductionScreenState();
}

class _MyIntroductionScreenState extends State<MyIntroductionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
              title: "Welcome!",
              body: "This app let's you save all the movies you watch",
              image: CircleAvatar(
                backgroundColor: Colors.black,
                radius: 100,
                child: Icon(
                  Icons.movie,
                  size: 100,
                ),
              )),
          PageViewModel(
              title: "Firstly",
              body: "You can add movies to your list from here",
              image: Container(
                width: 180,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 5)),
                child: Image.asset(
                  'images/1.png',
                  height: 200,
                  width: 200,
                ),
              )),
          PageViewModel(
              title: "Next",
              body:
                  "Enter the name of the movie you want and it's director, then add the poster picture, then click Add Movie",
              image: Container(
                width: 178,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 5)),
                child: Image.asset(
                  'images/2.png',
                  height: 200,
                  width: 200,
                ),
              )),
          PageViewModel(
              title: "Next",
              body: "Click here to add the movie to your list",
              image: Container(
                width: 196,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 5)),
                child: Image.asset(
                  'images/5.png',
                  height: 200,
                  width: 200,
                ),
              )),

              PageViewModel(
              title: "Done",
              body: "You can also delete the movie by sliding it",
              image: Container(
           
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 5)),
                child: Image.asset(
                  'images/8.png',
                  height: 200,
                  width: 200,
                ),
              )),
              
        ],
        showSkipButton: true,
        showNextButton: true,
        next: const Text("Next"),
        skip: const Text("Skip"),
        done: const Text("Done"),
        onDone: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => ChangeNotifierProvider(
                  create: (context) => MyProvider(),
                  child: HomeScreen(),
                ),
              ));
        },
      ),
    );
  }
}
