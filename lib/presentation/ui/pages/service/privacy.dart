import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pop_talk/presentation/ui/atoms/poptalk_logo.dart';
import 'package:pop_talk/presentation/ui/molecules/list_with_number.dart';
import 'package:pop_talk/presentation/ui/templates/simple_scaffold.dart';

class ServicePrivacyPage extends StatelessWidget {
  static const routeName = '/service/privacy';

  @override
  Widget build(BuildContext context) {
    return SimpleScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 1 / 2 + 75,
            padding: const EdgeInsets.only(top: 40, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.close,
                    size: 30,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    const PopTalkLogo(),
                    const SizedBox(width: 8),
                    Text(
                      'PopTalk',
                      style: GoogleFonts.mPlusRounded1c(
                        letterSpacing: 0.5,
                        textStyle: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF804B3A),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                alignment: Alignment.topCenter,
                child: Container(
                  constraints: const BoxConstraints(
                    minWidth: 500,
                    maxWidth: 1000,
                  ),
                  child: Card(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Title(title: '??????????????????????????????'),
                          SizedBox(height: 10),
                          Content(
                              content:
                                  '''PopTalk???????????????????????????????????????????????????????????????????????????????????????????????????PopTalk????????????,???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????'''),
                          SizedBox(height: 30),
                          Title(title: '???1?????????????????????'),
                          SizedBox(height: 10),
                          Content(
                              content:
                                  '''??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????'''),
                          SizedBox(height: 30),
                          Title(title: '???2????????????????????????????????????'),
                          SizedBox(height: 10),
                          Content(
                              content:
                                  '''????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????,??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????'''),
                          SizedBox(height: 30),
                          Title(title: '???3???????????????????????????????????????????????????'),
                          SizedBox(height: 10),
                          Content(content: '???????????????????????????????????????????????????????????????????????????????????????'),
                          ListWithNumber(
                            children: <Widget>[
                              Content(content: '????????????????????????????????????????????????'),
                              Content(
                                  content:
                                      '''??????????????????????????????????????????????????????????????????????????????????????????????????????'''),
                              Content(
                                  content:
                                      '''????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????'''),
                              Content(content: '????????????????????????????????????????????????????????????????????????????????????'),
                              Content(
                                  content:
                                      '''??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????'''),
                              Content(
                                  content:
                                      '???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????'),
                              Content(
                                  content: '''?????????????????????????????????????????????????????????????????????????????????'''),
                              Content(
                                  content:
                                      '''???????????????????????????????????????????????????(??????)??????????????????????????????'''),
                              Content(content: '??????????????????????????????????????????'),
                            ],
                          ),
                          SizedBox(height: 30),
                          Title(title: '???4??????????????????????????????'),
                          SizedBox(height: 10),
                          ListWithNumber(
                            children: <Widget>[
                              Content(
                                  content:
                                      '''??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????'''),
                              Content(
                                  content:
                                      '''?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????'''),
                            ],
                          ),
                          SizedBox(height: 30),
                          Title(title: '???5???????????????????????????????????????'),
                          SizedBox(height: 10),
                          ListWithNumber(
                            children: <Widget>[
                              Content(
                                  content:
                                      '''??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????'''),
                              ListWithNumber(
                                children: <Widget>[
                                  Content(
                                      content:
                                          '''???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????'''),
                                  Content(
                                      content:
                                          '''???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????'''),
                                  Content(
                                      content:
                                          '''???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????'''),
                                  Content(
                                      content:
                                          '''????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????'''),
                                  ListWithNumber(
                                    children: <Widget>[
                                      Content(content: '???????????????????????????????????????????????????'),
                                      Content(content: '?????????????????????????????????????????????'),
                                      Content(content: '?????????????????????????????????????????????'),
                                      Content(
                                          content:
                                              '''????????????????????????????????????????????????????????????????????????????????????'''),
                                      Content(content: '???????????????????????????????????????'),
                                    ],
                                  ),
                                ],
                              ),
                              Content(
                                  content:
                                      '''?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????'''),
                              ListWithNumber(
                                children: <Widget>[
                                  Content(
                                      content:
                                          '''???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????'''),
                                  Content(
                                      content:
                                          '''????????????????????????????????????????????????????????????????????????????????????????????????'''),
                                  Content(
                                      content:
                                          '''?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????'''),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 30),
                          Title(title: '???6??????????????????????????????'),
                          SizedBox(height: 10),
                          ListWithNumber(
                            children: <Widget>[
                              Content(
                                  content:
                                      '''?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????1????????????1,000???????????????????????????????????????'''),
                              ListWithNumber(
                                children: <Widget>[
                                  Content(
                                      content:
                                          '???????????????????????????????????????????????????????????????????????????????????????????????????????????????'),
                                  Content(
                                      content:
                                          '''??????????????????????????????????????????????????????????????????????????????????????????'''),
                                  Content(content: '???????????????????????????????????????????????????'),
                                ],
                              ),
                              Content(
                                  content:
                                      '''?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????'''),
                            ],
                          ),
                          SizedBox(height: 30),
                          Title(title: '???7?????????????????????????????????????????????'),
                          SizedBox(height: 10),
                          ListWithNumber(
                            children: <Widget>[
                              Content(
                                  content:
                                      '''????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????'''),
                              Content(
                                  content:
                                      '''????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????'''),
                              Content(
                                  content:
                                      '''????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????'''),
                            ],
                          ),
                          SizedBox(height: 30),
                          Title(title: '???8???????????????????????????????????????'),
                          SizedBox(height: 10),
                          ListWithNumber(
                            children: <Widget>[
                              Content(
                                  content:
                                      '''?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????'''),
                              Content(
                                  content:
                                      '''??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????'''),
                              Content(
                                  content:
                                      '''???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????'''),
                              Content(
                                  content:
                                      '''???2?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????'''),
                            ],
                          ),
                          SizedBox(height: 30),
                          Title(title: '???9????????????????????????????????????????????????'),
                          SizedBox(height: 10),
                          ListWithNumber(
                            children: <Widget>[
                              Content(
                                  content:
                                      '''?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????'''),
                              Content(
                                  content:
                                      '''???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????'''),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class Content extends StatelessWidget {
  const Content({
    required this.content,
  });

  final String content;

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: const TextStyle(fontSize: 16),
    );
  }
}
