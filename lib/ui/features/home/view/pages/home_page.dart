import 'package:comic_vine_app/ui/features/home/view/widgets/custom_comic_card.dart';
import 'package:comic_vine_app/utils/contants.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                    child: Image.asset(width: 70, height: 50, Assets.appIcon),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(          
                itemCount: 10,
                itemBuilder: (context, index) {
                  return CustomCardProduct();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
