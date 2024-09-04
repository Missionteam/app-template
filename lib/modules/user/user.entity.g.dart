// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserImpl _$$AppUserImplFromJson(Map<String, dynamic> json) =>
    _$AppUserImpl(
      id: json['id'] as String? ?? '',
      displayName: json['displayName'] as String? ?? '',
      photoURL: json['photoURL'] as String? ?? '',
    );

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'photoURL': instance.photoURL,
    };
