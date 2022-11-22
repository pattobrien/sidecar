import 'package:analyzer/file_system/file_system.dart';

abstract class PackageFileService {
  const PackageFileService(this.resourceProvider);
  final ResourceProvider resourceProvider;
  String? getAnalysisOptions() {}
}
