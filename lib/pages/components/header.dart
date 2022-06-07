import 'package:flutter/material.dart';
import 'package:phone_book/constants.dart';

class Header extends StatefulWidget {
  const Header({Key? key, required this.size}) : super(key: key);

  final Size size;
  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    // widget.size.height * 0.15,

    print('height: landscape: ${widget.size.height}');
    return Container(
      // zielona poswiata
      height: orientation == Orientation.portrait ? (widget.size.height * 0.15):(widget.size.height > 360 ? (widget.size.height*0.20):(widget.size.height*0.25)),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            // napis twoja lista kontaktow
            padding: EdgeInsets.only(
              left: orientation == Orientation.portrait ? (defaultPadding):(40),
              right: defaultPadding,
            ),
            height: orientation == Orientation.portrait ? (widget.size.height * 0.1):(widget.size.height * 0.2),
            decoration: BoxDecoration(
              color: pColor,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 0, 0),
                  child: Text(
                    'Twoja lista kontaktów',
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                      color: sTextColor, fontWeight: FontWeight.w300, letterSpacing: 2.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
