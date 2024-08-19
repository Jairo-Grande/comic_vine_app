import 'package:comic_vine_app/ui/features/comics/view/pages/comic_details_page.dart';
import 'package:comic_vine_app/utils/contants.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  Routes.comicDetails: (context) => const ComicDetailsPage()
};
