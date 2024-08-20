import 'package:comic_vine_app/ui/features/comics/bloc/comics_bloc.dart';
import 'package:comic_vine_app/ui/features/comics/view/widgets/comics_list.dart';
import 'package:comic_vine_app/ui/features/comics/view/widgets/search_bar.dart';
import 'package:comic_vine_app/utils/contants.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  TextEditingController textController = TextEditingController();

  int offset = 0;

  @override
  void initState() {
    //Request Issues
    context.read<IssueBloc>().add(LoadIssues());

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !context.read<IssueBloc>().state.loadingMoreData) {
        _loadMoreData();
      }
    });

    super.initState();
  }

  _loadMoreData() {
    context
        .read<IssueBloc>()
        .add(LoadIssues(offset: offset += 11, loadingMoreData: true));
    print('offsetttt: $offset');
  }

  @override
  Widget build(BuildContext context) {
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
                    child: Image.asset(
                      width: 70,
                      height: 50,
                      Assets.appIcon,
                    ),
                  ),
                  Flexible(
                      child: CustomSearchBar(
                    controller: textController,
                    onChanged: (p0) {
                      context
                          .read<IssueBloc>()
                          .add(SearchComic(text: textController.text));
                    },
                  )),
                  const SizedBox(width: 20)
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.grey[100],
                child: BlocBuilder<IssueBloc, IssueState>(
                  builder: (context, state) {
                    return (state.issuesLoading)
                        ? const Center(child: CircularProgressIndicator())
                        : (state.issuesError != null && state.issuesError != '')
                            ? Center(
                                child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Error ${state.issuesError}'),
                                  TextButton(
                                      onPressed: () {
                                        //aumentar solo si la solicitud es positiva.....
                                        context
                                            .read<IssueBloc>()
                                            .add(LoadIssues(offset: offset+11));

                                        print('offsetttt: $offset');
                                      },
                                      child: const Text('Try Again'))
                                ],
                              ))
                            : (state.issues != null)
                                ? ComicsList(
                                    comics: state.filteredIssues!,
                                    isLoading: false,
                                    scrollController: _scrollController)
                                : Container();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
