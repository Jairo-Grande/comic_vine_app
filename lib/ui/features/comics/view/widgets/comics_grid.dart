import 'package:comic_vine_app/domain/entities/comic_entity.dart'
    as comic_entitie;
import 'package:flutter/material.dart';

class ComicsGrid extends StatelessWidget {
  final List<comic_entitie.Comic> comics;
  // final Future<void> Function() onLoadMore;
  final bool isLoading;

  const ComicsGrid(
      {super.key,
      required this.comics,
      //  required this.onLoadMore,
      required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: comics.length + 1,
      itemBuilder: (context, index) {
        if (index == comics.length) {
          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            //  onLoadMore();
            return const SizedBox.shrink();
          }
        }
        final comic = comics[index];
        return GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            title: Text(comic.name ?? 'No available'),
          ),
          child: GestureDetector(
            onTap: () {},
            child: Image.network(
              comic.image!.originalUrl ?? comic.image!.mediumUrl!,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
