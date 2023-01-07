// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'rule_analyzed_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RuleAnalyzedFile {
  BaseRule get rule => throw _privateConstructorUsedError;
  AnalyzedFile get file => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RuleAnalyzedFileCopyWith<RuleAnalyzedFile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RuleAnalyzedFileCopyWith<$Res> {
  factory $RuleAnalyzedFileCopyWith(
          RuleAnalyzedFile value, $Res Function(RuleAnalyzedFile) then) =
      _$RuleAnalyzedFileCopyWithImpl<$Res>;
  $Res call({BaseRule rule, AnalyzedFile file});

  $AnalyzedFileCopyWith<$Res> get file;
}

/// @nodoc
class _$RuleAnalyzedFileCopyWithImpl<$Res>
    implements $RuleAnalyzedFileCopyWith<$Res> {
  _$RuleAnalyzedFileCopyWithImpl(this._value, this._then);

  final RuleAnalyzedFile _value;
  // ignore: unused_field
  final $Res Function(RuleAnalyzedFile) _then;

  @override
  $Res call({
    Object? rule = freezed,
    Object? file = freezed,
  }) {
    return _then(_value.copyWith(
      rule: rule == freezed
          ? _value.rule
          : rule // ignore: cast_nullable_to_non_nullable
              as BaseRule,
      file: file == freezed
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as AnalyzedFile,
    ));
  }

  @override
  $AnalyzedFileCopyWith<$Res> get file {
    return $AnalyzedFileCopyWith<$Res>(_value.file, (value) {
      return _then(_value.copyWith(file: value));
    });
  }
}

/// @nodoc
abstract class _$$_RuleAnalyzedFileCopyWith<$Res>
    implements $RuleAnalyzedFileCopyWith<$Res> {
  factory _$$_RuleAnalyzedFileCopyWith(
          _$_RuleAnalyzedFile value, $Res Function(_$_RuleAnalyzedFile) then) =
      __$$_RuleAnalyzedFileCopyWithImpl<$Res>;
  @override
  $Res call({BaseRule rule, AnalyzedFile file});

  @override
  $AnalyzedFileCopyWith<$Res> get file;
}

/// @nodoc
class __$$_RuleAnalyzedFileCopyWithImpl<$Res>
    extends _$RuleAnalyzedFileCopyWithImpl<$Res>
    implements _$$_RuleAnalyzedFileCopyWith<$Res> {
  __$$_RuleAnalyzedFileCopyWithImpl(
      _$_RuleAnalyzedFile _value, $Res Function(_$_RuleAnalyzedFile) _then)
      : super(_value, (v) => _then(v as _$_RuleAnalyzedFile));

  @override
  _$_RuleAnalyzedFile get _value => super._value as _$_RuleAnalyzedFile;

  @override
  $Res call({
    Object? rule = freezed,
    Object? file = freezed,
  }) {
    return _then(_$_RuleAnalyzedFile(
      rule: rule == freezed
          ? _value.rule
          : rule // ignore: cast_nullable_to_non_nullable
              as BaseRule,
      file: file == freezed
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as AnalyzedFile,
    ));
  }
}

/// @nodoc

class _$_RuleAnalyzedFile extends _RuleAnalyzedFile {
  const _$_RuleAnalyzedFile({required this.rule, required this.file})
      : super._();

  @override
  final BaseRule rule;
  @override
  final AnalyzedFile file;

  @override
  String toString() {
    return 'RuleAnalyzedFile(rule: $rule, file: $file)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RuleAnalyzedFile &&
            const DeepCollectionEquality().equals(other.rule, rule) &&
            const DeepCollectionEquality().equals(other.file, file));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(rule),
      const DeepCollectionEquality().hash(file));

  @JsonKey(ignore: true)
  @override
  _$$_RuleAnalyzedFileCopyWith<_$_RuleAnalyzedFile> get copyWith =>
      __$$_RuleAnalyzedFileCopyWithImpl<_$_RuleAnalyzedFile>(this, _$identity);
}

abstract class _RuleAnalyzedFile extends RuleAnalyzedFile {
  const factory _RuleAnalyzedFile(
      {required final BaseRule rule,
      required final AnalyzedFile file}) = _$_RuleAnalyzedFile;
  const _RuleAnalyzedFile._() : super._();

  @override
  BaseRule get rule;
  @override
  AnalyzedFile get file;
  @override
  @JsonKey(ignore: true)
  _$$_RuleAnalyzedFileCopyWith<_$_RuleAnalyzedFile> get copyWith =>
      throw _privateConstructorUsedError;
}
