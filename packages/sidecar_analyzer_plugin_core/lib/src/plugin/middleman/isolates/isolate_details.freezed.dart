// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'isolate_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$IsolateDetails {
  ServerIsolateChannel get channel => throw _privateConstructorUsedError;
  ContextRoot get contextRoot => throw _privateConstructorUsedError;
  Uri get pluginSourceUri => throw _privateConstructorUsedError;
  List<SidecarPackage> get enabledPackages =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $IsolateDetailsCopyWith<IsolateDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IsolateDetailsCopyWith<$Res> {
  factory $IsolateDetailsCopyWith(
          IsolateDetails value, $Res Function(IsolateDetails) then) =
      _$IsolateDetailsCopyWithImpl<$Res>;
  $Res call(
      {ServerIsolateChannel channel,
      ContextRoot contextRoot,
      Uri pluginSourceUri,
      List<SidecarPackage> enabledPackages});
}

/// @nodoc
class _$IsolateDetailsCopyWithImpl<$Res>
    implements $IsolateDetailsCopyWith<$Res> {
  _$IsolateDetailsCopyWithImpl(this._value, this._then);

  final IsolateDetails _value;
  // ignore: unused_field
  final $Res Function(IsolateDetails) _then;

  @override
  $Res call({
    Object? channel = freezed,
    Object? contextRoot = freezed,
    Object? pluginSourceUri = freezed,
    Object? enabledPackages = freezed,
  }) {
    return _then(_value.copyWith(
      channel: channel == freezed
          ? _value.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as ServerIsolateChannel,
      contextRoot: contextRoot == freezed
          ? _value.contextRoot
          : contextRoot // ignore: cast_nullable_to_non_nullable
              as ContextRoot,
      pluginSourceUri: pluginSourceUri == freezed
          ? _value.pluginSourceUri
          : pluginSourceUri // ignore: cast_nullable_to_non_nullable
              as Uri,
      enabledPackages: enabledPackages == freezed
          ? _value.enabledPackages
          : enabledPackages // ignore: cast_nullable_to_non_nullable
              as List<SidecarPackage>,
    ));
  }
}

/// @nodoc
abstract class _$$_IsolateDetailsCopyWith<$Res>
    implements $IsolateDetailsCopyWith<$Res> {
  factory _$$_IsolateDetailsCopyWith(
          _$_IsolateDetails value, $Res Function(_$_IsolateDetails) then) =
      __$$_IsolateDetailsCopyWithImpl<$Res>;
  @override
  $Res call(
      {ServerIsolateChannel channel,
      ContextRoot contextRoot,
      Uri pluginSourceUri,
      List<SidecarPackage> enabledPackages});
}

/// @nodoc
class __$$_IsolateDetailsCopyWithImpl<$Res>
    extends _$IsolateDetailsCopyWithImpl<$Res>
    implements _$$_IsolateDetailsCopyWith<$Res> {
  __$$_IsolateDetailsCopyWithImpl(
      _$_IsolateDetails _value, $Res Function(_$_IsolateDetails) _then)
      : super(_value, (v) => _then(v as _$_IsolateDetails));

  @override
  _$_IsolateDetails get _value => super._value as _$_IsolateDetails;

  @override
  $Res call({
    Object? channel = freezed,
    Object? contextRoot = freezed,
    Object? pluginSourceUri = freezed,
    Object? enabledPackages = freezed,
  }) {
    return _then(_$_IsolateDetails(
      channel: channel == freezed
          ? _value.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as ServerIsolateChannel,
      contextRoot: contextRoot == freezed
          ? _value.contextRoot
          : contextRoot // ignore: cast_nullable_to_non_nullable
              as ContextRoot,
      pluginSourceUri: pluginSourceUri == freezed
          ? _value.pluginSourceUri
          : pluginSourceUri // ignore: cast_nullable_to_non_nullable
              as Uri,
      enabledPackages: enabledPackages == freezed
          ? _value._enabledPackages
          : enabledPackages // ignore: cast_nullable_to_non_nullable
              as List<SidecarPackage>,
    ));
  }
}

/// @nodoc

class _$_IsolateDetails extends _IsolateDetails {
  const _$_IsolateDetails(
      {required this.channel,
      required this.contextRoot,
      required this.pluginSourceUri,
      required final List<SidecarPackage> enabledPackages})
      : _enabledPackages = enabledPackages,
        super._();

  @override
  final ServerIsolateChannel channel;
  @override
  final ContextRoot contextRoot;
  @override
  final Uri pluginSourceUri;
  final List<SidecarPackage> _enabledPackages;
  @override
  List<SidecarPackage> get enabledPackages {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_enabledPackages);
  }

  @override
  String toString() {
    return 'IsolateDetails(channel: $channel, contextRoot: $contextRoot, pluginSourceUri: $pluginSourceUri, enabledPackages: $enabledPackages)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_IsolateDetails &&
            const DeepCollectionEquality().equals(other.channel, channel) &&
            const DeepCollectionEquality()
                .equals(other.contextRoot, contextRoot) &&
            const DeepCollectionEquality()
                .equals(other.pluginSourceUri, pluginSourceUri) &&
            const DeepCollectionEquality()
                .equals(other._enabledPackages, _enabledPackages));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(channel),
      const DeepCollectionEquality().hash(contextRoot),
      const DeepCollectionEquality().hash(pluginSourceUri),
      const DeepCollectionEquality().hash(_enabledPackages));

  @JsonKey(ignore: true)
  @override
  _$$_IsolateDetailsCopyWith<_$_IsolateDetails> get copyWith =>
      __$$_IsolateDetailsCopyWithImpl<_$_IsolateDetails>(this, _$identity);
}

abstract class _IsolateDetails extends IsolateDetails {
  const factory _IsolateDetails(
      {required final ServerIsolateChannel channel,
      required final ContextRoot contextRoot,
      required final Uri pluginSourceUri,
      required final List<SidecarPackage> enabledPackages}) = _$_IsolateDetails;
  const _IsolateDetails._() : super._();

  @override
  ServerIsolateChannel get channel;
  @override
  ContextRoot get contextRoot;
  @override
  Uri get pluginSourceUri;
  @override
  List<SidecarPackage> get enabledPackages;
  @override
  @JsonKey(ignore: true)
  _$$_IsolateDetailsCopyWith<_$_IsolateDetails> get copyWith =>
      throw _privateConstructorUsedError;
}
