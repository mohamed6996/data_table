import 'package:json_annotation/json_annotation.dart';
part 'package:data_table/model/json_response.g.dart';

@JsonSerializable()
class BaseResponse extends Object{
  List<Location> locations;

  BaseResponse(this.locations);

  factory BaseResponse.fromJson(Map<String, dynamic> json) =>_$BaseResponseFromJson(json);


}

@JsonSerializable()
class Location {
  int distance;
  double rating;
  double fee;
  Contact contact;
  MaximumWithdrawal maximum_withdrawal;

  Location(this.distance, this.rating, this.fee, this.contact,this.maximum_withdrawal);

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);

}


@JsonSerializable()
class Contact {
  String name;
  String category;
  int times;
  int last_active;
  String pic;

  Contact(this.name, this.category, this.times, this.last_active, this.pic);

  factory Contact.fromJson(Map<String, dynamic> json) =>_$ContactFromJson(json);

}


@JsonSerializable()
class MaximumWithdrawal {
  String currency;
  double amount;

  MaximumWithdrawal(this.currency, this.amount);

  factory MaximumWithdrawal.fromJson(Map<String, dynamic> json) => _$MaximumWithdrawalFromJson(json);

}
