import 'dart:html';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gradientbazaar/data/gradients_data.dart';
import 'package:gradientbazaar/model/gradient.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<GradientModel> gradients = new List<GradientModel>();

  String personalUrl = "https://www.linkedin.com/in/lamsanskar/";
  String twitterUrl = "https://twitter.com/intent/tweet?url=https%3A%2F%2Fgradientbazzar.firebaseapp.com%2F&text=Hey%20guys%20check%20out%20this%20awesome%20gradients%20for%20your%20next%20project%20on%20";
  String linkedInUrl = "https://www.linkedin.com/shareArticle?mini=true&url=https://gradientbazzar.firebaseapp.com/&summary=Hey%20guys%20check%20out%20this%20awesome%20%23gradients%20for%20your%20next%20project%20on%20";
  String facebookUrl = "https://www.facebook.com/sharer/sharer.php?u=https://gradientbazzar.firebaseapp.com/";

  var randomNum = 0;
  Color headingColor;
  Color textColor;

  _launchURL(String url) async {
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      gradients = getGradients();
    });

    gradients.shuffle();

    var randomizer = new Random();
    randomNum = randomizer.nextInt(gradients.length);
    headingColor = gradients[randomNum].getBottomColor().computeLuminance() > 0.5 ?
    Colors.black54 : Colors.white;
    textColor = gradients[randomNum].getBottomColor().computeLuminance() > 0.5 ?
    Colors.black54 : Colors.white70;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                          gradients[randomNum].getTopColor(),
                          gradients[randomNum].getBottomColor()
                        ],
                            begin: FractionalOffset.topRight,
                            end: FractionalOffset.bottomLeft)),
                    child: Column(
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Gradient Bazaar",
                              style: TextStyle(fontSize: 25, color:
                              headingColor),
                            ),
                            SizedBox(width: 5,),
                            Container(
                              padding: EdgeInsets.only(bottom: 3),
                              child: Text(
                                ".web.app",
                                style: TextStyle(fontSize: 14,
                                    color: headingColor),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        /// Made By
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Made with",
                              style: TextStyle(
                                fontSize: 13,
                                color: textColor,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Image.asset(
                              "assets/heart.png",
                              width: 20,
                              height: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "By",
                              style: TextStyle(
                                fontSize: 13,
                                color: textColor,
                              ),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            GestureDetector(
                              onTap: () {
                                _launchURL(personalUrl);
                              },
                              child: Text(
                                "Sanskar Tiwari",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: textColor,
                                    decoration: TextDecoration.underline),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                        /// Share
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){

                              },
                              child: Text(
                                "Liked our tool share",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: textColor,
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            GestureDetector(
                              onTap: (){
                                _launchURL(twitterUrl);
                              },
                              child: Text(
                                "Twitter",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: textColor,
                                    decoration: TextDecoration.underline
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            GestureDetector(
                              onTap: (){
                                _launchURL(linkedInUrl);
                              },
                              child: Text(
                                "LinkedIn",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: textColor,
                                    decoration: TextDecoration.underline
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            GestureDetector(
                              onTap: (){
                                _launchURL(facebookUrl);
                              },
                              child: Text(
                                "Facebook",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: textColor,
                                    decoration: TextDecoration.underline
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                    child: GridView(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          mainAxisSpacing: 0.0, maxCrossAxisExtent: 230.0),
                      children: List.generate(gradients.length, (index) {
                        return GradientCard(
                          topColor: gradients[index].getTopColor(),
                          bottomColor: gradients[index].getBottomColor(),
                          topColorCode: gradients[index].getTopColorCode(),
                          bottomColorCode:
                              gradients[index].getBottomColorCode(),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class GradientCard extends StatelessWidget {
  final Color topColor;
  final Color bottomColor;
  final String topColorCode;
  final String bottomColorCode;

  GradientCard(
      {this.topColor,
      this.bottomColor,
      this.topColorCode,
      this.bottomColorCode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  height: 160,
                  width: 180,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [topColor, bottomColor],
                          begin: FractionalOffset.topLeft,
                          end: FractionalOffset.bottomRight)),
                ),
                Container(
                  width: 180,
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.white30, Colors.white],
                          begin: FractionalOffset.centerRight,
                          end: FractionalOffset.centerLeft)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            _copyToClipboardHack(topColorCode);
                            final snackBar = SnackBar(
                              content:
                                  Text('$topColorCode Copied to Clipboard'),
                              duration: const Duration(seconds: 1),
                            );
                            // Find the Scaffold in the widget tree and use it to show a SnackBar.
                            Scaffold.of(context).showSnackBar(snackBar);
                          },
                          child: Text(
                            topColorCode,
                            style:
                                TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _copyToClipboardHack(bottomColorCode);
                            final snackBar = SnackBar(
                                content: Text(
                                    '$bottomColorCode Copied to Clipboard'),
                              duration: const Duration(seconds: 1),);
                            // Find the Scaffold in the widget tree and use it to show a SnackBar.
                            Scaffold.of(context).showSnackBar(snackBar);
                          },
                          child: Text(
                            bottomColorCode,
                            style: TextStyle(fontSize: 16, color: bottomColor),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

bool _copyToClipboardHack(String text) {
  final textarea = new TextAreaElement();
  document.body.append(textarea);
  textarea.style.border = '0';
  textarea.style.margin = '0';
  textarea.style.padding = '0';
  textarea.style.opacity = '0';
  textarea.style.position = 'absolute';
  textarea.readOnly = true;
  textarea.value = text;
  textarea.select();
  final result = document.execCommand('copy');
  textarea.remove();
  return result;
}
