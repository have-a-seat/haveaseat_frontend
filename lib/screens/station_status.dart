import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import '../models/AllStations_model.dart';
import '../utils/utils.dart';
import '../models/StationStatus_model.dart' as ss;
import 'dart:developer' as dev;

import 'train_detail.dart';

class StationStatus extends StatefulWidget {
  Data station;
  String lineId;
  StationStatus({super.key, required this.station, required this.lineId});

  @override
  State<StationStatus> createState() => _StationStatusState();
}

class _StationStatusState extends State<StationStatus> {
  // 역 id를 파라미터로 하여 받아올 예정

  var nameToId = {
    '1호선': '1001',
    '2호선': '1002',
    '3호선': '1003',
    '4호선': '1004',
    '5호선': '1005',
    '6호선': '1006',
    '7호선': '1007',
    '8호선': '1008',
    '9호선': '1009',
    '우이신설경전철': '1092',
    '경춘선': '1067',
    '경의·중앙선': '1063',
    '수인분당선': '1075',
    '신분당선': '1077',
    '공항철도': '1065',
    "경강선": "1081",
    "서해선": "1093",
    // 아래는 실시간 정보를 요청할 수 없는 호선, 역 조회는 되는데?
    "신림선": "-2",
    "용인경전철": "-2",
    "인천1호선": "-2",
    "인천2호선": "-2",
    "김포골드라인": "-2",
  };

  getStationsState() async {
    var startIndex = 1;
    var endIndex = 5;
    var statnNm = widget.station.name.toString();

    final String lineId = nameToId[
        Id2Name([widget.lineId]).toString().replaceAll(RegExp(r'\(|\)'), '')]!;
    final String stationName = statnNm;
    if (nameToId[Id2Name([widget.lineId])
            .toString()
            .replaceAll(RegExp(r'\(|\)'), '')]! ==
        "-2") {
      showSnackBar("해당역은 정보를 제공하지 않습니다", context);
      return null;
    } else {
      final Uri uri = Uri.parse(
          'https://realtimearrivals-2t65ehgdja-du.a.run.app/?lineId=$lineId&stationName=$stationName');

      final response = await http.get(
        uri,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // subwayId 로 한번 걸러서 보내주기
        dev.log(response.body.toString());
        print(response.body.toString());
        return ss.StationStatus.fromJson(data);
      } else {
        showSnackBar("서버 응답에 오류가 있습니다", context);
        return null;
      }
    }
  }

  late Future getStationsStateOnce;

  void initState() {
    getStationsStateOnce = getStationsState();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 45.h,
        child: FloatingActionButton.extended(
          onPressed: () {
            setState(() {
              getStationsStateOnce = getStationsState();
            });
          },
          label: Text(
            "Refresh",
            style: TextStyle(
              fontSize: 15.h,
              fontFamily: "R.font.pretendard",
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),

          icon: Icon(
            Icons.refresh_rounded,
            size: 25.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),

          /// 텍스트 컬러
          foregroundColor: Colors.white,
          backgroundColor: const Color.fromARGB(255, 181, 61, 101),
        ),
      ),
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
                "Station Status : ${widget.station.name}",
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
      body: SingleChildScrollView(
        child: Center(
            child: SizedBox(
          width: 343.w,
          height: MediaQuery.sizeOf(context).height,
          child: FutureBuilder(
            future: getStationsStateOnce,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                if (snapshot.data.data != null) {
                  List<dynamic>? a = [];
                  List<dynamic> b = [];

                  snapshot.data.data.forEach(
                    (element) {
                      if ((element.updnLine == '상행' ||
                              element.updnLine == '내선') &&
                          element.subwayId ==
                              nameToId[Id2Name([widget.lineId])
                                  .toString()
                                  .replaceAll(RegExp(r'\(|\)'), '')]) {
                        a.add(element);
                      } else if ((element.updnLine == '하행' ||
                              element.updnLine == '외선') &&
                          element.subwayId ==
                              nameToId[Id2Name([widget.lineId])
                                  .toString()
                                  .replaceAll(RegExp(r'\(|\)'), '')]) {
                        b.add(element);
                      }
                    },
                  );

                  return Column(
                    children: [
                      // updnLine 로 상/하행선 구분
                      a.isNotEmpty
                          ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.all(8),
                              width: MediaQuery.sizeOf(context).width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    '${a.first.updnLine} 열차 현황',
                                    style: TextStyle(
                                      fontSize: 25.h,
                                      fontFamily: "R.font.pretendard",
                                      fontWeight: FontWeight.w700,
                                      color: const Color.fromARGB(
                                          255, 173, 35, 81),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 50.h),
                                    alignment: Alignment.centerRight,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        width: 2,
                                        color: const Color.fromARGB(
                                            155, 173, 35, 81),
                                      ),
                                    ),
                                    height: 220.h,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: a.length + 1,
                                      itemBuilder: (context, index) {
                                        return a.length != index
                                            ? GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          TrainDetail(
                                                        station: widget
                                                            .station.name
                                                            .toString(),
                                                        trainId: a[a.length -
                                                                index -
                                                                1]
                                                            .btrainNo
                                                            .toString(),
                                                        line_id: a[a.length -
                                                                index -
                                                                1]
                                                            .subwayId
                                                            .toString(),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                        left: 3.w,
                                                      ),
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                10, 2, 10, 2),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                            width: 2,
                                                            color: const Color
                                                                .fromARGB(143,
                                                                173, 35, 81),
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16),
                                                        ),
                                                        child: Text(
                                                          truncateString(
                                                              a[a.length -
                                                                      index -
                                                                      1]
                                                                  .arvlMsg3
                                                                  .replaceAll(
                                                                      RegExp(
                                                                          r'\(|\)'),
                                                                      ''),
                                                              8),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 14.h,
                                                            fontFamily:
                                                                "R.font.pretendard",
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: const Color
                                                                .fromARGB(
                                                                145, 0, 0, 0),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: widget
                                                                  .station.name
                                                                  .toString() !=
                                                              a[a.length -
                                                                      index -
                                                                      1]
                                                                  .arvlMsg3
                                                                  .replaceAll(
                                                                      RegExp(
                                                                          r'\(|\)'),
                                                                      '')
                                                          ? EdgeInsets.only(
                                                              right: 25.w)
                                                          : EdgeInsets.all(0),
                                                      height: 100.h,
                                                      width: 150.h,
                                                      child: Image.asset(
                                                        "assets/images/subway.png",
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 2.w),
                                                      child: Text(
                                                        "=> ${a[a.length - index - 1].arvlMsg2.replaceAll(RegExp(r'\[|\]'), '')}",
                                                        style: TextStyle(
                                                          fontSize: 14.h,
                                                          fontFamily:
                                                              "R.font.pretendard",
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: const Color
                                                              .fromARGB(
                                                              145, 0, 0, 0),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(
                                                margin: EdgeInsets.only(
                                                    right: 15.w),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 20.h),
                                                      height: 80.h,
                                                      width: 160.h,
                                                      child: Image.asset(
                                                        "assets/images/boarding_station.png",
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(
                        height: 14.h,
                      ),
                      b.isNotEmpty
                          ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.all(8),
                              width: MediaQuery.sizeOf(context).width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    '${b.first.updnLine} 열차 현황',
                                    style: TextStyle(
                                      fontSize: 25.h,
                                      fontFamily: "R.font.pretendard",
                                      fontWeight: FontWeight.w700,
                                      color: const Color.fromARGB(
                                          255, 173, 35, 81),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 50.h),
                                    alignment: Alignment.centerRight,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        width: 2,
                                        color: Color.fromARGB(155, 173, 35, 81),
                                      ),
                                    ),
                                    height: 220.h,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: b.length + 1,
                                      itemBuilder: (context, index) {
                                        return b.length != index
                                            ? GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          TrainDetail(
                                                        station: widget
                                                            .station.name
                                                            .toString(),
                                                        trainId: b[b.length -
                                                                index -
                                                                1]
                                                            .btrainNo
                                                            .toString(),
                                                        line_id: b[b.length -
                                                                index -
                                                                1]
                                                            .subwayId
                                                            .toString(),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                        left: 3.w,
                                                      ),
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                10, 2, 10, 2),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                            width: 2,
                                                            color: const Color
                                                                .fromARGB(143,
                                                                173, 35, 81),
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16),
                                                        ),
                                                        child: Text(
                                                          truncateString(
                                                              b[b.length -
                                                                      index -
                                                                      1]
                                                                  .arvlMsg3
                                                                  .replaceAll(
                                                                      RegExp(
                                                                          r'\(|\)'),
                                                                      ''),
                                                              8),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 14.h,
                                                            fontFamily:
                                                                "R.font.pretendard",
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: const Color
                                                                .fromARGB(
                                                                145, 0, 0, 0),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: widget
                                                                  .station.name
                                                                  .toString() !=
                                                              b[b.length -
                                                                      index -
                                                                      1]
                                                                  .arvlMsg3
                                                                  .replaceAll(
                                                                      RegExp(
                                                                          r'\(|\)'),
                                                                      '')
                                                          ? EdgeInsets.only(
                                                              right: 25.w)
                                                          : EdgeInsets.all(0),
                                                      height: 100.h,
                                                      width: 150.h,
                                                      child: Image.asset(
                                                        "assets/images/subway.png",
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 2.w),
                                                      child: Text(
                                                        "=> ${b[b.length - index - 1].arvlMsg2.replaceAll(RegExp(r'\[|\]'), '')}",
                                                        style: TextStyle(
                                                          fontSize: 14.h,
                                                          fontFamily:
                                                              "R.font.pretendard",
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: const Color
                                                              .fromARGB(
                                                              145, 0, 0, 0),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(
                                                margin: EdgeInsets.only(
                                                    right: 15.w),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 20.h),
                                                      height: 80.h,
                                                      width: 160.h,
                                                      child: Image.asset(
                                                        "assets/images/boarding_station.png",
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ],
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
        )),
      ),
    );
  }
}
