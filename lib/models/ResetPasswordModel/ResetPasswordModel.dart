class ResetPasswordModel {
  ResetPasswordModel({
     this.status,
     this.message,
  });
   bool ?status;
   String ?message;

  ResetPasswordModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}