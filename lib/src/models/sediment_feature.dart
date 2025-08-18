class SedimentFeature {
  final String codeNumber;
  final String title;
  final String type;
  final String agentsInvolved;
  final String morphologicalFeatures;
  final String origin;
  final String factorsActing;
  final String alteration;
  final String size;
  final String coverage;
  final String environment;
  final List<String> imageRefs;
  final bool isCategory;
  final List<SedimentFeature>? subFeatures;

  const SedimentFeature({
    required this.codeNumber,
    required this.title,
    required this.type,
    required this.agentsInvolved,
    required this.morphologicalFeatures,
    required this.origin,
    required this.factorsActing,
    required this.alteration,
    required this.size,
    required this.coverage,
    required this.environment,
    required this.imageRefs,
    this.isCategory = false,
    this.subFeatures,
  });

  String get displayName => type.isNotEmpty ? "$title - $type" : title;
}
