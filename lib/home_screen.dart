import 'dart:math';

import 'package:flutter/material.dart';
import 'package:water_bottle_animation/bottle_painter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  double initialQuantity = 0.00;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const  Duration(milliseconds: 200),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey.shade300,
      floatingActionButton:
      initialQuantity < 0.95 ?
      FloatingActionButton.extended(
        onPressed: (){
          ///handle animations controller
          if(_animationController.status == AnimationStatus.completed){
            _animationController.reverse();
          } else {
            _animationController.forward();
          }
          ///Add water
          if(initialQuantity <= 0.95){
            setState(() {
              initialQuantity += 0.1;
            });
          }

          ///snack bar

            Scaffold.of(context).showBottomSheet((context) => const Text("Filled with water"));


      },
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        label: const  Text("Water"),
        icon: const  Icon(Icons.add),
      ) :
      FloatingActionButton.extended(
      onPressed: (){
        setState(() {
          initialQuantity = 0;
        });
      },
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Colors.white,
      label: const  Text("Empty"),
      icon: const  Icon(Icons.clear),
      ),

      body: Center(
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child){
                final sineValue = sin(6* pi * _animationController.value);
                return Transform.translate(
                  offset: Offset(sineValue*10, 0),
                  child: child,
                  );
                },
          child: CustomPaint(
            size: const Size(
              200,
              500,
            ),
            painter: BottlePainter(waterHeightFraction: initialQuantity),

          ),

            ),
            Positioned(
                top: 0,
                left: 20,
                child: Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(20)),
                ),
            ),
            Positioned(
                top: 250,
                child: Container(
                  width: 200,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color:
                    Theme.of(context).colorScheme.primary.withOpacity(0.6),
                  ),
                  child: Text(
                    "${(initialQuantity * 500).ceilToDouble().toInt()} ML",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
            ),
          ],
        ),
      ),

    );
  }
}
