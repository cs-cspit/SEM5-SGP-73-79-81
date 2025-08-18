class Microtexture {
  final String name;
  final List<MicrotextureType> types;

  Microtexture({required this.name, required this.types});
}

class MicrotextureType {
  final String code;
  final String name;
  final String features;
  final String size;
  final String coverage;
  final List<SedimentImage> images;

  MicrotextureType({
    required this.code,
    required this.name,
    required this.features,
    required this.size,
    required this.coverage,
    required this.images,
  });
}

class SedimentImage {
  final String id;
  final String reference;

  SedimentImage({required this.id, required this.reference});
  
  String get assetPath => "assets/sediment_images/$id.png";
}