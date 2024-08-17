import 'package:comic_vine_app/domain/entities/issue.dart';
import 'package:comic_vine_app/domain/entities/comic.dart' as comic_entitie;

class IssuesModel extends Issue {
  IssuesModel(
      {super.error,
      super.limit,
      super.numberOfPageResults,
      super.numberOfTotalResults,
      super.offset,
      super.results,
      super.statusCode,
      super.version});

  factory IssuesModel.fromJson(Map<String, dynamic> json) => IssuesModel(
        error: json["error"],
        limit: json["limit"],
        offset: json["offset"],
        numberOfPageResults: json["number_of_page_results"],
        numberOfTotalResults: json["number_of_total_results"],
        statusCode: json["status_code"],
        results: List<ComicsModel>.from(
            json["results"].map((x) => ComicsModel.fromJson(x))),
        version: json["version"],
      );
}

class ComicsModel extends comic_entitie.Comic {
  ComicsModel(
      {super.id,
      super.name,
      super.issueNumber,
      super.storeDate,
      super.volume,
      super.image});

  factory ComicsModel.fromJson(Map<String, dynamic> json) => ComicsModel(
        id: json["id"],
        image: ImageModel.fromJson(json["image"]),
        issueNumber: json["issue_number"],
        name: json["name"],
        storeDate: json["store_date"] == null
            ? null
            : DateTime.parse(json["store_date"]),
        volume: VolumeModel.fromJson(json["volume"]),
      );
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
        imageTags: comic_entitie.imageTagsValues.map[json["image_tags"]]!,
      );
}

class VolumeModel extends comic_entitie.Volume {
  VolumeModel({super.apiDetailUrl, super.id, super.name, super.siteDetailUrl});
  factory VolumeModel.fromJson(Map<String, dynamic> json) => VolumeModel(
        apiDetailUrl: json["api_detail_url"],
        id: json["id"],
        name: json["name"],
        siteDetailUrl: json["site_detail_url"],
      );
}
