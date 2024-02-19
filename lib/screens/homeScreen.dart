import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haveaseat/screens/station_search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List line = [1, 2, 3, 4, 5];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              width: 343.w,
              height: 48.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 287.w,
                    color: Colors.grey,
                  ),
                  FloatingActionButton.extended(
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
                                            width: 1, color: Colors.grey),
                                      ),
                                    ),
                                    height: 78.h,
                                    child: CupertinoActionSheetAction(
                                      child: Text(
                                        '${line[idx]}호선',
                                        style: TextStyle(
                                          fontSize: 14.h,
                                          fontFamily: "R.font.pretendard",
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFF333333),
                                        ),
                                      ),
                                      onPressed: () async {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                StationSearchScreen(
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
                              color: const Color(0xFF616970),
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
                                  // close the options modal
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    label: const Text("호선 선택"),

                    icon: const Icon(
                      Icons.subway_rounded,
                      size: 30,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),

                    /// 텍스트 컬러
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                  )
                ],
              ),
            ),
            Container(
              width: 343.w,
              height: 554.h,
              // child:
              // NaverMap(
              //   options: NaverMapViewOptions(
              //     mapType: NMapType.basic,
              //     activeLayerGroups: [
              //       NLayerGroup.building,
              //       NLayerGroup.transit
              //     ],
              //   ),
              //   onMapReady: (controller) {
              //     print("네이버 맵 로딩됨!");
              //   },
              // ),
            )
          ],
        ),
      ),
    );
  }
}
