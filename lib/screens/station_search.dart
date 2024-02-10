import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haveaseat/models/AllLines_model.dart';
import 'package:haveaseat/models/AllStations_model.dart';
import 'package:haveaseat/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;

class StationSearchScreen extends StatefulWidget {
  String lineId;
  StationSearchScreen({super.key, required this.lineId});

  @override
  State<StationSearchScreen> createState() => _StationSearchScreenState();
}

class _StationSearchScreenState extends State<StationSearchScreen> {
  Future<List> getStations() async {
    dev.log("1");

    final response = await http.get(
      Uri.parse('https://subwaystations-2t65ehgdja-du.a.run.app'),
    );
    dev.log(response.toString());
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return [
        AllStations.fromJson(jsonDecode(data!))
            .data!
            .where((element) => element.lines!.contains(widget.lineId))
      ];
    } else {
      showSnackBar("서버 응답에 오류가 있습니다", context);
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: 343.w,
        height: 668.h,
        child: FutureBuilder(
            future: getStations(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '서버 응답에 오류가 있습니다',
                    style: TextStyle(fontSize: 15),
                  ),
                );
              } else {
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext ctx, int idx) {
                              return SizedBox(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(snapshot.data[idx].name),
                                    Text(snapshot.data[idx].lines),
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ));
              }
            }),
      ),
    );
  }
}
