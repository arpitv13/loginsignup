import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

//arrowCard - Card with an arrow on the right side
class arrowCard extends StatelessWidget {
  final String cardTitle;
  final String cardItems;

  @override
  arrowCard({
    @required this.cardItems,
    @required this.cardTitle
  });
  Widget build(BuildContext context) {
    return new Card(
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(2.0),
      ),
      margin: EdgeInsets.fromLTRB(16, 1, 16, 0),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: Column(
                    children: <Widget>[
                      Text(
                        '$cardTitle',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
//                  padding: const EdgeInsets.only(right:20.0),
//                  color: Colors.red,
                  child: Text(
                    '$cardItems',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: const Color(0xff838383),
                             ),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Container(
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: SvgPicture.string(
                      '<svg viewBox="35.1 7.7 14.2 7.5" ><path transform="matrix(0.0, -1.0, 1.0, 0.0, 6316.04, 12517.92)" d="M 12502.7724609375 -6280.89404296875 L 12510.24609375 -6273.658203125 L 12502.7724609375 -6266.6884765625" fill="none" stroke="#000000" stroke-width="1.600000023841858" stroke-miterlimit="4" stroke-linecap="round" /></svg>',
                      allowDrawingOutsideViewBox: true,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}