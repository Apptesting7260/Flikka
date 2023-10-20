class SeekerChoosePositionModel {
  SeekerChoosePositionModel({
     this.status,
     this.message,
  });
   bool ?status;
   String ?message;

  SeekerChoosePositionModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    return _data;
  }
}