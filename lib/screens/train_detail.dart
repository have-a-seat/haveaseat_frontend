import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haveaseat/models/TrainSeat_model.dart';
import 'dart:developer' as dev;
import 'package:http/http.dart' as http;

import '../utils/utils.dart';

class TrainDetail extends StatefulWidget {
  final String station;
  final String trainId;
  final String line_id;
  TrainDetail(
      {super.key,
      required this.line_id,
      required this.trainId,
      required this.station});

  @override
  State<TrainDetail> createState() => _TrainDetailState();
}

class _TrainDetailState extends State<TrainDetail> {
  Future getTrains() async {
    final String lineId = widget.line_id;
    final String trainId = widget.trainId;
    dev.log(lineId);
    dev.log(trainId);
    final Uri uri = Uri.parse(
        'https://trainseatoccupancystatusv2-2t65ehgdja-du.a.run.app/?lineId=$lineId&trainId=$trainId');

    final response = await http.get(
      uri,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return TrainSeat.fromJson(data).data;
    } else {
      showSnackBar("서버 응답에 오류가 있습니다", context);
      return null;
    }
  }

  List b = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: const Color.fromARGB(255, 181, 61, 101),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Padding(
          padding: const EdgeInsets.only(right: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/logo.png",
                height: 30.h,
              ),
              Text(
                "Train Details : ${widget.station}",
                style: TextStyle(
                  fontSize: 20.h,
                  fontFamily: "R.font.pretendard",
                  fontWeight: FontWeight.w700,
                  color: const Color.fromARGB(255, 181, 61, 101),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 15.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.chair_outlined,
                        color: Colors.blueAccent,
                        size: 30.h,
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Text(
                        "Vulnerable Seat\n     (available)",
                        style: TextStyle(
                          fontSize: 15.h,
                          fontFamily: "R.font.pretendard",
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.chair_outlined,
                        color: Colors.grey,
                        size: 30.h,
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Text(
                        "Normal Seat\n  (available)",
                        style: TextStyle(
                          fontSize: 15.h,
                          fontFamily: "R.font.pretendard",
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.chair_outlined,
                        color: const Color.fromARGB(155, 173, 35, 81),
                        size: 30.h,
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Text(
                        "Pregnancy Seat\n     (available)",
                        style: TextStyle(
                          fontSize: 15.h,
                          fontFamily: "R.font.pretendard",
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            SizedBox(
              width: 210.w,
              height: MediaQuery.sizeOf(context).height - 150.h,
              child: FutureBuilder(
                future: getTrains(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: SizedBox(
                        height: 45,
                        width: 45,
                        child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 181, 61, 101),
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '서버 응답에 오류가 있습니다',
                        style: TextStyle(fontSize: 15),
                      ),
                    );
                  } else {
                    if (snapshot.data != null) {
                      List a = snapshot.data.train;
                      return ListView.builder(
                        itemCount: a.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Text(
                                '${a[index].name}번째 칸',
                                style: TextStyle(
                                  fontSize: 25.h,
                                  fontFamily: "R.font.pretendard",
                                  fontWeight: FontWeight.w700,
                                  color:
                                      const Color.fromARGB(255, 181, 61, 101),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 40.h),
                                padding: EdgeInsets.only(
                                  top: 15.h,
                                  bottom: 15.h,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 2),
                                  borderRadius: BorderRadius.circular(16),
                                  color:
                                      const Color.fromARGB(104, 251, 249, 239),
                                ),
                                width: max(110.w, 100),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: 27,
                                  itemBuilder: (context, idx) {
                                    var seatMap = a[index].seat;

                                    List<bool> pregnancySeat_a =
                                        List<bool>.filled(
                                            seatMap.a.length, false);

                                    for (int index
                                        in a[index].pregnancySeat.a) {
                                      pregnancySeat_a[index] = true;
                                    }

                                    List<bool> pregnancySeat_b =
                                        List<bool>.filled(
                                            seatMap.b.length, false);

                                    for (int index
                                        in a[index].pregnancySeat.b) {
                                      pregnancySeat_b[index] = true;
                                    }

                                    List<bool> vulnerableSeat_a =
                                        List<bool>.filled(
                                            seatMap.a.length, false);

                                    for (int index
                                        in a[index].vulnerableSeat.a) {
                                      vulnerableSeat_a[index] = true;
                                    }

                                    List<bool> vulnerableSeat_b =
                                        List<bool>.filled(
                                            seatMap.b.length, false);

                                    for (int index
                                        in a[index].vulnerableSeat.b) {
                                      vulnerableSeat_b[index] = true;
                                    }
                                    return Container(
                                      margin: EdgeInsets.only(bottom: 5.h),
                                      padding: const EdgeInsets.all(8),
                                      width: 190.w,
                                      height: 30.h,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            seatMap!.a[idx] == 1
                                                ? Icons.chair_rounded
                                                : Icons.chair_outlined,
                                            color: pregnancySeat_a[idx]
                                                ? const Color.fromARGB(
                                                    155, 173, 35, 81)
                                                : vulnerableSeat_a[idx]
                                                    ? Colors.blueAccent
                                                    : Colors.grey,
                                            size: 30.h,
                                          ),
                                          Icon(
                                            seatMap!.b[idx] == 1
                                                ? Icons.chair_rounded
                                                : Icons.chair_outlined,
                                            color: pregnancySeat_b[idx]
                                                ? const Color.fromARGB(
                                                    155, 173, 35, 81)
                                                : vulnerableSeat_b[idx]
                                                    ? Colors.blueAccent
                                                    : Colors.grey,
                                            size: 30.h,
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          );
                        },
                      );
                    } else {
                      return Text(
                        "역 정보가 없습니다 (NO DATA)",
                        style: TextStyle(
                          fontSize: 40.h,
                          fontFamily: "R.font.pretendard",
                          fontWeight: FontWeight.w700,
                          color: const Color.fromARGB(145, 0, 0, 0),
                        ),
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
