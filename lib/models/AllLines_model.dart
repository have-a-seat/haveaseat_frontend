class AllLines {
  String? status;
  List<Data>? data;

  AllLines({this.status, this.data});

  AllLines.fromJson(Map<String, dynamic> json) {
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
  String? id;
  Attr? attr;

  Data({this.id, this.attr});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attr = json['attr'] != null ? new Attr.fromJson(json['attr']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.attr != null) {
      data['attr'] = this.attr!.toJson();
    }
    return data;
  }
}

class Attr {
  String? dataColor;
  String? dataIndicatorTextEn;
  String? dataIndicatorText;
  String? dataLabel;
  String? dataLineWidth;
  String? line_id;

  Attr(
      {this.dataColor,
      this.dataIndicatorTextEn,
      this.dataIndicatorText,
      this.dataLabel,
      this.dataLineWidth,
      this.line_id});

  Attr.fromJson(Map<String, dynamic> json) {
    dataColor = json['data-color'];
    dataIndicatorTextEn = json['data-indicator-text-en'];
    dataIndicatorText = json['data-indicator-text'];
    dataLabel = json['data-label'];
    dataLineWidth = json['data-lineWidth'];
    line_id = json["line_id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data-color'] = this.dataColor;
    data['data-indicator-text-en'] = this.dataIndicatorTextEn;
    data['data-indicator-text'] = this.dataIndicatorText;
    data['data-label'] = this.dataLabel;
    data['data-lineWidth'] = this.dataLineWidth;
    data['line_id'] = this.line_id;
    return data;
  }
}
