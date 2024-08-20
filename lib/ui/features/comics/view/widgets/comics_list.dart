import 'package:comic_vine_app/data/model/issues_model.dart';

import 'package:comic_vine_app/ui/features/comics/bloc/comics_bloc.dart';
import 'package:comic_vine_app/ui/features/comics/view/widgets/custom_comic_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ComicsList extends StatefulWidget {
  final List<ComicsModel> comics;
  final ScrollController scrollController;
  final bool isLoading;

  const ComicsList(
      {super.key,
      required this.comics,
      required this.scrollController,
      required this.isLoading});

  @override
  State<ComicsList> createState() => _ComicsListState();
}

class _ComicsListState extends State<ComicsList> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ListView.builder(
          itemCount: widget.comics.length,
          controller: widget.scrollController,
          itemBuilder: (context, index) {
            if (index == widget.comics.length) {
              if (widget.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                //     onLoadMore();
                return const SizedBox.shrink();
              }
            }
            final comic = widget.comics[index];
            return CustomCardProduct(
              comic: comic,
            );
          },
        ),
        BlocBuilder<IssueBloc, IssueState>(
          builder: (context, state) {
            return (state.loadingMoreData)
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: CircularProgressIndicator()),
                  )
                : Container();
          },
        )
      ],
    );
  }
}
