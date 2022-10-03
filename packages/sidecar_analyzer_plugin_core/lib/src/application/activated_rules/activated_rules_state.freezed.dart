// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'activated_rules_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ActivatedRulesState {
  List<SidecarBase> get rules => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ActivatedRulesStateCopyWith<ActivatedRulesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivatedRulesStateCopyWith<$Res> {
  factory $ActivatedRulesStateCopyWith(
          ActivatedRulesState value, $Res Function(ActivatedRulesState) then) =
      _$ActivatedRulesStateCopyWithImpl<$Res>;
  $Res call({List<SidecarBase> rules});
}

/// @nodoc
class _$ActivatedRulesStateCopyWithImpl<$Res>
    implements $ActivatedRulesStateCopyWith<$Res> {
  _$ActivatedRulesStateCopyWithImpl(this._value, this._then);

  final ActivatedRulesState _value;
  // ignore: unused_field
  final $Res Function(ActivatedRulesState) _then;

  @override
  $Res call({
    Object? rules = freezed,
  }) {
    return _then(_value.copyWith(
      rules: rules == freezed
          ? _value.rules
          : rules // ignore: cast_nullable_to_non_nullable
              as List<SidecarBase>,
    ));
  }
}

/// @nodoc
abstract class _$$_ActivatedRulesStateCopyWith<$Res>
    implements $ActivatedRulesStateCopyWith<$Res> {
  factory _$$_ActivatedRulesStateCopyWith(_$_ActivatedRulesState value,
          $Res Function(_$_ActivatedRulesState) then) =
      __$$_ActivatedRulesStateCopyWithImpl<$Res>;
  @override
  $Res call({List<SidecarBase> rules});
}

/// @nodoc
class __$$_ActivatedRulesStateCopyWithImpl<$Res>
    extends _$ActivatedRulesStateCopyWithImpl<$Res>
    implements _$$_ActivatedRulesStateCopyWith<$Res> {
  __$$_ActivatedRulesStateCopyWithImpl(_$_ActivatedRulesState _value,
      $Res Function(_$_ActivatedRulesState) _then)
      : super(_value, (v) => _then(v as _$_ActivatedRulesState));

  @override
  _$_ActivatedRulesState get _value => super._value as _$_ActivatedRulesState;

  @override
  $Res call({
    Object? rules = freezed,
  }) {
    return _then(_$_ActivatedRulesState(
      rules: rules == freezed
          ? _value._rules
          : rules // ignore: cast_nullable_to_non_nullable
              as List<SidecarBase>,
    ));
  }
}

/// @nodoc

class _$_ActivatedRulesState extends _ActivatedRulesState {
  const _$_ActivatedRulesState(
      {final List<SidecarBase> rules = const <SidecarBase>[]})
      : _rules = rules,
        super._();

  final List<SidecarBase> _rules;
  @override
  @JsonKey()
  List<SidecarBase> get rules {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rules);
  }

  @override
  String toString() {
    return 'ActivatedRulesState(rules: $rules)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ActivatedRulesState &&
            const DeepCollectionEquality().equals(other._rules, _rules));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_rules));

  @JsonKey(ignore: true)
  @override
  _$$_ActivatedRulesStateCopyWith<_$_ActivatedRulesState> get copyWith =>
      __$$_ActivatedRulesStateCopyWithImpl<_$_ActivatedRulesState>(
          this, _$identity);
}

abstract class _ActivatedRulesState extends ActivatedRulesState {
  const factory _ActivatedRulesState({final List<SidecarBase> rules}) =
      _$_ActivatedRulesState;
  const _ActivatedRulesState._() : super._();

  @override
  List<SidecarBase> get rules;
  @override
  @JsonKey(ignore: true)
  _$$_ActivatedRulesStateCopyWith<_$_ActivatedRulesState> get copyWith =>
      throw _privateConstructorUsedError;
}
