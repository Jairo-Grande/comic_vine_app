import 'package:comic_vine_app/data/model/issues_model.dart';

class Comic {
  int? id;
  ImageModel? image;
  String? issueNumber;
  String? name;
  DateTime? storeDate;
  VolumeModel? volume;
  List<CreditModel>? personCredits;
  List<CreditModel>? characterCredits;
  List<CreditModel>? conceptCredits;
  List<CreditModel>? locationCredits;
  List<CreditModel>? teamCredits;

  Comic(
      {required this.id,
      required this.image,
      required this.issueNumber,
      required this.name,
      required this.storeDate,
      required this.volume,
      required this.characterCredits,
      required this.conceptCredits,
      required this.locationCredits,
      required this.personCredits,
      required this.teamCredits});
}

class Image {
  String? iconUrl;
  String? mediumUrl;
  String? screenUrl;
  String? screenLargeUrl;
  String? smallUrl;
  String? superUrl;
  String? thumbUrl;
  String? tinyUrl;
  String? originalUrl;
  ImageTags? imageTags;

  Image({
    required this.iconUrl,
    required this.mediumUrl,
    required this.screenUrl,
    required this.screenLargeUrl,
    required this.smallUrl,
    required this.superUrl,
    required this.thumbUrl,
    required this.tinyUrl,
    required this.originalUrl,
    required this.imageTags,
  });
}

enum ImageTags { allImages }

final imageTagsValues = EnumValues({"All Images": ImageTags.allImages});

class Volume {
  String? apiDetailUrl;
  int? id;
  String? name;
  String? siteDetailUrl;

  Volume({this.apiDetailUrl, this.id, this.name, this.siteDetailUrl});
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

class Credit {
  String? apiDetailUrl;
  int? id;
  String? name;
  String? siteDetailUrl;
  String? role;

  Credit({
    required this.apiDetailUrl,
    required this.id,
    required this.name,
    required this.siteDetailUrl,
    required this.role,
  });
}
