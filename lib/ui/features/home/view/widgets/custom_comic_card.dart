import 'package:comic_vine_app/utils/contants.dart';
import 'package:flutter/material.dart';

class CustomCardProduct extends StatefulWidget {
  const CustomCardProduct({super.key});

  @override
  State<CustomCardProduct> createState() => _CustomCardProductState();
}

class _CustomCardProductState extends State<CustomCardProduct> {
  @override
  void initState() {
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
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        elevation: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Const.borderRadius),
          child: Container(
            decoration: BoxDecoration(
              // Aquí puedes añadir más decoración si es necesario
            ),
            child: Padding(
              padding: const EdgeInsets.all(Const.padding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 200, // Ajusta el ancho según tus necesidades
                    height: 400, // Ajusta el alto según tus necesidades
                    child: AspectRatio(
                      aspectRatio: 1,
                       // Proporción de la imagen
                      child: Image.asset(Assets.appIcon, fit: BoxFit.contain),
                    ),
                  ),
                  SizedBox(width: 8), // Añade un espaciado si es necesario
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('data'),
                      Text('data'),
                      Text('data'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }}
