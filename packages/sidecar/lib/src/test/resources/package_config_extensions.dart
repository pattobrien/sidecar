// import 'package:package_config/package_config_types.dart';

// extension PackageConfigX on PackageConfig {
//   PackageConfig copyWith(Iterable<Package>? packages, {Object? extraData}) {
//     return PackageConfig(packages ?? this.packages,
//         extraData: extraData ?? this.extraData);
//   }

//   PackageConfig addPackage(Package package) {
//     return copyWith([...packages, package]);
//   }

//   PackageConfig addPackages(List<Package> packages) {
//     return copyWith([...this.packages, ...packages]);
//   }

//   PackageConfig removePackage(Package package) {
//     final newPackages =
//         List<Package>.from(packages.where((element) => element != package));
//     return copyWith(newPackages);
//   }
// }
