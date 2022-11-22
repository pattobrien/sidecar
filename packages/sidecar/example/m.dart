// ignore_for_file: use_setters_to_change_properties

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';
import 'package:sidecar_annotations/sidecar_annotations.dart';

class SomeRule extends SimpleAstVisitor<void>
    with SidecarAstVisitor, SidecarAnnotations, SidecarConfig {
  @override
  void visitAdjacentStrings(AdjacentStrings node) {
    final path = unit.unit;
    super.visitAdjacentStrings(node);
  }

  @override
  RuleConfiguration get config => RuleConfiguration(
        provider: thisAnnotationProvider.select(
          (nodes) => nodes.where((node) => node.input is DesignSystem),
        ),
      );
}

mixin SidecarAstVisitor on AstVisitor {
  ResolvedUnitResult get unit => _context.unit;
  String get path => _context.unit.path;

  RuleConfiguration get config => RuleConfiguration();

  late SidecarContext _context;

  void init(SidecarContext context) {
    _context = context;
  }
}

mixin SidecarConfig on SidecarAstVisitor {
  AlwaysAliveProviderListenable<Object> get configurationProvider =>
      config.configurationListenable;
}

mixin SidecarAnnotations on SidecarAstVisitor {
  Iterable<SidecarAnnotatedNode> get annotations => _context.annotations;

  AlwaysAliveProviderListenable<Iterable<SidecarAnnotatedNode>>
      get annotationProvider => config.annotationProvider;
}

const designSystem = DesignSystem();

class DesignSystem extends SidecarInput {
  const DesignSystem() : super(packageName: 'design_system_lints');
}

class RuleConfiguration {
  RuleConfiguration({
    AlwaysAliveProviderListenable<Iterable<SidecarAnnotatedNode>>? provider,
    AlwaysAliveProviderListenable<Object>? configurationProvider,
  })  : annotationProvider = provider ?? thisAnnotationProvider,
        configurationListenable =
            configurationProvider ?? thisConfigurationProvider;

  final AlwaysAliveProviderListenable<Iterable<SidecarAnnotatedNode>>
      annotationProvider;

  final AlwaysAliveProviderListenable<Object> configurationListenable;
}

abstract class SidecarContext {
  ResolvedUnitResult get unit;
  Iterable<SidecarAnnotatedNode> get annotations;
}

class SidecarContextImpl extends SidecarContext {
  SidecarContextImpl(this._annotations, this._unit);

  final Iterable<SidecarAnnotatedNode> _annotations;
  final ResolvedUnitResult _unit;

  @override
  Iterable<SidecarAnnotatedNode> get annotations => _annotations;

  @override
  ResolvedUnitResult get unit => _unit;
}

final thisAnnotationProvider = Provider((ref) => <SidecarAnnotatedNode>[]);

final thisConfigurationProvider =
    Provider<Object>((ref) => throw UnimplementedError());

final activatedRuleProivder =
    Provider.family<List<SomeRule>, String>((ref, filePath) {
  final rules = [SomeRule()];
  return rules.map((rule) {
    final unit = ref.watch(resolvedUnitProvider(filePath));
    final annotations = ref.watch(rule.annotationProvider);
    final config = ref.watch(rule.configurationProvider);
    final context = SidecarContextImpl(annotations, unit);
    rule.init(context);
    return rule;
  }).toList();
});

final resolvedUnitProvider =
    Provider.family<ResolvedUnitResult, String>((ref, filePath) {
  throw UnimplementedError();
});
