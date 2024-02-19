import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haveaseat/models/AllStations_model.dart';
import 'package:haveaseat/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'station_status.dart';

class StationSearchScreen extends StatefulWidget {
  final String lineId;
  const StationSearchScreen({super.key, required this.lineId});

  @override
  State<StationSearchScreen> createState() => _StationSearchScreenState();
}

class _StationSearchScreenState extends State<StationSearchScreen> {
  getStations() async {
    final url = Uri.parse('https://subwaystations-2t65ehgdja-du.a.run.app');
    final response = await http.get(
      url,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return widget.lineId == '-1'
          ? AllStations.fromJson(data)
              .data!
              .where((element) => element.name != null)
              .toList()
          : AllStations.fromJson(data)
              .data!
              .where((element) =>
                  element.lines!.contains(widget.lineId) &&
                  element.name != null)
              .toList();
    } else {
      showSnackBar("서버 응답에 오류가 있습니다", context);
      return null;
    }
  }

  late Future getStationOnce;
  String check = "";
  List filteredItems = [];

  @override
  void initState() {
    super.initState();
    getStationOnce = getStations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: const Color.fromARGB(255, 181, 61, 101),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Padding(
          padding: EdgeInsets.only(right: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/logo.png",
                height: 30.h,
              ),
              Text(
                "Station Search",
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
        child: SizedBox(
          width: 343.w,
          height: MediaQuery.sizeOf(context).height,
          child: FutureBuilder(
            future: getStationOnce,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(
                    child: SizedBox(
                  height: 45,
                  width: 45,
                  child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 181, 61, 101),
                  ),
                ));
              } else if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '서버 응답에 오류가 있습니다',
                    style: TextStyle(
                      fontSize: 20.h,
                      fontFamily: "R.font.pretendard",
                      fontWeight: FontWeight.w700,
                      color: const Color.fromARGB(255, 181, 61, 101),
                    ),
                  ),
                );
              } else {
                List info = snapshot.data;

                return Column(
                  children: [
                    SizedBox(
                      width: 343.w,
                      child: TextFormField(
                        style: TextStyle(
                          fontSize: 15.h,
                          fontFamily: "R.font.pretendard",
                          fontWeight: FontWeight.w700,
                          color: const Color.fromARGB(255, 173, 35, 81),
                        ),
                        cursorColor: const Color.fromARGB(255, 173, 35, 81),
                        decoration: InputDecoration(
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 173, 35, 81),
                            ),
                          ),
                          hintText: "eg) 고려대",
                          hintStyle: TextStyle(
                            fontSize: 15.h,
                            fontFamily: "R.font.pretendard",
                            fontWeight: FontWeight.w400,
                            color: const Color.fromARGB(100, 173, 35, 81),
                          ),
                          labelStyle: TextStyle(
                            fontSize: 15.h,
                            fontFamily: "R.font.pretendard",
                            fontWeight: FontWeight.w700,
                            color: const Color.fromARGB(255, 173, 35, 81),
                          ),
                          labelText: '탑승역 검색 (Input subway station name)',
                          contentPadding: const EdgeInsets.only(top: -3.0),
                        ),
                        onChanged: (text) {
                          setState(
                            () {
                              filteredItems = info
                                  .where(
                                    (item) => item.name.toLowerCase().contains(
                                          text.toLowerCase(),
                                        ),
                                  )
                                  .toList();
                              filteredItems.isEmpty ? check = "없음" : "";
                            },
                          );
                        },
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(
                              width: 343.w,
                              height: 668.h,
                              child: ListView.builder(
                                itemCount: filteredItems.isEmpty && check == ""
                                    ? info.length
                                    : filteredItems.length,
                                itemBuilder: (BuildContext ctx, int idx) {
                                  return GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      if (widget.lineId == "-1") {
                                        showCupertinoModalPopup(
                                          context: context,
                                          builder: (context) =>
                                              CupertinoActionSheet(
                                            actions: [
                                              SizedBox(
                                                width: 343.w,
                                                height: 350.h,
                                                child: ListView.builder(
                                                  itemCount: filteredItems
                                                              .isEmpty &&
                                                          check == ""
                                                      ? info[idx].lines.length
                                                      : filteredItems[idx]
                                                          .lines
                                                          .length,
                                                  itemBuilder:
                                                      (BuildContext ctx,
                                                          int num) {
                                                    return Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        border: Border(
                                                          bottom: BorderSide(
                                                            width: 1,
                                                            color:
                                                                Color.fromARGB(
                                                                    129,
                                                                    158,
                                                                    158,
                                                                    158),
                                                          ),
                                                        ),
                                                      ),
                                                      height: 78.h,
                                                      child:
                                                          CupertinoActionSheetAction(
                                                        child: Text(
                                                          Id2Name([
                                                            filteredItems
                                                                        .isEmpty &&
                                                                    check == ""
                                                                ? info[idx]
                                                                    .lines[num]
                                                                : filteredItems[
                                                                        idx]
                                                                    .lines[num]
                                                          ])
                                                              .toString()
                                                              .replaceAll(
                                                                  RegExp(
                                                                      r'\(|\)'),
                                                                  ''),
                                                          style: TextStyle(
                                                            fontSize: 14.h,
                                                            fontFamily:
                                                                "R.font.pretendard",
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: const Color
                                                                .fromARGB(255,
                                                                204, 2, 69),
                                                          ),
                                                        ),
                                                        onPressed: () async {
                                                          Navigator.of(context)
                                                              .push(
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  StationStatus(
                                                                station: filteredItems
                                                                            .isEmpty &&
                                                                        check ==
                                                                            ""
                                                                    ? info[idx]
                                                                    : filteredItems[
                                                                        idx],
                                                                lineId: filteredItems
                                                                            .isEmpty &&
                                                                        check ==
                                                                            ""
                                                                    ? info[idx]
                                                                        .lines[
                                                                            num]
                                                                        .toString()
                                                                    : filteredItems[
                                                                            idx]
                                                                        .lines[
                                                                            num]
                                                                        .toString(),
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
                                                color: const Color.fromARGB(
                                                    137, 124, 64, 84),
                                                child:
                                                    CupertinoActionSheetAction(
                                                  child: Text(
                                                    '취소',
                                                    style: TextStyle(
                                                        fontSize: 14.h,
                                                        fontFamily:
                                                            "R.font.pretendard",
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                      } else {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => StationStatus(
                                              station: filteredItems.isEmpty &&
                                                      check == ""
                                                  ? info[idx]
                                                  : filteredItems[idx],
                                              lineId: widget.lineId,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: SizedBox(
                                      width: 343.w,
                                      height: 49.h,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          filteredItems.isEmpty && check == ""
                                              ? Text(
                                                  info[idx].name.toString(),
                                                  style: TextStyle(
                                                      fontSize: 15.h,
                                                      fontFamily:
                                                          "R.font.pretendard",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black),
                                                )
                                              : Text(
                                                  filteredItems[idx]
                                                      .name
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 15.h,
                                                      fontFamily:
                                                          "R.font.pretendard",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black),
                                                ),
                                          filteredItems.isEmpty && check == ""
                                              ? Text(
                                                  Id2Name(info[idx].lines)
                                                      .join(', '),
                                                  style: TextStyle(
                                                      fontSize: 15.h,
                                                      fontFamily:
                                                          "R.font.pretendard",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black),
                                                )
                                              : Text(
                                                  Id2Name(filteredItems[idx]
                                                          .lines)
                                                      .join(', '),
                                                  style: TextStyle(
                                                      fontSize: 15.h,
                                                      fontFamily:
                                                          "R.font.pretendard",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black),
                                                ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        )),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
