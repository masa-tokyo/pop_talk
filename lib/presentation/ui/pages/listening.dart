import 'package:flutter/material.dart';

class ListeningPage extends StatelessWidget {
  static const routeName = '/listening';

  @override
  Widget build(BuildContext context) {
    double _currentValue = 45.0;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  primary: Colors.deepOrangeAccent,
                  shape: const StadiumBorder(),
                  side: const BorderSide(color: Colors.deepOrangeAccent),
                ),
                onPressed: () {},
                child: const Text('おすすめ'),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  primary: Colors.deepOrangeAccent,
                  shape: const StadiumBorder(),
                  side: const BorderSide(color: Colors.deepOrangeAccent),
                ),
                onPressed: () {},
                child: const Text('フォロー中'),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  primary: Colors.deepOrangeAccent,
                  shape: const StadiumBorder(),
                  side: const BorderSide(color: Colors.orange),
                ),
                onPressed: () {},
                child: const Text('いいね'),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.65,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: const Border(
              left: BorderSide(
                color: Colors.deepOrangeAccent,
                width: 3,
              ),
              top: BorderSide(
                color: Colors.deepOrangeAccent,
                width: 3,
              ),
              right: BorderSide(
                color: Colors.deepOrangeAccent,
                width: 3,
              ),
              bottom: BorderSide(
                color: Colors.deepOrangeAccent,
                width: 3,
              ),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.orange),
                              shape: BoxShape.circle,
                              image: const DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      'https://picsum.photos/250?image=9'))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('山田太郎'),
                      ],
                    ),
                    const Icon(
                      Icons.clear_outlined,
                      color: Color(0xFFBDBDBD),
                      size: 50,
                    ),
                    Column(
                      children: [
                        const Text(
                          '最近お気に入りの',
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        const Text(
                          'Youtuber',
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              const Center(child: Text('ヒカルについて')),
              const SizedBox(
                height: 20,
              ),
              Slider(
                value: _currentValue,
                min: 0,
                max: 100,
                onChanged: (value) {},
                activeColor: Colors.deepOrangeAccent,
                inactiveColor: Colors.grey[300],
              ),
              SizedBox(
                height: 45,
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
                          Icons.stop_circle_outlined,
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
              SizedBox(
                height: 65,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton.icon(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      primary: Colors.black,
                    ),
                    label: Text('フォロー'),
                    icon: const Icon(
                      Icons.person_add,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  OutlinedButton.icon(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        primary: Colors.black),
                    label: Text('いいね'),
                    icon: const Icon(
                      Icons.favorite,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
