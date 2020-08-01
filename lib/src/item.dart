import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BarItem extends StatelessWidget {
  const BarItem({
    Key key,
    this.index,
    this.onTap,
    this.iconData,
    this.size,
    this.selected,
    this.unselected,
    this.currentIndex,
    this.title
  }) : super(key: key);

  final int currentIndex;
  final IconData iconData;
  final int index;
  final ValueChanged<double> onTap;
  final Color selected;
  final double size;
  final String title;
  final Color unselected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        onTap(index.toDouble());
      },
      child: Container(
        padding:EdgeInsets.only(top: 7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Icon( iconData, size: size, color: (currentIndex == index) ? selected : unselected ),
          SizedBox(height:2),
          Text(title,textAlign: TextAlign.center,style: TextStyle(fontSize: 10,fontWeight:FontWeight.w700,color:(currentIndex == index) ? selected : unselected  ),)
        ],)
      ),
    );
  }
}

class SpecialBarItem extends StatefulWidget {
  const SpecialBarItem({
    Key key,
    this.color,
    this.duration,
    this.onTap,
    this.index,
    this.animationController,
    this.iconData,
    this.size,
  }) : super(key: key);

  final AnimationController animationController;
  final Color color;
  final Duration duration;
  final IconData iconData;
  final int index;
  final ValueChanged<double> onTap;
  final double size;

  @override
  _SpecialBarItemState createState() => _SpecialBarItemState();
}

class _SpecialBarItemState extends State<SpecialBarItem>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    controller = widget.animationController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        widget.onTap(widget.index.toDouble());
        switch (controller.status) {
          case AnimationStatus.completed:
            controller.reverse();
            break;
          case AnimationStatus.dismissed:
            controller.forward();
            break;
          default:
        }
      },
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          padding: EdgeInsets.all(5),
          child: RotationTransition(
            child: Icon(
              widget.iconData,
              size: widget.size,
            ),
            turns: Tween(begin: 0.0, end: 3 / 8).animate(controller),
          ),
          decoration: BoxDecoration(
            color: widget.color,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

class ActionBarItem extends StatelessWidget {
  const ActionBarItem({
    Key key,
    this.index,
    this.onTap,
    this.mainIndex,
    this.iconData,
    this.size,
    this.color = Colors.transparent,
    this.title = ''
  }) : super(key: key);

  final Color color;
  final IconData iconData;
  final int index;
  final int mainIndex;
  final ValueChanged<double> onTap;
  final double size;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: this.color,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          print(this.index);
          onTap((5 + this.index).toDouble());
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Column(
            mainAxisAlignment:MainAxisAlignment.center,
            children: <Widget>[
          Icon(
            iconData,
            size: size,
          ),
          SizedBox(height: 2,),
          Text(this.title,textAlign: TextAlign.center,style: TextStyle(fontSize:10,color: Colors.black,decoration:TextDecoration.none),) 
          ],)
        ),
      ),
    );
  }
}
