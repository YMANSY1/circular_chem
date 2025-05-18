enum CategoryType {
  metalMaterials,
  plasticComponents,
  textilesFabrics,
  woodSawdust,
  chemicalByproducts,
  rubberElastomers;

  static CategoryType fromString(String value) {
    switch (value) {
      case 'Metal Materials':
        return CategoryType.metalMaterials;
      case 'Plastic Components':
        return CategoryType.plasticComponents;
      case 'Textiles & Fabrics':
        return CategoryType.textilesFabrics;
      case 'Wood & Sawdust':
        return CategoryType.woodSawdust;
      case 'Chemical Byproducts':
        return CategoryType.chemicalByproducts;
      case 'Rubber & Elastomers':
        return CategoryType.rubberElastomers;
      default:
        throw Exception('Invalid CategoryType type: $value');
    }
  }

  String get name {
    switch (this) {
      case CategoryType.metalMaterials:
        return 'Metal Materials';
      case CategoryType.plasticComponents:
        return 'Plastic Components';
      case CategoryType.textilesFabrics:
        return 'Textiles & Fabrics';
      case CategoryType.woodSawdust:
        return 'Wood & Sawdust';
      case CategoryType.chemicalByproducts:
        return 'Chemical Byproducts';
      case CategoryType.rubberElastomers:
        return 'Rubber & Elastomers';
    }
  }
}
