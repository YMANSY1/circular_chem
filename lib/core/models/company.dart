import 'package:circular_chem_app/core/models/category_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Company {
  final String id; // Document ID
  final String companyName;
  final BigInt ecoPoints;
  final String email;
  final CategoryType industry;
  final String taxRegistryNumber;
  final String? profilePicUrl;

//<editor-fold desc="Data Methods">
  const Company({
    required this.id, // Added required id
    required this.companyName,
    required this.ecoPoints,
    required this.email,
    required this.industry,
    required this.taxRegistryNumber,
    this.profilePicUrl,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Company &&
          runtimeType == other.runtimeType &&
          id == other.id && // Added id to operator ==
          companyName == other.companyName &&
          ecoPoints == other.ecoPoints &&
          email == other.email &&
          industry == other.industry &&
          taxRegistryNumber == other.taxRegistryNumber &&
          profilePicUrl == other.profilePicUrl);

  @override
  int get hashCode =>
      id.hashCode ^ // Added id to hashCode
      companyName.hashCode ^
      ecoPoints.hashCode ^
      email.hashCode ^
      industry.hashCode ^
      taxRegistryNumber.hashCode ^
      profilePicUrl.hashCode;

  @override
  String toString() {
    return 'Company{' +
        ' id: $id,' + // Added id to toString
        ' companyName: $companyName,' +
        ' echoPoints: $ecoPoints,' +
        ' email: $email,' +
        ' industry: $industry,' +
        ' taxRegistryNumber: $taxRegistryNumber,' +
        ' profilePicUrl: $profilePicUrl,' +
        '}';
  }

  Company copyWith({
    String? id, // Added id to copyWith
    String? companyName,
    BigInt? echoPoints,
    String? email,
    CategoryType? industry,
    String? taxRegistryNumber,
    String? profilePicUrl,
  }) {
    return Company(
      id: id ?? this.id, // Added id to copyWith
      companyName: companyName ?? this.companyName,
      ecoPoints: echoPoints ?? this.ecoPoints,
      email: email ?? this.email,
      industry: industry ?? this.industry,
      taxRegistryNumber: taxRegistryNumber ?? this.taxRegistryNumber,
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      // Note: id is not included in toMap as it's the document ID
      'company_name': companyName,
      'echo_points': ecoPoints,
      'email': email,
      'industry': industry.name,
      'tax_no': taxRegistryNumber,
      'profile_picture_url': profilePicUrl,
    };
  }

  factory Company.fromMap(Map<String, dynamic> map, {required String id}) {
    return Company(
      id: id, // Added required id parameter
      companyName: map['company_name'] as String,
      ecoPoints: BigInt.from(map['echo_points']),
      email: map['email'] as String,
      industry: CategoryType.fromString(map['industry']),
      taxRegistryNumber: map['tax_no'] as String,
      profilePicUrl: map['profile_picture_url'] as String?,
    );
  }

  // Convenience method for creating from DocumentSnapshot
  factory Company.fromDocumentSnapshot(DocumentSnapshot doc) {
    return Company.fromMap(doc.data() as Map<String, dynamic>, id: doc.id);
  }

//</editor-fold>
}
