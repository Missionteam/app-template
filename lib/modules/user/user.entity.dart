import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.entity.freezed.dart';
part 'user.entity.g.dart';

@freezed
class AppUser with _$AppUser {
  const factory AppUser({
    @Default('') String id,
    @Default('') String displayName,
    @Default('') String photoURL,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}
