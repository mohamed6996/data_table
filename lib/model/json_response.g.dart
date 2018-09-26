// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_response.dart';

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) {
  return BaseResponse((json['locations'] as List)
      ?.map((e) =>
          e == null ? null : Location.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{'locations': instance.locations};

Location _$LocationFromJson(Map<String, dynamic> json) {
  return Location(
      json['distance'] as int,
      (json['rating'] as num)?.toDouble(),
      (json['fee'] as num)?.toDouble(),
      json['contact'] == null
          ? null
          : Contact.fromJson(json['contact'] as Map<String, dynamic>),
      json['maximum_withdrawal'] == null
          ? null
          : MaximumWithdrawal.fromJson(
              json['maximum_withdrawal'] as Map<String, dynamic>));
}

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'distance': instance.distance,
      'rating': instance.rating,
      'fee': instance.fee,
      'contact': instance.contact,
      'maximum_withdrawal': instance.maximum_withdrawal
    };

Contact _$ContactFromJson(Map<String, dynamic> json) {
  return Contact(json['name'] as String, json['category'] as String,
      json['times'] as int, json['last_active'] as int, json['pic'] as String);
}

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
      'name': instance.name,
      'category': instance.category,
      'times': instance.times,
      'last_active': instance.last_active,
      'pic': instance.pic
    };

MaximumWithdrawal _$MaximumWithdrawalFromJson(Map<String, dynamic> json) {
  return MaximumWithdrawal(
      json['currency'] as String, (json['amount'] as num)?.toDouble());
}

Map<String, dynamic> _$MaximumWithdrawalToJson(MaximumWithdrawal instance) =>
    <String, dynamic>{'currency': instance.currency, 'amount': instance.amount};
