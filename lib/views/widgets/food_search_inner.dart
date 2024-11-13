// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import 'package:app_new/views/widgets/food_shop_card.dart';
import 'package:app_new/views/widgets/video_player.dart';

class FoodSearchInner extends StatefulWidget {
  const FoodSearchInner({super.key});

  @override
  State<FoodSearchInner> createState() => _FoodSearchInnerState();
}

class _FoodSearchInnerState extends State<FoodSearchInner> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(children: [
        Expanded(
          child: Stack(
            textDirection: TextDirection.rtl,
            children: [
              Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            Theme.of(context).primaryColor),
                        iconColor: const WidgetStatePropertyAll(Colors.white)),
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              )
            ],
          ),
        ),

        //const Divider(height: 1.0),
      ]),
    );
  }
}
