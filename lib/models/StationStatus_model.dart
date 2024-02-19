class StationStatus {
  String? status;
  List<Data>? data;

  StationStatus({this.status, this.data});

  StationStatus.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  Null? beginRow;
  Null? endRow;
  Null? curPage;
  Null? pageRow;
  int? totalCount;
  int? rowNum;
  int? selectedCount;
  String? subwayId;
  Null? subwayNm;
  String? updnLine;
  String? trainLineNm;
  Null? subwayHeading;
  String? statnFid;
  String? statnTid;
  String? statnId;
  String? statnNm;
  Null? trainCo;
  String? trnsitCo;
  String? ordkey;
  String? subwayList;
  String? statnList;
  String? btrainSttus;
  String? barvlDt;
  String? btrainNo;
  String? bstatnId;
  String? bstatnNm;
  String? recptnDt;
  String? arvlMsg2;
  String? arvlMsg3;
  String? arvlCd;

  Data(
      {this.beginRow,
      this.endRow,
      this.curPage,
      this.pageRow,
      this.totalCount,
      this.rowNum,
      this.selectedCount,
      this.subwayId,
      this.subwayNm,
      this.updnLine,
      this.trainLineNm,
      this.subwayHeading,
      this.statnFid,
      this.statnTid,
      this.statnId,
      this.statnNm,
      this.trainCo,
      this.trnsitCo,
      this.ordkey,
      this.subwayList,
      this.statnList,
      this.btrainSttus,
      this.barvlDt,
      this.btrainNo,
      this.bstatnId,
      this.bstatnNm,
      this.recptnDt,
      this.arvlMsg2,
      this.arvlMsg3,
      this.arvlCd});

  Data.fromJson(Map<String, dynamic> json) {
    beginRow = json['beginRow'];
    endRow = json['endRow'];
    curPage = json['curPage'];
    pageRow = json['pageRow'];
    totalCount = json['totalCount'];
    rowNum = json['rowNum'];
    selectedCount = json['selectedCount'];
    subwayId = json['subwayId'];
    subwayNm = json['subwayNm'];
    updnLine = json['updnLine'];
    trainLineNm = json['trainLineNm'];
    subwayHeading = json['subwayHeading'];
    statnFid = json['statnFid'];
    statnTid = json['statnTid'];
    statnId = json['statnId'];
    statnNm = json['statnNm'];
    trainCo = json['trainCo'];
    trnsitCo = json['trnsitCo'];
    ordkey = json['ordkey'];
    subwayList = json['subwayList'];
    statnList = json['statnList'];
    btrainSttus = json['btrainSttus'];
    barvlDt = json['barvlDt'];
    btrainNo = json['btrainNo'];
    bstatnId = json['bstatnId'];
    bstatnNm = json['bstatnNm'];
    recptnDt = json['recptnDt'];
    arvlMsg2 = json['arvlMsg2'];
    arvlMsg3 = json['arvlMsg3'];
    arvlCd = json['arvlCd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['beginRow'] = this.beginRow;
    data['endRow'] = this.endRow;
    data['curPage'] = this.curPage;
    data['pageRow'] = this.pageRow;
    data['totalCount'] = this.totalCount;
    data['rowNum'] = this.rowNum;
    data['selectedCount'] = this.selectedCount;
    data['subwayId'] = this.subwayId;
    data['subwayNm'] = this.subwayNm;
    data['updnLine'] = this.updnLine;
    data['trainLineNm'] = this.trainLineNm;
    data['subwayHeading'] = this.subwayHeading;
    data['statnFid'] = this.statnFid;
    data['statnTid'] = this.statnTid;
    data['statnId'] = this.statnId;
    data['statnNm'] = this.statnNm;
    data['trainCo'] = this.trainCo;
    data['trnsitCo'] = this.trnsitCo;
    data['ordkey'] = this.ordkey;
    data['subwayList'] = this.subwayList;
    data['statnList'] = this.statnList;
    data['btrainSttus'] = this.btrainSttus;
    data['barvlDt'] = this.barvlDt;
    data['btrainNo'] = this.btrainNo;
    data['bstatnId'] = this.bstatnId;
    data['bstatnNm'] = this.bstatnNm;
    data['recptnDt'] = this.recptnDt;
    data['arvlMsg2'] = this.arvlMsg2;
    data['arvlMsg3'] = this.arvlMsg3;
    data['arvlCd'] = this.arvlCd;
    return data;
  }
}
