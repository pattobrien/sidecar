// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'sidecar_annotated_node.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SidecarAnnotatedNode {
  AnnotatedNode get annotatedNode => throw _privateConstructorUsedError;
  SidecarInput get input => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SidecarAnnotatedNodeCopyWith<SidecarAnnotatedNode> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SidecarAnnotatedNodeCopyWith<$Res> {
  factory $SidecarAnnotatedNodeCopyWith(SidecarAnnotatedNode value,
          $Res Function(SidecarAnnotatedNode) then) =
      _$SidecarAnnotatedNodeCopyWithImpl<$Res, SidecarAnnotatedNode>;
  @useResult
  $Res call({AnnotatedNode annotatedNode, SidecarInput input});
}

/// @nodoc
class _$SidecarAnnotatedNodeCopyWithImpl<$Res,
        $Val extends SidecarAnnotatedNode>
    implements $SidecarAnnotatedNodeCopyWith<$Res> {
  _$SidecarAnnotatedNodeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? annotatedNode = null,
    Object? input = null,
  }) {
    return _then(_value.copyWith(
      annotatedNode: null == annotatedNode
          ? _value.annotatedNode
          : annotatedNode // ignore: cast_nullable_to_non_nullable
              as AnnotatedNode,
      input: null == input
          ? _value.input
          : input // ignore: cast_nullable_to_non_nullable
              as SidecarInput,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SidecarAnnotatedNodeCopyWith<$Res>
    implements $SidecarAnnotatedNodeCopyWith<$Res> {
  factory _$$_SidecarAnnotatedNodeCopyWith(_$_SidecarAnnotatedNode value,
          $Res Function(_$_SidecarAnnotatedNode) then) =
      __$$_SidecarAnnotatedNodeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AnnotatedNode annotatedNode, SidecarInput input});
}

/// @nodoc
class __$$_SidecarAnnotatedNodeCopyWithImpl<$Res>
    extends _$SidecarAnnotatedNodeCopyWithImpl<$Res, _$_SidecarAnnotatedNode>
    implements _$$_SidecarAnnotatedNodeCopyWith<$Res> {
  __$$_SidecarAnnotatedNodeCopyWithImpl(_$_SidecarAnnotatedNode _value,
      $Res Function(_$_SidecarAnnotatedNode) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? annotatedNode = null,
    Object? input = null,
  }) {
    return _then(_$_SidecarAnnotatedNode(
      annotatedNode: null == annotatedNode
          ? _value.annotatedNode
          : annotatedNode // ignore: cast_nullable_to_non_nullable
              as AnnotatedNode,
      input: null == input
          ? _value.input
          : input // ignore: cast_nullable_to_non_nullable
              as SidecarInput,
    ));
  }
}

/// @nodoc

class _$_SidecarAnnotatedNode extends _SidecarAnnotatedNode {
  const _$_SidecarAnnotatedNode(
      {required this.annotatedNode, required this.input})
      : super._();

  @override
  final AnnotatedNode annotatedNode;
  @override
  final SidecarInput input;

  @override
  String toString() {
    return 'SidecarAnnotatedNode(annotatedNode: $annotatedNode, input: $input)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SidecarAnnotatedNode &&
            (identical(other.annotatedNode, annotatedNode) ||
                other.annotatedNode == annotatedNode) &&
            (identical(other.input, input) || other.input == input));
  }

  @override
  int get hashCode => Object.hash(runtimeType, annotatedNode, input);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SidecarAnnotatedNodeCopyWith<_$_SidecarAnnotatedNode> get copyWith =>
      __$$_SidecarAnnotatedNodeCopyWithImpl<_$_SidecarAnnotatedNode>(
          this, _$identity);
}

abstract class _SidecarAnnotatedNode extends SidecarAnnotatedNode {
  const factory _SidecarAnnotatedNode(
      {required final AnnotatedNode annotatedNode,
      required final SidecarInput input}) = _$_SidecarAnnotatedNode;
  const _SidecarAnnotatedNode._() : super._();

  @override
  AnnotatedNode get annotatedNode;
  @override
  SidecarInput get input;
  @override
  @JsonKey(ignore: true)
  _$$_SidecarAnnotatedNodeCopyWith<_$_SidecarAnnotatedNode> get copyWith =>
      throw _privateConstructorUsedError;
}
