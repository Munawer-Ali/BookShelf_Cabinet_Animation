import 'package:flutter/material.dart';
import '../widgets/bulb_light.dart';

class BookShelfWidget extends StatefulWidget {
  BookShelfWidget({required this.woodVisible, required this.lighteningVisible});
  List<bool> woodVisible;
  bool lighteningVisible;
  
  @override
  _BookShelfWidgetState createState() => _BookShelfWidgetState();
}

class _BookShelfWidgetState extends State<BookShelfWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final originalPositions = [1 / 4, 2 / 4, 3 / 4];
          final stickVisibleRight = constraints.maxWidth * 0.49;
          final stickWidth = constraints.maxWidth * 0.47;
          final stickHeight = 15.0; // adjust if your image aspect differs

          final visibleIndices = <int>[];
          for (int i = 0; i < widget.woodVisible.length; i++) {
            if (widget.woodVisible[i]) visibleIndices.add(i);
          }
          final visibleCount = visibleIndices.length;

          final double margin = 0.28;
          final double available = 1.0 - 2 * margin;
          final targetTopFactors = List<double>.filled(widget.woodVisible.length, 0.0);
          
          for (int i = 0; i < widget.woodVisible.length; i++) {
            if (widget.woodVisible[i]) {
              final rank = visibleIndices.indexOf(i);
              double pos;

              if (visibleCount == 1) {
                pos = 0.5; // center
              } else if (visibleCount == 2) {
                // even spacing like 1/3 and 2/3
                pos = (rank + 1.5) / 4;
              } else {
                // 3 sticks -> use your margin-based spacing
                pos = margin + (available) * (rank / (visibleCount - 1));
              }

              targetTopFactors[i] = pos;
            } else {
              targetTopFactors[i] = originalPositions[i];
            }
          }

          // Build one AnimatedPositioned per original stick (keeps identity stable)
          List<Widget> woods = [];
          for (int i = 0; i < widget.woodVisible.length; i++) {
            final top = constraints.maxHeight * targetTopFactors[i] - stickHeight / 2;
            woods.addAll([
              AnimatedPositioned(
                key: ValueKey('wood_$i'),
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                top: top,
                height: stickHeight.toDouble(),
                right: stickVisibleRight,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  width: widget.woodVisible[i] ? stickWidth : 0, // animate the "mask" width
                  child: ClipRect(
                    child: Align(
                      alignment: Alignment.centerLeft, // reveal from left to right
                      widthFactor: widget.woodVisible[i] ? 1.0 : 0.0, // crops without stretching
                      child: SizedBox(
                        width: stickWidth, // keep the real width of the wood
                        child: Image.asset(
                          'assets/wood.png',
                          fit: BoxFit.fitHeight,
                          width: stickWidth,
                          height: stickHeight,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (widget.woodVisible[i] == true)
                Positioned(
                  top: top + 15,
                  left: constraints.maxWidth * 0.1,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    opacity: widget.lighteningVisible ? 1.0 : 0.0,
                    child: Column(
                      children: [
                        Image.asset('assets/light.png', width: 30),
                        SizedBox(height: constraints.maxHeight * 0.07),
                        BulbLight(
                          width: 140,
                          height: 15,
                          glowColor: Colors.orange.shade300.withOpacity(0.1),
                          glowRadius: 50,
                        ),
                      ],
                    ),
                  ),
                ),
            ]);
          }

          return Stack(
            fit: StackFit.expand,
            children: [
              // background bookshelf (fills the area)
              Positioned.fill(
                child: Image.asset(
                  'assets/bookshelf.png',
                  fit: BoxFit.fill,
                ),
              ),

              // the wood sticks
              ...woods,
              Positioned(
                top: constraints.maxWidth * 0.05,
                left: constraints.maxWidth * 0.1,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  opacity: widget.lighteningVisible ? 1.0 : 0.0,
                  child: Column(
                    children: [
                      Image.asset('assets/light.png', width: 30),
                      SizedBox(height: constraints.maxHeight * 0.07),
                      BulbLight(
                        width: 140,
                        height: 35,
                        glowColor: Colors.orange.shade300.withOpacity(0.1),
                        glowRadius: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
