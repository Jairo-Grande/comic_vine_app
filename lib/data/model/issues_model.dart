import 'dart:convert';

import 'package:comic_vine_app/domain/entities/issue_entity.dart';
import 'package:comic_vine_app/domain/entities/comic_entity.dart'
    as comic_entitie;

class IssuesModel extends Issues {
  IssuesModel(
      {super.error,
      super.limit,
      super.numberOfPageResults,
      super.numberOfTotalResults,
      super.issueNumber,
      super.offset,
      super.results,
      super.statusCode,
      super.version});

  factory IssuesModel.fromJson(Map<String, dynamic> json) => IssuesModel(
        error: json["error"],
        limit: json["limit"],
        offset: json["offset"],
        issueNumber: json["issue_number"],
        numberOfPageResults: json["number_of_page_results"],
        numberOfTotalResults: json["number_of_total_results"],
        statusCode: json["status_code"],
        //The servide to find Issue by Id return unique object, is necesary validate becouse is used twice.
        results: json["results"] != null
            ? (json["results"] is List
                ? List<ComicsModel>.from(
                    json["results"].map((x) => ComicsModel.fromJson(x)))
                : [ComicsModel.fromJson(json["results"])])
            : null,
        version: json["version"],
      );

  IssuesModel copyWith({
    String? error,
    int? limit,
    int? offset,
    String? issueNumber,
    int? numberOfPageResults,
    int? numberOfTotalResults,
    int? statusCode,
    List<ComicsModel>? results,
    String? version,
  }) {
    return IssuesModel(
      error: error ?? this.error,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      issueNumber: issueNumber ?? this.issueNumber,
      numberOfPageResults: numberOfPageResults ?? this.numberOfPageResults,
      numberOfTotalResults: numberOfTotalResults ?? this.numberOfTotalResults,
      statusCode: statusCode ?? this.statusCode,
      results: results ?? this.results,
      version: version ?? this.version,
    );
  }
}

class ComicsModel extends comic_entitie.Comic {
  ComicsModel(
      {super.id,
      super.name,
      super.issueNumber,
      super.storeDate,
      super.volume,
      super.image,
      super.characterCredits,
      super.conceptCredits,
      super.locationCredits,
      super.personCredits,
      super.teamCredits});

  factory ComicsModel.fromJson(Map<String, dynamic> json) => ComicsModel(
        id: json["id"],
        image: json["image"] != null
            ? (json["image"] is String
                ? ImageModel.fromJson(jsonDecode(json["image"]))
                : ImageModel.fromJson(json["image"]))
            : null,
        issueNumber: json["issue_number"],
        name: json["name"],
        storeDate: json["store_date"] == null
            ? null
            : (json["store_date"] is String
                ? DateTime.parse(json["store_date"])
                : json["store_date"]),
        volume: json["volume"] != null
            ? (json["volume"] is String
                ? VolumeModel.fromJson(jsonDecode(json["volume"]))
                : VolumeModel.fromJson(json["volume"]))
            : null,
        characterCredits: json["character_credits"] != null
            ? (json["character_credits"] is String
                ? List<CreditModel>.from(jsonDecode(json["character_credits"])
                    .map((x) => CreditModel.fromJson(x)))
                : List<CreditModel>.from(json["character_credits"]
                    .map((x) => CreditModel.fromJson(x))))
            : null,
        conceptCredits: json["concept_credits"] != null
            ? (json["concept_credits"] is String
                ? List<CreditModel>.from(jsonDecode(json["concept_credits"])
                    .map((x) => CreditModel.fromJson(x)))
                : List<CreditModel>.from(json["concept_credits"]
                    .map((x) => CreditModel.fromJson(x))))
            : null,
        locationCredits: json["location_credits"] != null
            ? (json["location_credits"] is String
                ? List<CreditModel>.from(jsonDecode(json["location_credits"])
                    .map((x) => CreditModel.fromJson(x)))
                : List<CreditModel>.from(json["location_credits"]
                    .map((x) => CreditModel.fromJson(x))))
            : null,
        personCredits: json["person_credits"] != null
            ? (json["person_credits"] is String
                ? List<CreditModel>.from(jsonDecode(json["person_credits"])
                    .map((x) => CreditModel.fromJson(x)))
                : List<CreditModel>.from(
                    json["person_credits"].map((x) => CreditModel.fromJson(x))))
            : null,
        teamCredits: json["team_credits"] != null
            ? (json["team_credits"] is String
                ? List<CreditModel>.from(jsonDecode(json["team_credits"])
                    .map((x) => CreditModel.fromJson(x)))
                : List<CreditModel>.from(
                    json["team_credits"].map((x) => CreditModel.fromJson(x))))
            : null,
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'issue_number': issueNumber,
      "store_date": storeDate?.toIso8601String(),
      "image": image != null ? jsonEncode(image!.toJson()) : null,
      'volume': volume != null ? jsonEncode(volume!.toJson()) : null,
      "character_credits": characterCredits != null
          ? jsonEncode(characterCredits!.map((x) => x.toJson()).toList())
          : null,
      "concept_credits": conceptCredits != null
          ? jsonEncode(conceptCredits!.map((x) => x.toJson()).toList())
          : null,
      "location_credits": locationCredits != null
          ? jsonEncode(locationCredits!.map((x) => x.toJson()).toList())
          : null,
      "person_credits": personCredits != null
          ? jsonEncode(personCredits!.map((x) => x.toJson()).toList())
          : null,
      "team_credits": teamCredits != null
          ? jsonEncode(teamCredits!.map((x) => x.toJson()).toList())
          : null,
    };
  }

  ComicsModel copyWith({
    int? id,
    String? name,
    String? issueNumber,
    DateTime? storeDate,
    VolumeModel? volume,
    ImageModel? image,
    List<CreditModel>? characterCredits,
    List<CreditModel>? conceptCredits,
    List<CreditModel>? locationCredits,
    List<CreditModel>? personCredits,
    List<CreditModel>? teamCredits,
  }) {
    return ComicsModel(
      id: id ?? this.id,
      name: name ?? this.name,
      issueNumber: issueNumber ?? this.issueNumber,
      storeDate: storeDate ?? this.storeDate,
      volume: volume ?? this.volume,
      image: image ?? this.image,
      characterCredits: characterCredits ?? this.characterCredits,
      conceptCredits: conceptCredits ?? this.conceptCredits,
      locationCredits: locationCredits ?? this.locationCredits,
      personCredits: personCredits ?? this.personCredits,
      teamCredits: teamCredits ?? this.teamCredits,
    );
  }
}

class ImageModel extends comic_entitie.Image {
  ImageModel(
      {super.iconUrl,
      super.imageTags,
      super.mediumUrl,
      super.originalUrl,
      super.screenLargeUrl,
      super.screenUrl,
      super.smallUrl,
      super.superUrl,
      super.thumbUrl,
      super.tinyUrl});

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        iconUrl: json["icon_url"],
        mediumUrl: json["medium_url"],
        screenUrl: json["screen_url"],
        screenLargeUrl: json["screen_large_url"],
        smallUrl: json["small_url"],
        superUrl: json["super_url"],
        thumbUrl: json["thumb_url"],
        tinyUrl: json["tiny_url"],
        originalUrl: json["original_url"],
        imageTags: json["image_tags"] != null
            ? comic_entitie.imageTagsValues.map[json["image_tags"]]
            : null,
      );

  Map<String, dynamic> toJson() => {
        "icon_url": iconUrl,
        "medium_url": mediumUrl,
        "screen_url": screenUrl,
        "screen_large_url": screenLargeUrl,
        "small_url": smallUrl,
        "super_url": superUrl,
        "thumb_url": thumbUrl,
        "tiny_url": tinyUrl,
        "original_url": originalUrl
      };
}

class VolumeModel extends comic_entitie.Volume {
  VolumeModel({
    super.apiDetailUrl,
    super.id,
    super.name,
    super.siteDetailUrl,
  });
  factory VolumeModel.fromJson(Map<String, dynamic> json) => VolumeModel(
      apiDetailUrl: json["api_detail_url"],
      id: json["id"],
      name: json["name"],
      siteDetailUrl: json["site_detail_url"]);

  Map<String, dynamic> toJson() => {
        "api_detail_url": apiDetailUrl,
        "id": id,
        "name": name,
        "site_detail_url": siteDetailUrl,
      };
}

class CreditModel extends comic_entitie.Credit {
  CreditModel(
      {super.apiDetailUrl,
      super.id,
      super.name,
      super.siteDetailUrl,
      super.role});

  factory CreditModel.fromJson(Map<String, dynamic> json) => CreditModel(
        apiDetailUrl: json["api_detail_url"],
        id: json["id"],
        name: json["name"],
        siteDetailUrl: json["site_detail_url"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "api_detail_url": apiDetailUrl,
        "id": id,
        "name": name,
        "site_detail_url": siteDetailUrl,
      };
}
