// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'log_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LogRecord _$LogRecordFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'simple':
      return _LogRecord.fromJson(json);
    case 'fromAnalyzer':
      return AnalyzerLogRecord.fromJson(json);
    case 'fromRule':
      return RuleLogRecord.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'LogRecord',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$LogRecord {
  String get message => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, DateTime timestamp) simple,
    required TResult Function(
            String message,
            DateTime timestamp,
            Uri targetRoot,
            LogSeverity severity,
            @JsonKey(toJson: stackToStringNullable, fromJson: stringToStackNullable, includeIfNull: false)
                StackTrace? stackTrace)
        fromAnalyzer,
    required TResult Function(
            RuleCode lintCode,
            DateTime timestamp,
            LogSeverity severity,
            String message,
            @JsonKey(toJson: stackToStringNullable, fromJson: stringToStackNullable, includeIfNull: false)
                StackTrace? stackTrace)
        fromRule,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, DateTime timestamp)? simple,
    TResult? Function(
            String message,
            DateTime timestamp,
            Uri targetRoot,
            LogSeverity severity,
            @JsonKey(toJson: stackToStringNullable, fromJson: stringToStackNullable, includeIfNull: false)
                StackTrace? stackTrace)?
        fromAnalyzer,
    TResult? Function(
            RuleCode lintCode,
            DateTime timestamp,
            LogSeverity severity,
            String message,
            @JsonKey(toJson: stackToStringNullable, fromJson: stringToStackNullable, includeIfNull: false)
                StackTrace? stackTrace)?
        fromRule,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, DateTime timestamp)? simple,
    TResult Function(
            String message,
            DateTime timestamp,
            Uri targetRoot,
            LogSeverity severity,
            @JsonKey(toJson: stackToStringNullable, fromJson: stringToStackNullable, includeIfNull: false)
                StackTrace? stackTrace)?
        fromAnalyzer,
    TResult Function(
            RuleCode lintCode,
            DateTime timestamp,
            LogSeverity severity,
            String message,
            @JsonKey(toJson: stackToStringNullable, fromJson: stringToStackNullable, includeIfNull: false)
                StackTrace? stackTrace)?
        fromRule,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LogRecord value) simple,
    required TResult Function(AnalyzerLogRecord value) fromAnalyzer,
    required TResult Function(RuleLogRecord value) fromRule,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LogRecord value)? simple,
    TResult? Function(AnalyzerLogRecord value)? fromAnalyzer,
    TResult? Function(RuleLogRecord value)? fromRule,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LogRecord value)? simple,
    TResult Function(AnalyzerLogRecord value)? fromAnalyzer,
    TResult Function(RuleLogRecord value)? fromRule,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LogRecordCopyWith<LogRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LogRecordCopyWith<$Res> {
  factory $LogRecordCopyWith(LogRecord value, $Res Function(LogRecord) then) =
      _$LogRecordCopyWithImpl<$Res, LogRecord>;
  @useResult
  $Res call({String message, DateTime timestamp});
}

/// @nodoc
class _$LogRecordCopyWithImpl<$Res, $Val extends LogRecord>
    implements $LogRecordCopyWith<$Res> {
  _$LogRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LogRecordCopyWith<$Res> implements $LogRecordCopyWith<$Res> {
  factory _$$_LogRecordCopyWith(
          _$_LogRecord value, $Res Function(_$_LogRecord) then) =
      __$$_LogRecordCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, DateTime timestamp});
}

/// @nodoc
class __$$_LogRecordCopyWithImpl<$Res>
    extends _$LogRecordCopyWithImpl<$Res, _$_LogRecord>
    implements _$$_LogRecordCopyWith<$Res> {
  __$$_LogRecordCopyWithImpl(
      _$_LogRecord _value, $Res Function(_$_LogRecord) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? timestamp = null,
  }) {
    return _then(_$_LogRecord(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LogRecord extends _LogRecord {
  const _$_LogRecord(this.message, this.timestamp, {final String? $type})
      : $type = $type ?? 'simple',
        super._();

  factory _$_LogRecord.fromJson(Map<String, dynamic> json) =>
      _$$_LogRecordFromJson(json);

  @override
  final String message;
  @override
  final DateTime timestamp;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'LogRecord.simple(message: $message, timestamp: $timestamp)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LogRecord &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, message, timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LogRecordCopyWith<_$_LogRecord> get copyWith =>
      __$$_LogRecordCopyWithImpl<_$_LogRecord>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, DateTime timestamp) simple,
    required TResult Function(
            String message,
            DateTime timestamp,
            Uri targetRoot,
            LogSeverity severity,
            @JsonKey(toJson: stackToStringNullable, fromJson: stringToStackNullable, includeIfNull: false)
                StackTrace? stackTrace)
        fromAnalyzer,
    required TResult Function(
            RuleCode lintCode,
            DateTime timestamp,
            LogSeverity severity,
            String message,
            @JsonKey(toJson: stackToStringNullable, fromJson: stringToStackNullable, includeIfNull: false)
                StackTrace? stackTrace)
        fromRule,
  }) {
    return simple(message, timestamp);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, DateTime timestamp)? simple,
    TResult? Function(
            String message,
            DateTime timestamp,
            Uri targetRoot,
            LogSeverity severity,
            @JsonKey(toJson: stackToStringNullable, fromJson: stringToStackNullable, includeIfNull: false)
                StackTrace? stackTrace)?
        fromAnalyzer,
    TResult? Function(
            RuleCode lintCode,
            DateTime timestamp,
            LogSeverity severity,
            String message,
            @JsonKey(toJson: stackToStringNullable, fromJson: stringToStackNullable, includeIfNull: false)
                StackTrace? stackTrace)?
        fromRule,
  }) {
    return simple?.call(message, timestamp);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, DateTime timestamp)? simple,
    TResult Function(
            String message,
            DateTime timestamp,
            Uri targetRoot,
            LogSeverity severity,
            @JsonKey(toJson: stackToStringNullable, fromJson: stringToStackNullable, includeIfNull: false)
                StackTrace? stackTrace)?
        fromAnalyzer,
    TResult Function(
            RuleCode lintCode,
            DateTime timestamp,
            LogSeverity severity,
            String message,
            @JsonKey(toJson: stackToStringNullable, fromJson: stringToStackNullable, includeIfNull: false)
                StackTrace? stackTrace)?
        fromRule,
    required TResult orElse(),
  }) {
    if (simple != null) {
      return simple(message, timestamp);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LogRecord value) simple,
    required TResult Function(AnalyzerLogRecord value) fromAnalyzer,
    required TResult Function(RuleLogRecord value) fromRule,
  }) {
    return simple(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LogRecord value)? simple,
    TResult? Function(AnalyzerLogRecord value)? fromAnalyzer,
    TResult? Function(RuleLogRecord value)? fromRule,
  }) {
    return simple?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LogRecord value)? simple,
    TResult Function(AnalyzerLogRecord value)? fromAnalyzer,
    TResult Function(RuleLogRecord value)? fromRule,
    required TResult orElse(),
  }) {
    if (simple != null) {
      return simple(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_LogRecordToJson(
      this,
    );
  }
}

abstract class _LogRecord extends LogRecord {
  const factory _LogRecord(final String message, final DateTime timestamp) =
      _$_LogRecord;
  const _LogRecord._() : super._();

  factory _LogRecord.fromJson(Map<String, dynamic> json) =
      _$_LogRecord.fromJson;

  @override
  String get message;
  @override
  DateTime get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$_LogRecordCopyWith<_$_LogRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AnalyzerLogRecordCopyWith<$Res>
    implements $LogRecordCopyWith<$Res> {
  factory _$$AnalyzerLogRecordCopyWith(
          _$AnalyzerLogRecord value, $Res Function(_$AnalyzerLogRecord) then) =
      __$$AnalyzerLogRecordCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String message,
      DateTime timestamp,
      Uri targetRoot,
      LogSeverity severity,
      @JsonKey(toJson: stackToStringNullable, fromJson: stringToStackNullable, includeIfNull: false)
          StackTrace? stackTrace});
}

/// @nodoc
class __$$AnalyzerLogRecordCopyWithImpl<$Res>
    extends _$LogRecordCopyWithImpl<$Res, _$AnalyzerLogRecord>
    implements _$$AnalyzerLogRecordCopyWith<$Res> {
  __$$AnalyzerLogRecordCopyWithImpl(
      _$AnalyzerLogRecord _value, $Res Function(_$AnalyzerLogRecord) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? timestamp = null,
    Object? targetRoot = null,
    Object? severity = null,
    Object? stackTrace = freezed,
  }) {
    return _then(_$AnalyzerLogRecord(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      targetRoot: null == targetRoot
          ? _value.targetRoot
          : targetRoot // ignore: cast_nullable_to_non_nullable
              as Uri,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as LogSeverity,
      stackTrace: freezed == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AnalyzerLogRecord extends AnalyzerLogRecord {
  const _$AnalyzerLogRecord(
      this.message,
      this.timestamp,
      {required this.targetRoot,
      required this.severity,
      @JsonKey(toJson: stackToStringNullable, fromJson: stringToStackNullable, includeIfNull: false)
          this.stackTrace,
      final String? $type})
      : $type = $type ?? 'fromAnalyzer',
        super._();

  factory _$AnalyzerLogRecord.fromJson(Map<String, dynamic> json) =>
      _$$AnalyzerLogRecordFromJson(json);

  @override
  final String message;
  @override
  final DateTime timestamp;
  @override
  final Uri targetRoot;
  @override
  final LogSeverity severity;
  @override
  @JsonKey(
      toJson: stackToStringNullable,
      fromJson: stringToStackNullable,
      includeIfNull: false)
  final StackTrace? stackTrace;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'LogRecord.fromAnalyzer(message: $message, timestamp: $timestamp, targetRoot: $targetRoot, severity: $severity, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnalyzerLogRecord &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.targetRoot, targetRoot) ||
                other.targetRoot == targetRoot) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, message, timestamp, targetRoot, severity, stackTrace);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AnalyzerLogRecordCopyWith<_$AnalyzerLogRecord> get copyWith =>
      __$$AnalyzerLogRecordCopyWithImpl<_$AnalyzerLogRecord>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, DateTime timestamp) simple,
    required TResult Function(
            String message,
            DateTime timestamp,
            Uri targetRoot,
            LogSeverity severity,
            @JsonKey(toJson: stackToStringNullable, fromJson: stringToStackNullable, includeIfNull: false)
                StackTrace? stackTrace)
        fromAnalyzer,
    required TResult Function(
            RuleCode lintCode,
            DateTime timestamp,
            LogSeverity severity,
            String message,
            @JsonKey(toJson: stackToStringNullable, fromJson: stringToStackNullable, includeIfNull: false)
                StackTrace? stackTrace)
        fromRule,
  }) {
    return fromAnalyzer(message, timestamp, targetRoot, severity, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, DateTime timestamp)? simple,
    TResult? Function(
            String message,
            DateTime timestamp,
            Uri targetRoot,
            LogSeverity severity,
            @JsonKey(toJson: stackToStringNullable, fromJson: stringToStackNullable, includeIfNull: false)
                StackTrace? stackTrace)?
        fromAnalyzer,
    TResult? Function(
            RuleCode lintCode,
            DateTime timestamp,
            LogSeverity severity,
            String message,
            @JsonKey(toJson: stackToStringNullable, fromJson: stringToStackNullable, includeIfNull: false)
                StackTrace? stackTrace)?
        fromRule,
  }) {
    return fromAnalyzer?.call(
        message, timestamp, targetRoot, severity, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, DateTime timestamp)? simple,
    TResult Function(
            String message,
            DateTime timestamp,
            Uri targetRoot,
            LogSeverity severity,
            @JsonKey(toJson: stackToStringNullable, fromJson: stringToStackNullable, includeIfNull: false)
                StackTrace? stackTrace)?
        fromAnalyzer,
    TResult Function(
            RuleCode lintCode,
            DateTime timestamp,
            LogSeverity severity,
            String message,
            @JsonKey(toJson: stackToStringNullable, fromJson: stringToStackNullable, includeIfNull: false)
                StackTrace? stackTrace)?
        fromRule,
    required TResult orElse(),
  }) {
    if (fromAnalyzer != null) {
      return fromAnalyzer(message, timestamp, targetRoot, severity, stackTrace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LogRecord value) simple,
    required TResult Function(AnalyzerLogRecord value) fromAnalyzer,
    required TResult Function(RuleLogRecord value) fromRule,
  }) {
    return fromAnalyzer(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LogRecord value)? simple,
    TResult? Function(AnalyzerLogRecord value)? fromAnalyzer,
    TResult? Function(RuleLogRecord value)? fromRule,
  }) {
    return fromAnalyzer?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LogRecord value)? simple,
    TResult Function(AnalyzerLogRecord value)? fromAnalyzer,
    TResult Function(RuleLogRecord value)? fromRule,
    required TResult orElse(),
  }) {
    if (fromAnalyzer != null) {
      return fromAnalyzer(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AnalyzerLogRecordToJson(
      this,
    );
  }
}

abstract class AnalyzerLogRecord extends LogRecord {
  const factory AnalyzerLogRecord(
      final String message,
      final DateTime timestamp,
      {required final Uri targetRoot,
      required final LogSeverity severity,
      @JsonKey(toJson: stackToStringNullable, fromJson: stringToStackNullable, includeIfNull: false)
          final StackTrace? stackTrace}) = _$AnalyzerLogRecord;
  const AnalyzerLogRecord._() : super._();

  factory AnalyzerLogRecord.fromJson(Map<String, dynamic> json) =
      _$AnalyzerLogRecord.fromJson;

  @override
  String get message;
  @override
  DateTime get timestamp;
  Uri get targetRoot;
  LogSeverity get severity;
  @JsonKey(
      toJson: stackToStringNullable,
      fromJson: stringToStackNullable,
      includeIfNull: false)
  StackTrace? get stackTrace;
  @override
  @JsonKey(ignore: true)
  _$$AnalyzerLogRecordCopyWith<_$AnalyzerLogRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RuleLogRecordCopyWith<$Res>
    implements $LogRecordCopyWith<$Res> {
  factory _$$RuleLogRecordCopyWith(
          _$RuleLogRecord value, $Res Function(_$RuleLogRecord) then) =
      __$$RuleLogRecordCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {RuleCode lintCode,
      DateTime timestamp,
      LogSeverity severity,
      String message,
      @JsonKey(toJson: stackToStringNullable, fromJson: stringToStackNullable, includeIfNull: false)
          StackTrace? stackTrace});

  $RuleCodeCopyWith<$Res> get lintCode;
}

/// @nodoc
class __$$RuleLogRecordCopyWithImpl<$Res>
    extends _$LogRecordCopyWithImpl<$Res, _$RuleLogRecord>
    implements _$$RuleLogRecordCopyWith<$Res> {
  __$$RuleLogRecordCopyWithImpl(
      _$RuleLogRecord _value, $Res Function(_$RuleLogRecord) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lintCode = null,
    Object? timestamp = null,
    Object? severity = null,
    Object? message = null,
    Object? stackTrace = freezed,
  }) {
    return _then(_$RuleLogRecord(
      null == lintCode
          ? _value.lintCode
          : lintCode // ignore: cast_nullable_to_non_nullable
              as RuleCode,
      null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as LogSeverity,
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      freezed == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $RuleCodeCopyWith<$Res> get lintCode {
    return $RuleCodeCopyWith<$Res>(_value.lintCode, (value) {
      return _then(_value.copyWith(lintCode: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$RuleLogRecord extends RuleLogRecord {
  const _$RuleLogRecord(
      this.lintCode,
      this.timestamp,
      this.severity,
      this.message,
      @JsonKey(toJson: stackToStringNullable, fromJson: stringToStackNullable, includeIfNull: false)
          this.stackTrace,
      {final String? $type})
      : $type = $type ?? 'fromRule',
        super._();

  factory _$RuleLogRecord.fromJson(Map<String, dynamic> json) =>
      _$$RuleLogRecordFromJson(json);

  @override
  final RuleCode lintCode;
  @override
  final DateTime timestamp;
  @override
  final LogSeverity severity;
  @override
  final String message;
  @override
  @JsonKey(
      toJson: stackToStringNullable,
      fromJson: stringToStackNullable,
      includeIfNull: false)
  final StackTrace? stackTrace;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'LogRecord.fromRule(lintCode: $lintCode, timestamp: $timestamp, severity: $severity, message: $message, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RuleLogRecord &&
            (identical(other.lintCode, lintCode) ||
                other.lintCode == lintCode) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, lintCode, timestamp, severity, message, stackTrace);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RuleLogRecordCopyWith<_$RuleLogRecord> get copyWith =>
      __$$RuleLogRecordCopyWithImpl<_$RuleLogRecord>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, DateTime timestamp) simple,
    required TResult Function(
            String message,
            DateTime timestamp,
            Uri targetRoot,
            LogSeverity severity,
            @JsonKey(toJson: stackToStringNullable, fromJson: stringToStackNullable, includeIfNull: false)
                StackTrace? stackTrace)
        fromAnalyzer,
    required TResult Function(
            RuleCode lintCode,
            DateTime timestamp,
            LogSeverity severity,
            String message,
            @JsonKey(toJson: stackToStringNullable, fromJson: stringToStackNullable, includeIfNull: false)
                StackTrace? stackTrace)
        fromRule,
  }) {
    return fromRule(lintCode, timestamp, severity, message, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, DateTime timestamp)? simple,
    TResult? Function(
            String message,
            DateTime timestamp,
            Uri targetRoot,
            LogSeverity severity,
            @JsonKey(toJson: stackToStringNullable, fromJson: stringToStackNullable, includeIfNull: false)
                StackTrace? stackTrace)?
        fromAnalyzer,
    TResult? Function(
            RuleCode lintCode,
            DateTime timestamp,
            LogSeverity severity,
            String message,
            @JsonKey(toJson: stackToStringNullable, fromJson: stringToStackNullable, includeIfNull: false)
                StackTrace? stackTrace)?
        fromRule,
  }) {
    return fromRule?.call(lintCode, timestamp, severity, message, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, DateTime timestamp)? simple,
    TResult Function(
            String message,
            DateTime timestamp,
            Uri targetRoot,
            LogSeverity severity,
            @JsonKey(toJson: stackToStringNullable, fromJson: stringToStackNullable, includeIfNull: false)
                StackTrace? stackTrace)?
        fromAnalyzer,
    TResult Function(
            RuleCode lintCode,
            DateTime timestamp,
            LogSeverity severity,
            String message,
            @JsonKey(toJson: stackToStringNullable, fromJson: stringToStackNullable, includeIfNull: false)
                StackTrace? stackTrace)?
        fromRule,
    required TResult orElse(),
  }) {
    if (fromRule != null) {
      return fromRule(lintCode, timestamp, severity, message, stackTrace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LogRecord value) simple,
    required TResult Function(AnalyzerLogRecord value) fromAnalyzer,
    required TResult Function(RuleLogRecord value) fromRule,
  }) {
    return fromRule(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LogRecord value)? simple,
    TResult? Function(AnalyzerLogRecord value)? fromAnalyzer,
    TResult? Function(RuleLogRecord value)? fromRule,
  }) {
    return fromRule?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LogRecord value)? simple,
    TResult Function(AnalyzerLogRecord value)? fromAnalyzer,
    TResult Function(RuleLogRecord value)? fromRule,
    required TResult orElse(),
  }) {
    if (fromRule != null) {
      return fromRule(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$RuleLogRecordToJson(
      this,
    );
  }
}

abstract class RuleLogRecord extends LogRecord {
  const factory RuleLogRecord(
      final RuleCode lintCode,
      final DateTime timestamp,
      final LogSeverity severity,
      final String message,
      @JsonKey(toJson: stackToStringNullable, fromJson: stringToStackNullable, includeIfNull: false)
          final StackTrace? stackTrace) = _$RuleLogRecord;
  const RuleLogRecord._() : super._();

  factory RuleLogRecord.fromJson(Map<String, dynamic> json) =
      _$RuleLogRecord.fromJson;

  RuleCode get lintCode;
  @override
  DateTime get timestamp;
  LogSeverity get severity;
  @override
  String get message;
  @JsonKey(
      toJson: stackToStringNullable,
      fromJson: stringToStackNullable,
      includeIfNull: false)
  StackTrace? get stackTrace;
  @override
  @JsonKey(ignore: true)
  _$$RuleLogRecordCopyWith<_$RuleLogRecord> get copyWith =>
      throw _privateConstructorUsedError;
}
