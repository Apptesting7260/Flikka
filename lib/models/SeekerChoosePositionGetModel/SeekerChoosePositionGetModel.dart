class SeekerChoosePositionGetModel {
  SeekerChoosePositionGetModel({
     this.status,
     this.data,
     this.message,
  });
  bool ?status;
  List<Data>? data;
  String ?message;

  SeekerChoosePositionGetModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data!.map((e)=>e.toJson()).toList();
    _data['message'] = message;
    return _data;
  }
}

class Data {
  Data({
     this.id,
     this.positions,
     this.createdAt,
     this.updatedAt,
  });
   int ?id;
  String ?positions;
  String ?createdAt;
  String ?updatedAt;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    positions = json['positions'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['positions'] = positions;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}