// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'cli_options.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CliOptions {
  bool get isVerboseEnabled => throw _privateConstructorUsedError;
  SidecarAnalyzerMode get mode => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CliOptionsCopyWith<CliOptions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CliOptionsCopyWith<$Res> {
  factory $CliOptionsCopyWith(
          CliOptions value, $Res Function(CliOptions) then) =
      _$CliOptionsCopyWithImpl<$Res>;
  $Res call({bool isVerboseEnabled, SidecarAnalyzerMode mode});
}

/// @nodoc
class _$CliOptionsCopyWithImpl<$Res> implements $CliOptionsCopyWith<$Res> {
  _$CliOptionsCopyWithImpl(this._value, this._then);

  final CliOptions _value;
  // ignore: unused_field
  final $Res Function(CliOptions) _then;

  @override
  $Res call({
    Object? isVerboseEnabled = freezed,
    Object? mode = freezed,
  }) {
    return _then(_value.copyWith(
      isVerboseEnabled: isVerboseEnabled == freezed
          ? _value.isVerboseEnabled
          : isVerboseEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      mode: mode == freezed
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as SidecarAnalyzerMode,
    ));
  }
}

/// @nodoc
abstract class _$$_CliOptionsCopyWith<$Res>
    implements $CliOptionsCopyWith<$Res> {
  factory _$$_CliOptionsCopyWith(
          _$_CliOptions value, $Res Function(_$_CliOptions) then) =
      __$$_CliOptionsCopyWithImpl<$Res>;
  @override
  $Res call({bool isVerboseEnabled, SidecarAnalyzerMode mode});
}

/// @nodoc
class __$$_CliOptionsCopyWithImpl<$Res> extends _$CliOptionsCopyWithImpl<$Res>
    implements _$$_CliOptionsCopyWith<$Res> {
  __$$_CliOptionsCopyWithImpl(
      _$_CliOptions _value, $Res Function(_$_CliOptions) _then)
      : super(_value, (v) => _then(v as _$_CliOptions));

  @override
  _$_CliOptions get _value => super._value as _$_CliOptions;

  @override
  $Res call({
    Object? isVerboseEnabled = freezed,
    Object? mode = freezed,
  }) {
    return _then(_$_CliOptions(
      isVerboseEnabled: isVerboseEnabled == freezed
          ? _value.isVerboseEnabled
          : isVerboseEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      mode: mode == freezed
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as SidecarAnalyzerMode,
    ));
  }
}

/// @nodoc

class _$_CliOptions extends _CliOptions {
  const _$_CliOptions({required this.isVerboseEnabled, required this.mode})
      : super._();

  @override
  final bool isVerboseEnabled;
  @override
  final SidecarAnalyzerMode mode;

  @override
  String toString() {
    return 'CliOptions(isVerboseEnabled: $isVerboseEnabled, mode: $mode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CliOptions &&
            const DeepCollectionEquality()
                .equals(other.isVerboseEnabled, isVerboseEnabled) &&
            const DeepCollectionEquality().equals(other.mode, mode));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isVerboseEnabled),
      const DeepCollectionEquality().hash(mode));

  @JsonKey(ignore: true)
  @override
  _$$_CliOptionsCopyWith<_$_CliOptions> get copyWith =>
      __$$_CliOptionsCopyWithImpl<_$_CliOptions>(this, _$identity);
}

abstract class _CliOptions extends CliOptions {
  const factory _CliOptions(
      {required final bool isVerboseEnabled,
      required final SidecarAnalyzerMode mode}) = _$_CliOptions;
  const _CliOptions._() : super._();

  @override
  bool get isVerboseEnabled;
  @override
  SidecarAnalyzerMode get mode;
  @override
  @JsonKey(ignore: true)
  _$$_CliOptionsCopyWith<_$_CliOptions> get copyWith =>
      throw _privateConstructorUsedError;
}
