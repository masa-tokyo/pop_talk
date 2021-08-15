import 'package:flutter/material.dart';
import 'package:pop_talk/domain/model/talk_item.dart';
import 'package:pop_talk/presentation/ui/organisms/listening_tile.dart';

class ListeningTemplete extends StatefulWidget {
  const ListeningTemplete(
      {Key? key,
      required this.recommendLists,
      required this.followLists,
      required this.likeLists})
      : super(key: key);

  final List<TalkItem> recommendLists;
  final List<TalkItem> followLists;
  final List<TalkItem> likeLists;

  @override
  _ListeningTempleteState createState() => _ListeningTempleteState();
}

class _ListeningTempleteState extends State<ListeningTemplete> {
  double _currentValue = 45;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Column(
        children: [
          TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.deepOrangeAccent,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.deepOrangeAccent,
              border: Border.all(color: Colors.deepOrangeAccent),
            ),
            onTap: (index) {
              setState(() {});
            },
            tabs: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Tab(
                  text: 'おすすめ',
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Tab(
                  text: 'フォロー中',
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Tab(
                  text: 'いいね',
                ),
              ),
            ],
          ),
          Expanded(
              child: TabBarView(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 3, color: Colors.deepOrangeAccent),
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 12),
                            child: Container(
                              height: height * 0.25,
                              width: width * 0.75,
                              decoration: BoxDecoration(
                                color: Colors.blue[50],
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                              ),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.orange),
                                                shape: BoxShape.circle,
                                                image: const DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: NetworkImage(
                                                        'https://picsum.photos/250?image=9'))),
                                          ),
                                          const Text('山田太郎',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Center(
                                    child: Text(
                                      '面白かったこと',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Center(
                              child: Text(
                            'ヒカルについて',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                          const SizedBox(
                            height: 10,
                          ),
                          const Center(
                              child: Text(
                            'テキストテキストテキスト',
                          )),
                          Slider(
                            value: _currentValue,
                            min: 0,
                            max: 100,
                            label: _currentValue.round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                _currentValue = value.roundToDouble();
                              });
                            },
                            activeColor: Colors.deepOrangeAccent,
                            inactiveColor: Colors.grey[300],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.arrow_back_ios,
                                      size: 50,
                                      color: Colors.deepOrangeAccent,
                                    )),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.play_circle_fill_outlined,
                                      size: 50,
                                      color: Colors.deepOrangeAccent,
                                    )),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 50,
                                      color: Colors.deepOrangeAccent,
                                    )),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                OutlinedButton.icon(
                                  onPressed: () {},
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                        width: 1, color: Colors.black),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    primary: Colors.black,
                                  ),
                                  label: const Text('フォロー'),
                                  icon: const Icon(
                                    Icons.person_add,
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: OutlinedButton.icon(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                            width: 1, color: Colors.black),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        primary: Colors.black),
                                    label: const Text('いいね'),
                                    icon: const Icon(
                                      Icons.favorite,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Column(
                    children: [
                      const Divider(
                        color: Colors.black26,
                        thickness: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.orange),
                                  shape: BoxShape.circle,
                                  image: const DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          'https://picsum.photos/250?image=9'))),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  const Text('山田太郎',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      )),
                                  const Icon(
                                    Icons.clear_outlined,
                                    color: Color(0xFFBDBDBD),
                                    size: 10,
                                  ),
                                  const Text('人生で一番恥ずかしかったこと',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.pause,
                                      size: 25,
                                      color: Color(0xFFBDBDBD),
                                    )),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.favorite,
                                      size: 25,
                                      color: Color(0xFFBDBDBD),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.followLists.length,
                itemBuilder: (BuildContext context, int i) {
                  return Padding(
                    padding: const EdgeInsets.all(15),
                    child: ListeningTile(
                      talkItem: widget.followLists[i],
                    ),
                  );
                },
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.likeLists.length,
                itemBuilder: (BuildContext context, int i) {
                  return Padding(
                    padding: const EdgeInsets.all(15),
                    child: ListeningTile(
                      talkItem: widget.likeLists[i],
                    ),
                  );
                },
              ),
            ],
          ))
        ],
      ),
    );
  }
}
