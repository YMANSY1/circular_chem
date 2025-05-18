import 'package:circular_chem_app/core/models/category_enum.dart';

class Company {
  final String companyName;
  final BigInt echoPoints;
  final String email;
  final CategoryType industry;
  final String taxRegistryNumber;

//<editor-fold desc="Data Methods">
  const Company({
    required this.companyName,
    required this.echoPoints,
    required this.email,
    required this.industry,
    required this.taxRegistryNumber,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Company &&
          runtimeType == other.runtimeType &&
          companyName == other.companyName &&
          echoPoints == other.echoPoints &&
          email == other.email &&
          industry == other.industry &&
          taxRegistryNumber == other.taxRegistryNumber);

  @override
  int get hashCode =>
      companyName.hashCode ^
      echoPoints.hashCode ^
      email.hashCode ^
      industry.hashCode ^
      taxRegistryNumber.hashCode;

  @override
  String toString() {
    return 'Company{' +
        ' companyName: $companyName,' +
        ' echoPoints: $echoPoints,' +
        ' email: $email,' +
        ' industry: $industry,' +
        ' taxRegistryNumber: $taxRegistryNumber,' +
        '}';
  }

  Company copyWith({
    String? companyName,
    BigInt? echoPoints,
    String? email,
    CategoryType? industry,
    String? taxRegistryNumber,
  }) {
    return Company(
      companyName: companyName ?? this.companyName,
      echoPoints: echoPoints ?? this.echoPoints,
      email: email ?? this.email,
      industry: industry ?? this.industry,
      taxRegistryNumber: taxRegistryNumber ?? this.taxRegistryNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'company_name': this.companyName,
      'echo_points': this.echoPoints,
      'email': this.email,
      'industry': this.industry.name,
      'tax_no': this.taxRegistryNumber,
    };
  }

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
      companyName: map['company_name'] as String,
      echoPoints: BigInt.from(map['echo_points']),
      email: map['email'] as String,
      industry: CategoryType.fromString(map['industry']),
      taxRegistryNumber: map['tax_no'] as String,
    );
  }

//</editor-fold>
}
