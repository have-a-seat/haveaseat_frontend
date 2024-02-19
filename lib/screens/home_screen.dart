import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haveaseat/screens/station_search.dart';

import '../utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List line = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "A",
    "B",
    "E",
    "G",
    "I",
    "I2",
    "K",
    "KK",
    "KP",
    "S",
    "SH",
    "SL",
    "U",
    "W"
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/images/title.png",
          height: 80.h,
        ),
        toolbarHeight: 80.h,
      ),
      floatingActionButton: SizedBox(
        height: 45.h,
        child: FloatingActionButton.extended(
          onPressed: () {
            showCupertinoModalPopup(
              context: context,
              builder: (context) => CupertinoActionSheet(
                actions: [
                  SizedBox(
                    width: 343.w,
                    height: 350.h,
                    child: ListView.builder(
                      itemCount: line.length,
                      itemBuilder: (BuildContext ctx, int idx) {
                        return Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: Color.fromARGB(129, 158, 158, 158),
                              ),
                            ),
                          ),
                          height: 78.h,
                          child: CupertinoActionSheetAction(
                            child: Text(
                              Id2Name([line[idx]])
                                  .toString()
                                  .replaceAll(RegExp(r'\(|\)'), ''),
                              style: TextStyle(
                                fontSize: 14.h,
                                fontFamily: "R.font.pretendard",
                                fontWeight: FontWeight.w600,
                                color: const Color.fromARGB(255, 204, 2, 69),
                              ),
                            ),
                            onPressed: () async {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => StationSearchScreen(
                                    lineId: line[idx].toString(),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    color: const Color.fromARGB(137, 124, 64, 84),
                    child: CupertinoActionSheetAction(
                      child: Text(
                        '취소',
                        style: TextStyle(
                            fontSize: 14.h,
                            fontFamily: "R.font.pretendard",
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      onPressed: () async {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            );
          },
          label: Text(
            "Lines",
            style: TextStyle(
              fontSize: 15.h,
              fontFamily: "R.font.pretendard",
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          icon: Icon(
            Icons.subway_rounded,
            size: 25.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          foregroundColor: Colors.white,
          backgroundColor: const Color.fromARGB(255, 181, 61, 101),
        ),
      ),
      body: Center(
        child: Stack(
          children: [
            Positioned(
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                child: Image.asset(
                  "assets/gifs/home.gif",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              child: Container(
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                color: const Color.fromARGB(117, 158, 158, 158),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 60.h,
                        child: Image.asset(
                          "assets/images/logo.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            "Which station are you boarding at?",
                            style: TextStyle(
                              letterSpacing: -1,
                              wordSpacing: -1,
                              fontSize: 38.h,
                              fontFamily: "R.font.pretendard",
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFF333333),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: SizedBox(
                      width: 343.w,
                      height: 55.h,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const StationSearchScreen(
                                lineId: "-1",
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(6.w, 0, 6.w, 0),
                          alignment: Alignment.centerRight,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 3,
                              color: const Color.fromARGB(255, 181, 61, 101),
                            ),
                            borderRadius: BorderRadius.circular(8),
                            color: const Color.fromARGB(79, 240, 220, 220),
                          ),
                          width: 287.w,
                          height: 50.h,
                          child: Icon(
                            Icons.search,
                            size: 35.h,
                            color: const Color.fromARGB(141, 181, 61, 101),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
