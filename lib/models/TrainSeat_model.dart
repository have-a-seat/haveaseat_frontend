class TrainSeat {
  String? status;
  Data? data;

  TrainSeat({this.status, this.data});

  TrainSeat.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Train>? train;

  Data({this.train});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['train'] != null) {
      train = <Train>[];
      json['train'].forEach((v) {
        train!.add(new Train.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.train != null) {
      data['train'] = this.train!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Train {
  String? name;
  Seat? seat;
  Seat? pregnancySeat;
  Seat? vulnerableSeat;

  Train({this.name, this.seat, this.pregnancySeat, this.vulnerableSeat});

  Train.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    seat = json['seat'] != null ? new Seat.fromJson(json['seat']) : null;
    pregnancySeat = json['pregnancySeat'] != null
        ? new Seat.fromJson(json['pregnancySeat'])
        : null;
    vulnerableSeat = json['vulnerableSeat'] != null
        ? new Seat.fromJson(json['vulnerableSeat'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.seat != null) {
      data['seat'] = this.seat!.toJson();
    }
    if (this.pregnancySeat != null) {
      data['pregnancySeat'] = this.pregnancySeat!.toJson();
    }
    if (this.vulnerableSeat != null) {
      data['vulnerableSeat'] = this.vulnerableSeat!.toJson();
    }
    return data;
  }
}

class Seat {
  List<int>? a;
  List<int>? b;

  Seat({this.a, this.b});

  Seat.fromJson(Map<String, dynamic> json) {
    a = json['a'].cast<int>();
    b = json['b'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['a'] = this.a;
    data['b'] = this.b;
    return data;
  }
}
