import 'package:page_view_indicators/circle_page_indicator.dart';

import '../importLib.dart';
import 'package:http/http.dart' as http;

//MediaQueryData queryData;
//queryData = MediaQuery.of(context);
//var h = MediaQuery.of(context).size.height;
//var w = MediaQuery.of(context).size.width;
PageController _controller = PageController(
  initialPage: 0,
);
final _currentPageNotifier = ValueNotifier<int>(0);

_buildCircleIndicator() {
  return Positioned(
    left: 0.0,
    right: 0.0,
    bottom: 0.0,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: CirclePageIndicator(
        itemCount: 4,
        currentPageNotifier: _currentPageNotifier,
      ),
    ),
  );
}

class intro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Center(
      child: Stack(
        children: <Widget>[
          NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowGlow();
            },
            child: PageView(
                controller: _controller,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  intro1(),
                  intro2(),
                  intro3(),
                  LoginPage(),
                ],
                onPageChanged: (int index) {
                  _currentPageNotifier.value = index;
                  print(index);
                }),
          ),
          _buildCircleIndicator(),
        ],
      ),
    ));
  }
}

class intro1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: size.height / 5,
//            color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Getting Started',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 18,
                        color: const Color(0xff131313),
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.string(
                      '<svg viewBox="94.0 250.9 60.2 217.4" ><path transform="translate(-30.43, 228.03)" d="M 140.9253540039063 47.35828399658203 L 145.0202331542969 46.69258117675781 C 144.2461242675781 40.73992919921875 146.3206787109375 34.74857330322266 143.4720458984375 28.88881492614746 C 142.2257995605469 26.34209632873535 144.40869140625 23.2148265838623 147.4740295410156 23.06001472473145 C 152.2655639648438 22.82779121398926 157.0803527832031 22.83552742004395 161.8718566894531 23.06001472473145 C 164.85205078125 23.19160652160645 167.1046142578125 26.28791236877441 165.69580078125 28.56369972229004 C 163.5051879882813 32.12445068359375 164.3024597167969 35.82453918457031 164.1476440429688 39.50140380859375 C 164.0469970703125 41.66107940673828 164.1476440429688 43.82849884033203 164.1476440429688 46.20490264892578 L 168.2192687988281 47.22669219970703 C 167.4451904296875 48.43425750732422 166.7717895507813 49.39410400390625 166.22216796875 50.42362976074219 C 165.7572631835938 51.10021209716797 165.4697875976563 51.88276672363281 165.3861389160156 52.69941711425781 C 165.8505859375 65.49748992919922 166.3666687011719 78.29296875 166.934326171875 91.08588409423828 C 167.1510314941406 96.08642578125 169.6281127929688 99.95680999755859 173.3281860351563 103.1537399291992 C 175.2246704101563 104.7947769165039 177.1521301269531 106.4126052856445 178.9402465820313 108.1697616577148 C 183.0815734863281 112.249137878418 184.6064758300781 117.1722640991211 184.583251953125 123.047492980957 C 184.4129638671875 155.7522430419922 184.4980773925781 188.4569854736328 184.4903869628906 221.1539916992188 C 184.6094970703125 224.4604644775391 184.5423278808594 227.7710266113281 184.2891235351563 231.0699157714844 C 183.793701171875 235.4124755859375 181.0612182617188 238.268798828125 176.7496032714844 238.7564697265625 C 162.0421447753906 240.4284973144531 147.3346862792969 240.8851928710938 132.6272277832031 239.1048278808594 C 127.7350769042969 238.5087890625 124.9716186523438 235.2344360351563 124.5303955078125 229.9242858886719 C 124.3136596679688 227.3156433105469 124.5303955078125 224.6760406494141 124.5303955078125 222.0441741943359 C 124.5303955078125 189.3471832275391 124.6852111816406 156.6424407958984 124.4297790527344 123.9377059936523 C 124.3755798339844 116.1969528198242 127.0074462890625 110.2055892944336 132.9446105957031 105.824333190918 C 139.8338623046875 100.738639831543 142.6205749511719 94.25961303710938 142.6050720214844 85.79895782470703 C 142.6050720214844 75.2869873046875 143.379150390625 64.77503967285156 143.7584838867188 54.26306915283203 C 143.8204040527344 52.71491241455078 144.6486511230469 50.72554016113281 141.8619995117188 50.33075714111328 C 141.4826965332031 50.27655792236328 141.3123779296875 48.64325714111328 140.9253540039063 47.35828399658203 Z" fill="#ededed" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><defs><linearGradient id="gradient" x1="0.5" y1="0.0" x2="0.5" y2="1.0"><stop offset="0.0" stop-color="#fffa6e64"  /><stop offset="1.0" stop-color="#ffe00d4a"  /></linearGradient></defs><path transform="translate(98.08, 284.47)" d="M 51.58160781860352 153.0259704589844 C 51.52397155761719 156.0016174316406 51.45706939697266 159.4322357177734 51.39062881469727 162.8628540039063 C 51.37870788574219 163.8488464355469 51.41428375244141 164.8348693847656 51.49710464477539 165.8164978027344 C 52.00592803955078 171.9716033935547 49.80497741699219 175.6887817382813 44.44459915161133 177.0685119628906 C 41.72688293457031 177.7777404785156 38.95010375976563 178.1571655273438 36.16138458251953 178.2003326416016 C 28.38701820373535 178.2628936767578 20.61466789245605 178.1601867675781 12.84425449371338 177.8923034667969 C 10.73602962493896 177.7610931396484 8.654657363891602 177.2943420410156 6.661453247070313 176.5058898925781 C 3.30357813835144 175.3048248291016 1.040128231048584 171.7514038085938 1.093954682350159 167.7655334472656 C 1.04935085773468 164.1632690429688 1.004455924034119 160.5610504150391 0.9503920078277588 156.2521820068359 C 0.9445505142211914 155.7864990234375 0.9324969053268433 154.8272552490234 0.9202083349227905 153.8507537841797 C 0.8594057559967041 149.0191192626953 51.65253829956055 149.3643341064453 51.58160781860352 153.0259704589844 Z" fill="url(#gradient)" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                      allowDrawingOutsideViewBox: true,
                    ),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Responsible Drinking',
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 18,
                            color: const Color(0xff131313),
                            fontWeight: FontWeight.w800,
                            height: 1.7777777777777777,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Text(
                            'Lorem dolor sit amet consectetur adipisicing elit, sed do eiusmod tempor incididunt ut ero labore et dolore',
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 14,
                              color: const Color(0xff131313),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          _controller.animateToPage(3,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(45, 10, 45, 10),
                          decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.black),
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            'Skip',
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 15.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _controller.animateToPage(1,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(45, 10, 45, 10),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.black),
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            'Next',
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 15.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}

class intro2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: size.height / 5,
//            color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Getting Started',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 18,
                        color: const Color(0xff131313),
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.string(
                      '<svg viewBox="94.0 250.9 60.2 217.4" ><path transform="translate(-30.43, 228.03)" d="M 140.9253540039063 47.35828399658203 L 145.0202331542969 46.69258117675781 C 144.2461242675781 40.73992919921875 146.3206787109375 34.74857330322266 143.4720458984375 28.88881492614746 C 142.2257995605469 26.34209632873535 144.40869140625 23.2148265838623 147.4740295410156 23.06001472473145 C 152.2655639648438 22.82779121398926 157.0803527832031 22.83552742004395 161.8718566894531 23.06001472473145 C 164.85205078125 23.19160652160645 167.1046142578125 26.28791236877441 165.69580078125 28.56369972229004 C 163.5051879882813 32.12445068359375 164.3024597167969 35.82453918457031 164.1476440429688 39.50140380859375 C 164.0469970703125 41.66107940673828 164.1476440429688 43.82849884033203 164.1476440429688 46.20490264892578 L 168.2192687988281 47.22669219970703 C 167.4451904296875 48.43425750732422 166.7717895507813 49.39410400390625 166.22216796875 50.42362976074219 C 165.7572631835938 51.10021209716797 165.4697875976563 51.88276672363281 165.3861389160156 52.69941711425781 C 165.8505859375 65.49748992919922 166.3666687011719 78.29296875 166.934326171875 91.08588409423828 C 167.1510314941406 96.08642578125 169.6281127929688 99.95680999755859 173.3281860351563 103.1537399291992 C 175.2246704101563 104.7947769165039 177.1521301269531 106.4126052856445 178.9402465820313 108.1697616577148 C 183.0815734863281 112.249137878418 184.6064758300781 117.1722640991211 184.583251953125 123.047492980957 C 184.4129638671875 155.7522430419922 184.4980773925781 188.4569854736328 184.4903869628906 221.1539916992188 C 184.6094970703125 224.4604644775391 184.5423278808594 227.7710266113281 184.2891235351563 231.0699157714844 C 183.793701171875 235.4124755859375 181.0612182617188 238.268798828125 176.7496032714844 238.7564697265625 C 162.0421447753906 240.4284973144531 147.3346862792969 240.8851928710938 132.6272277832031 239.1048278808594 C 127.7350769042969 238.5087890625 124.9716186523438 235.2344360351563 124.5303955078125 229.9242858886719 C 124.3136596679688 227.3156433105469 124.5303955078125 224.6760406494141 124.5303955078125 222.0441741943359 C 124.5303955078125 189.3471832275391 124.6852111816406 156.6424407958984 124.4297790527344 123.9377059936523 C 124.3755798339844 116.1969528198242 127.0074462890625 110.2055892944336 132.9446105957031 105.824333190918 C 139.8338623046875 100.738639831543 142.6205749511719 94.25961303710938 142.6050720214844 85.79895782470703 C 142.6050720214844 75.2869873046875 143.379150390625 64.77503967285156 143.7584838867188 54.26306915283203 C 143.8204040527344 52.71491241455078 144.6486511230469 50.72554016113281 141.8619995117188 50.33075714111328 C 141.4826965332031 50.27655792236328 141.3123779296875 48.64325714111328 140.9253540039063 47.35828399658203 Z" fill="#ededed" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><defs><linearGradient id="gradient" x1="0.5" y1="0.0" x2="0.5" y2="1.0"><stop offset="0.0" stop-color="#fffa6e64"  /><stop offset="1.0" stop-color="#ffe00d4a"  /></linearGradient></defs><path transform="translate(97.94, 266.73)" d="M 52.12551879882813 128.0990905761719 C 51.88455963134766 145.9820098876953 51.53778839111328 163.8648681640625 51.2027587890625 181.7476806640625 C 51.19091796875 182.7602691650391 51.22625350952148 183.7728576660156 51.30852508544922 184.7809143066406 C 51.81399154663086 191.1018218994141 49.62760162353516 194.9191284179688 44.30270385742188 196.3360443115234 C 41.60297393798828 197.0643463134766 38.84457397460938 197.4539794921875 36.07431411743164 197.4983673095703 C 28.35140419006348 197.5625457763672 20.63049697875977 197.4571075439453 12.91151142120361 197.1819915771484 C 10.81723976135254 197.0472564697266 8.749643325805664 196.5679321289063 6.769630432128906 195.7582702636719 C 3.433980226516724 194.5248260498047 1.185511231422424 190.8756713867188 1.238981366157532 186.7824554443359 C 1.007816791534424 167.4827270507813 0.7687897086143494 148.1852722167969 0.5219393968582153 128.8901062011719 C -0.2164045572280884 114.5547332763672 53.12401962280273 116.9082107543945 52.12551879882813 128.0990905761719 Z" fill="url(#gradient)" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                      allowDrawingOutsideViewBox: true,
                    ),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Legal age and location',
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 18,
                            color: const Color(0xff131313),
                            fontWeight: FontWeight.w800,
                            height: 1.7777777777777777,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Text(
                            'Lorem dolor sit amet consectetur adipisicing elit, sed do eiusmod tempor incididunt ut ero labore et dolore',
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 14,
                              color: const Color(0xff131313),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          _controller.animateToPage(4,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(45, 10, 45, 10),
                          decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.black),
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            'Skip',
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 15.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _controller.animateToPage(2,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(45, 10, 45, 10),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.black),
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            'Next',
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 15.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}

class intro3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: size.height / 5,
//            color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Getting Started',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 18,
                        color: const Color(0xff131313),
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.string(
                      '<svg viewBox="94.0 250.9 60.2 217.4" ><path transform="translate(-30.43, 228.03)" d="M 140.9253540039063 47.35828399658203 L 145.0202331542969 46.69258117675781 C 144.2461242675781 40.73992919921875 146.3206787109375 34.74857330322266 143.4720458984375 28.88881492614746 C 142.2257995605469 26.34209632873535 144.40869140625 23.2148265838623 147.4740295410156 23.06001472473145 C 152.2655639648438 22.82779121398926 157.0803527832031 22.83552742004395 161.8718566894531 23.06001472473145 C 164.85205078125 23.19160652160645 167.1046142578125 26.28791236877441 165.69580078125 28.56369972229004 C 163.5051879882813 32.12445068359375 164.3024597167969 35.82453918457031 164.1476440429688 39.50140380859375 C 164.0469970703125 41.66107940673828 164.1476440429688 43.82849884033203 164.1476440429688 46.20490264892578 L 168.2192687988281 47.22669219970703 C 167.4451904296875 48.43425750732422 166.7717895507813 49.39410400390625 166.22216796875 50.42362976074219 C 165.7572631835938 51.10021209716797 165.4697875976563 51.88276672363281 165.3861389160156 52.69941711425781 C 165.8505859375 65.49748992919922 166.3666687011719 78.29296875 166.934326171875 91.08588409423828 C 167.1510314941406 96.08642578125 169.6281127929688 99.95680999755859 173.3281860351563 103.1537399291992 C 175.2246704101563 104.7947769165039 177.1521301269531 106.4126052856445 178.9402465820313 108.1697616577148 C 183.0815734863281 112.249137878418 184.6064758300781 117.1722640991211 184.583251953125 123.047492980957 C 184.4129638671875 155.7522430419922 184.4980773925781 188.4569854736328 184.4903869628906 221.1539916992188 C 184.6094970703125 224.4604644775391 184.5423278808594 227.7710266113281 184.2891235351563 231.0699157714844 C 183.793701171875 235.4124755859375 181.0612182617188 238.268798828125 176.7496032714844 238.7564697265625 C 162.0421447753906 240.4284973144531 147.3346862792969 240.8851928710938 132.6272277832031 239.1048278808594 C 127.7350769042969 238.5087890625 124.9716186523438 235.2344360351563 124.5303955078125 229.9242858886719 C 124.3136596679688 227.3156433105469 124.5303955078125 224.6760406494141 124.5303955078125 222.0441741943359 C 124.5303955078125 189.3471832275391 124.6852111816406 156.6424407958984 124.4297790527344 123.9377059936523 C 124.3755798339844 116.1969528198242 127.0074462890625 110.2055892944336 132.9446105957031 105.824333190918 C 139.8338623046875 100.738639831543 142.6205749511719 94.25961303710938 142.6050720214844 85.79895782470703 C 142.6050720214844 75.2869873046875 143.379150390625 64.77503967285156 143.7584838867188 54.26306915283203 C 143.8204040527344 52.71491241455078 144.6486511230469 50.72554016113281 141.8619995117188 50.33075714111328 C 141.4826965332031 50.27655792236328 141.3123779296875 48.64325714111328 140.9253540039063 47.35828399658203 Z" fill="#ededed" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><defs><linearGradient id="gradient" x1="0.5" y1="0.0" x2="0.5" y2="1.0"><stop offset="0.0" stop-color="#fffa6e64"  /><stop offset="1.0" stop-color="#ffe00d4a"  /></linearGradient></defs><path transform="translate(98.46, 269.25)" d="M 51.62499618530273 81.64683532714844 C 51.62499618530273 100.6822357177734 51.22459030151367 119.717643737793 50.90999984741211 138.7530670166016 C 50.67548751831055 153.1319580078125 50.33800888061523 167.5108337402344 50.0119514465332 181.8896331787109 C 50.00042724609375 182.7037963867188 50.03481674194336 183.5179901123047 50.11488342285156 184.3285369873047 C 50.6068115234375 189.4109191894531 48.47896957397461 192.4802703857422 43.29666519165039 193.6195220947266 C 40.66923141479492 194.2051239013672 37.98469161987305 194.5184478759766 35.28861618041992 194.5541076660156 C 27.77251243591309 194.6057434082031 20.25835800170898 194.5209350585938 12.74607372283936 194.2997283935547 C 10.70788288116455 194.1913909912109 8.695653915405273 193.8059844970703 6.768662452697754 193.1549682617188 C 3.522335529327393 192.1632232666016 1.334076404571533 189.2290954589844 1.386114954948425 185.9378967285156 C 1.161140561103821 170.4197540283203 0.9285141825675964 154.9034881591797 0.6882740259170532 139.3890686035156 C 0.41372150182724 120.0329055786133 -0.03244563192129135 100.6767272949219 0.001866240869276226 81.32054901123047 C 0.001865938422270119 72.37248992919922 51.62499618530273 71.75305938720703 51.62499618530273 81.64683532714844 Z" fill="url(#gradient)" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                      allowDrawingOutsideViewBox: true,
                    ),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Women Safety',
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 18,
                            color: const Color(0xff131313),
                            fontWeight: FontWeight.w800,
                            height: 1.7777777777777777,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Text(
                            'Lorem dolor sit amet consectetur adipisicing elit, sed do eiusmod tempor incididunt ut ero labore et dolore',
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 14,
                              color: const Color(0xff131313),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          _controller.animateToPage(4,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(45, 10, 45, 10),
                          decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.black),
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            'Skip',
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 15.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _controller.animateToPage(3,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(45, 10, 45, 10),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.black),
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            'Next',
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 15.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future getPhoneNo() async {
    try {
      http.Response response =
          await http.post('$baseurl/api/v1/auth/generate-otp/', body: {
        "username": "${'+91'}${_controller.text}",
      });
      print(response.statusCode);
      print(response.body);
      if (200 < response.statusCode && response.statusCode < 300) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    OtpScreen('+91${_controller.text}', false)));
      }
    } catch (e) {
      print(e);
    }
  }

  void verifyForm() {
//    if (_formKey.currentState.validate()) {
//      getPhoneNo();
//    }
    getPhoneNo();
  }

  Future loggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    (preferences.getString('isLogin') == null)
        ? null
        : Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HomePage(preferences.getString('islogin'))));
  }

  @override
  void initState() {
    loggedIn();
    Logger logger = Logger('logger');
    logger.severe('App started');
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Welcome!',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 18,
                    color: const Color(0xff131313),
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Please enter your phone number to \ncontinue. ',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 14,
                    color: const Color(0xff838383),
                    height: 1.4285714285714286,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 300,
                  height: 50,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone Number',
                    ),
                    controller: _controller,
                    keyboardType: TextInputType.phone,
                    validator: (data) => (data.length == 10)
                        ? null
                        : 'The mobile number is not valid',
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
//                customButton('Continue', this.verifyForm()),
                InkWell(
                  onTap: () {
                    verifyForm();
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(45, 10, 45, 10),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.black),
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 15.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
//              padding: EdgeInsets.all(80),
        ),
      ),
    );
  }
}
