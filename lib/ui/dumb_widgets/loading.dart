import 'package:flutter/material.dart';

class STLoading extends StatefulWidget {
  @override
  _STLoadingState createState() => _STLoadingState();
  final double height;

  STLoading({this.height = 50});
}

class _STLoadingState extends State<STLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  final alignment1 = Alignment.topLeft;
  final alignment2 = Alignment.topRight;
  final alignment3 = Alignment.bottomLeft;
  final alignment4 = Alignment.bottomRight;

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 1),
    );

    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var innerContainerHeight = widget.height * 0.20;
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget? _widget) {
        return Transform.rotate(
          angle: animationController.value * 6.3,
          child: _widget,
        );
      },
      child: Transform.rotate(
        angle: animationController.value * 6.3,
        child: Container(
          padding: EdgeInsets.all(widget.height <= 30 ? 5 : 10),
          height: widget.height,
          width: widget.height,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Stack(
            children: [
              AnimatedContainer(
                alignment: alignment1,
                curve: Curves.easeIn,
                duration: Duration(milliseconds: 200),
                child: Container(
                  height: innerContainerHeight,
                  width: innerContainerHeight,
                  decoration: BoxDecoration(
                    color: Color(0xff36C5F0),
                    borderRadius: BorderRadius.circular(innerContainerHeight),
                  ),
                ),
              ),
              AnimatedContainer(
                alignment: alignment2,
                curve: Curves.easeIn,
                duration: Duration(milliseconds: 200),
                child: Container(
                  height: innerContainerHeight,
                  width: innerContainerHeight,
                  decoration: BoxDecoration(
                    color: Color(0xffECB22E),
                    borderRadius: BorderRadius.circular(innerContainerHeight),
                  ),
                ),
              ),
              AnimatedContainer(
                alignment: alignment3,
                curve: Curves.easeIn,
                duration: Duration(milliseconds: 200),
                child: Container(
                  height: innerContainerHeight,
                  width: innerContainerHeight,
                  decoration: BoxDecoration(
                    color: Color(0xff2EB67D),
                    borderRadius: BorderRadius.circular(innerContainerHeight),
                  ),
                ),
              ),
              AnimatedContainer(
                alignment: alignment4,
                curve: Curves.easeIn,
                duration: Duration(milliseconds: 200),
                child: Container(
                  height: innerContainerHeight,
                  width: innerContainerHeight,
                  decoration: BoxDecoration(
                    color: Color(0xffE01E5A),
                    borderRadius: BorderRadius.circular(innerContainerHeight),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
