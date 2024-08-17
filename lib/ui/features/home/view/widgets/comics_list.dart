import 'package:comic_vine_app/domain/entities/comic.dart' as comic_entitie;
import 'package:flutter/material.dart';

class ComicsList extends StatelessWidget {
  final List<comic_entitie.Comic> comics;
  final Future<void> Function() onLoadMore;
  final bool isLoading;

  const ComicsList(
      {super.key,
      required this.comics,
      required this.onLoadMore,
      required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: comics.length + 1,
      itemBuilder: (context, index) {
        if (index == comics.length) {
          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            onLoadMore();
            return const SizedBox.shrink();
          }
        }
        final comic = comics[index];
        return ListTile(
          contentPadding: const EdgeInsets.all(8.0),
          leading: Image.network(
            //TODO: validate this image.
            comic.image!.originalUrl!,
            width: 100,
            fit: BoxFit.cover,
          ),
          title: Text(comic.name!),
          onTap: () {},
        );
      },
    );
  }
}
