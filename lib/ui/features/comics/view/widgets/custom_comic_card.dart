import 'package:comic_vine_app/domain/entities/comic_entity.dart'
    as comic_entity;
import 'package:comic_vine_app/ui/features/comics/bloc/comics_bloc.dart';
import 'package:comic_vine_app/ui/features/comics/view/widgets/description_text.dart';
import 'package:comic_vine_app/utils/contants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CustomCardProduct extends StatefulWidget {
  final comic_entity.Comic comic;
  const CustomCardProduct({super.key, required this.comic});

  @override
  State<CustomCardProduct> createState() => _CustomCardProductState();
}

class _CustomCardProductState extends State<CustomCardProduct> {
  late DateTime? storeDate;
  String formattedDate = '';

  @override
  void initState() {

    storeDate = widget.comic.storeDate;
    super.initState();
  }

  late ThemeData theme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //request Issue details to the API.
        context.read<IssueBloc>().add(LoadIssueDetails(widget.comic));

        //Navigate to comicDetailsPage.
        Navigator.pushNamed(context, Routes.comicDetails);
      },
      child: Material(
        elevation: 2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Const.borderRadius),
          child: Padding(
            padding: const EdgeInsets.all(Const.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: widget.comic.id!,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[200]!,
                          width: 5,
                        ),
                      ),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(Const.padding),
                          child: Image.network(widget.comic.image!.mediumUrl!,
                              fit: BoxFit.contain),
                        ),
                      ),
                    ),
                  ),
                ),
                // Añade un espaciado si es necesario
                Container(
                  color: Colors.grey[200],
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(Const.padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DescriptionText(
                          principalText: 'Name',
                          secondaryText: widget.comic.issueNumber,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DescriptionText(
                          principalText: 'Issue Number',
                          secondaryText: widget.comic.issueNumber,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DescriptionText(
                          principalText: 'Volume',
                          secondaryText: widget.comic.volume?.name,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DescriptionText(
                          principalText: 'First Sold: ',
                          secondaryText: (storeDate != null)
                              ? formattedDate =
                                  DateFormat('dd/MMM/yyyy').format(storeDate!)
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
