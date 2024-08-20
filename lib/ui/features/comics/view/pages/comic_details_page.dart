import 'package:comic_vine_app/data/model/issues_model.dart';
import 'package:comic_vine_app/domain/entities/comic_entity.dart'
    as comic_entity;
import 'package:comic_vine_app/ui/features/comics/bloc/comics_bloc.dart';
import 'package:comic_vine_app/ui/features/comics/view/widgets/description_text.dart';
import 'package:comic_vine_app/utils/contants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ComicDetailsPage extends StatefulWidget {
  const ComicDetailsPage({
    super.key,
  });

  @override
  State<ComicDetailsPage> createState() => _ComicDetailsPageState();
}

class _ComicDetailsPageState extends State<ComicDetailsPage> {
  String? personCreditNames;
  String? characterNames;
  String? teamNames;
  String? locationNames;
  String? conceptNames;
  String formattedDate = '';

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.yellow[50],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(Const.padding),
                    child: Image.asset(width: 70, height: 50, Assets.appIcon),
                  ),
                  Expanded(child: Container()),
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<IssueBloc>().add(LoadIssueDetails(null, true));
                },
                child: SingleChildScrollView(
                  child: BlocBuilder<IssueBloc, IssueState>(
                    builder: (context, state) {
                      if (state.issueDetailsError != null) {
                        return Text('Error ${state.issuesError}');
                      } else if (state.issueDetailsLoading) {
                        return Container();
                      } else if (state.issueDetails != null) {
                        //function to organize list  person_credits,character_credits,team_credits,location_credits,concept_credits
                        _formatList(state.issueDetails!);

                        return Column(
                          children: [
                            Hero(
                              tag: state.issueDetails!.id!,
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
                                      padding:
                                          const EdgeInsets.all(Const.padding),
                                      child: Image.network(
                                          state.issueDetails!.image!.mediumUrl!,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                        return Opacity(
                                          opacity: 0.7,
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons
                                                    .error, // Icono que se muestra si hay un error al cargar la imagen
                                                size: 80,
                                                color: theme.colorScheme.error,
                                              ),
                                              const Text('error getting image')
                                            ],
                                          ),
                                        );
                                      }, fit: BoxFit.contain),
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
                                        secondaryText:
                                            state.issueDetails!.name),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    DescriptionText(
                                        principalText: 'Issue Number',
                                        secondaryText:
                                            state.issueDetails?.issueNumber),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    DescriptionText(
                                        principalText: 'Volume',
                                        secondaryText:
                                            state.issueDetails!.volume?.name),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    DescriptionText(
                                      principalText: 'First Sold',
                                      secondaryText:
                                          (state.issueDetails?.storeDate !=
                                                  null)
                                              ? formattedDate =
                                                  DateFormat('dd/MMM/yyyy')
                                                      .format(state
                                                          .issueDetails!
                                                          .storeDate!)
                                              : null,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Divider(),
                                    DescriptionText(
                                      principalText: 'Person Credits',
                                      secondaryText: personCreditNames,
                                      titleMode: true,
                                    ),
                                    const Divider(),
                                    DescriptionText(
                                      principalText: 'Characters Credits',
                                      titleMode: true,
                                      secondaryText: characterNames,
                                    ),
                                    const Divider(),
                                    DescriptionText(
                                      principalText: 'Team Credits',
                                      titleMode: true,
                                      secondaryText: teamNames,
                                    ),
                                    const Divider(),
                                    DescriptionText(
                                      principalText: 'Location Credits',
                                      secondaryText: locationNames,
                                      titleMode: true,
                                    ),
                                    const Divider(),
                                    DescriptionText(
                                      principalText: 'Concept Credits',
                                      secondaryText: conceptNames,
                                      titleMode: true,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _formatList(comic_entity.Comic comic) {
    List<String> extractNames(List<CreditModel>? credits) =>
        credits
            ?.map((person) => person.name!)
            .where((name) => name.isNotEmpty)
            .toList() ??
        [];

    final personCreditsNames = extractNames(comic.personCredits);
    final charactersNames = extractNames(comic.characterCredits);
    final teamsNames = extractNames(comic.teamCredits);
    final locationsNames = extractNames(comic.locationCredits);
    final conceptsNames = extractNames(comic.conceptCredits);

    characterNames = charactersNames.join(', ');
    teamNames = teamsNames.join(', ');
    locationNames = locationsNames.join(', ');
    conceptNames = conceptsNames.join(', ');
    personCreditNames = personCreditsNames.join(', ');
  }
}
