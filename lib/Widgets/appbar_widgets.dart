import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loginapp/Address/address_page.dart';
import 'package:loginapp/Address/location_page.dart';
import 'package:loginapp/Auth/signin_number.dart';
import 'package:loginapp/app_data.dart';
import 'package:loginapp/home_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:loginapp/loading_screen.dart';
import 'package:loginapp/order_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../constant.dart';
bool isAddressChosen=false;
double totalItemPrice=0;
class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}
class _HomeWidgetState extends State<HomeWidget> {
  List<String> categories = ['Show All', 'Beer', 'Whiskey', 'Vodka', 'Tequila'];
  List<Order> showList = orderList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return CategoryWidget(index);
              },
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
            ),
          ),
          Expanded(
            flex: 8,
            child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(showList.length, (index) {
                  bool isCommon = false;
                  cartList.forEach((element) {
                    if (element.id == showList[index].id) isCommon = true;
                  });

                  return OrderTile(
                      showList[index].id,
                      showList[index].name,
                      showList[index].mrp,
                      showList[index].quantity,
                      isCommon,
                      false,
                      showList[index].category);
                })),

          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton.extended(
              onPressed: () {
                setState(() {
                  index = 1;
                });
                print(index);
              },
              label: Text('Go To Cart'),
              backgroundColor: Colors.black87,
            ),
          )
        ],
      ),
    );
  }

  Padding CategoryWidget(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          if (index == 0) {
            setState(() {
              showList = orderList;
            });
          } else
            setState(() {
              {
                showList = orderList
                    .where((element) =>
                element.category == categories[index])
                    .toList();
              }
            });
          setState(() {
            count = index;
          });
        },
        child: Container(
          decoration: BoxDecoration(
              color: (index == count)
                  ? Colors.black87
                  : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(30)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Center(
                child: Text(
                  categories[index],
                  style: TextStyle(
                      color: (index == count)
                          ? Colors.white
                          : Colors.black),
                )),
          ),
        ),
      ),
    );
  }
}


class CartWidget extends StatefulWidget {
  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {



  @override
  Widget build(BuildContext context) {
     totalItemPrice=0;
    return SingleChildScrollView(
scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [

          (cartList.length!=0)?GridView.count(
            shrinkWrap: true,
              crossAxisCount: 2,
              children: List.generate(
                cartList.length,
                (index) {
                  totalItemPrice+=double.parse(cartList[index].mrp)*cartList[index].quantity;
                  return OrderTile(
                  cartList[index].id,
                  cartList[index].name,
                  cartList[index].mrp,
                  cartList[index].quantity,
                  true,
                  true,
                  cartList[index].category,
                );}
              )):Center(child: Text('The Cart is empty! Add some products ')),
          (cartList.length!=0)?ListTile(
            leading: FaIcon(FontAwesomeIcons.percentage),
            title: Text(
              'Apply Coupons',
              style: TextStyle(color: Colors.grey),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
          ):SizedBox(),


(cartList.length!=0)?Column(
  mainAxisSize: MainAxisSize.min,
  children: [
  ListTile(
      leading: Text(
      'Item',
      style: kTextStyle.copyWith(color: Colors.black),
      ),
      trailing: Text(
      '$totalItemPrice',
      style: kTextStyle.copyWith(color: Colors.black),
      ),
  ),
  ListTile(
      leading: Text(
      'Packing Charges',
      style: kTextStyle.copyWith(color: Colors.black),
      ),
      trailing: Text(
      '24000',
      style: kTextStyle.copyWith(color: Colors.black),
      ),
  ),
  ListTile(
      leading: Text(
      'GST',
      style: kTextStyle.copyWith(color: Colors.black),
      ),
      trailing: Text(
      '24000',
      style: kTextStyle.copyWith(color: Colors.black),
      ),
  ),
  ListTile(
      leading: Text(
      'Delivering Charges',
      style: kTextStyle.copyWith(color: Colors.black),
      ),
      trailing: Text(
      '24000',
      style: kTextStyle.copyWith(color: Colors.black),
      ),
  ),
  ListTile(
      leading: Text(
      'Total',
      style: kTextStyle.copyWith(color: Colors.black),
      ),
      trailing: Text(
      '24000',
      style: kTextStyle.copyWith(color: Colors.black),
      ),)


],):Flexible(child: Container()),Consumer<ProfileData>(builder: (context,data,child)
          {
            return (isAddressChosen)?Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.black87),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('User Name',style: kHeadingStyle,),
                          Text(data.currentAdd.name,style: kTextStyle.copyWith(backgroundColor: Colors.white,color: Colors.black87),)


                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text('${data.currentAdd.address},${data.currentAdd.city},${data.currentAdd.pincode}',style: kTextStyle,),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text('Note:${data.currentAdd.note}',style: kTextStyle,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text('${Provider.of<ProfileData>(context).phone}',style: kTextStyle,),
                      ),


                    ],


                  ),
                ),


              ),
            ): SizedBox();

          }
          ),




         Row(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: [
           FloatingActionButton.extended(
             heroTag: 'a',
             onPressed: () {
               if (authToken==null)
               {
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
               }
               else {
                 Navigator.push(context,
                     MaterialPageRoute(
                         builder: (context) => AddressPage(null)));
               }
             },
             label: Text((!isAddressChosen)?'Choose Address':'Change Address'),
           ),
           Padding(
             padding: const EdgeInsets.symmetric(vertical: 18.0),
             child: FloatingActionButton.extended(
                 onPressed: () async {
                   if (authToken==null)
                   {
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                   }
                   else{
                   Navigator.push(
                       context,
                       MaterialPageRoute(
                           builder: (context) => LoadingScreen('Creating order')));
                   var data = await createOrder(id);
                   print(data);
                   if (data == false) {
                     Navigator.pop(context);
                     Scaffold.of(context).showSnackBar(SnackBar(
                       content: Container(
                         child: Text(
                             'Order not successfull! Try Again'),
                       ),
                       backgroundColor: Colors.black,
                     ));
                   } else {
                     cartList=[];
                     Navigator.push(
                         context,
                         MaterialPageRoute(
                             builder: (context) =>
                                 OrderPage(data)));
                   }
                 }},
                 label: Text((cartList.length!=0)?'Pay:$totalItemPrice':'order')),
           ),


         ],)

        ],
      ),
    );
  }
}

class OrderTile extends StatefulWidget {
  String name;
  String mrp;
  int quantity;
  bool isAdded;
  String id;
  bool displayQuantity;
  String category;
  OrderTile(this.id, this.name, this.mrp, this.quantity, this.isAdded,
      this.displayQuantity, this.category);

  @override
  _OrderTileState createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                  colors: [Colors.black, Colors.black87],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight)),
          child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.name,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                              child: Image(
                            image: AssetImage('images/wine.png'),
                          )),
                          Text(' Rs ${widget.mrp} ',
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        (this.widget.isAdded)
                            ? IconButton(
                            icon: Icon(Icons.remove_shopping_cart,
                                color: Colors.white),
                            onPressed: () {
                              setState(() {

                                this.widget.isAdded=!this.widget.isAdded;
                                removeFromCart(this.widget.id,context)
                                    .then((value) => getCartData());

                                cartList.removeWhere((element) =>
                                (element.name == this.widget.name));
                                print(cartList.length);
                              });
                            })
                            : IconButton(
                            icon: Icon(Icons.add_shopping_cart,
                                color: Colors.white),
                            onPressed: () {
                              setState(() {
                                if (authToken==null)
                                  {
                                   Navigator.push(context, PageTransition(child: LoginPage(),duration: Duration(milliseconds: 400), type: PageTransitionType.rightToLeftWithFade));
                                  }
                               else{
                                this.widget.isAdded=!this.widget.isAdded;
                                print(this.widget.id);
                                addToCart(this.widget.id, this.widget.quantity,context)
                                    .then((value) => getCartData());

                                cartList.add(Order(
                                    this.widget.id,
                                    this.widget.name,
                                    this.widget.mrp,
                                    this.widget.quantity,
                                    this.widget.category));

                              }});
                            }),
                        (this.widget.isAdded)
                            ? Material(
                          color: Colors.black87,
                          borderOnForeground: true,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                child: Icon(Icons.remove,
                                    color: Colors.white),
                                onTap: () {
                                  if (this.widget.quantity > 1) {
                                    setState(() {
                                      this.widget.quantity--;
                                      removeFromCart(this.widget.id,context)
                                          .then((value) => getCartData());
                                    });
                                  }
                                },
                              ),
                              Text(
                                '${this.widget.quantity}',
                                style: kTextStyle,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    if (this.widget.quantity < 10)
                                      setState(() {
                                        this.widget.quantity++;
                                        final element =
                                        cartList.firstWhere(
                                              (element) => (element.id ==
                                              this.widget.id),
                                        );
                                        setState(() {
                                          element.quantity =
                                              this.widget.quantity;
                                        });
                                        addToCart(this.widget.id,
                                            this.widget.quantity,context)
                                            .then(
                                                (value) => getCartData());
                                      });
                                    else {
                                      showDialog(
                                          context: context,
                                          child: AlertDialog(
                                            title: Text(
                                                'Maximum Limit Reached'),
                                            actions: [
                                              FlatButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context);
                                                  },
                                                  child: Text('OK'))
                                            ],
                                          ));
                                    }
                                  },
                                  child: Icon(Icons.add,
                                      color: Colors.white))
                            ],
                          ),
                        ):SizedBox(width: 0,)



                      ],

                    ),


                  ],
                )),
    );
  }
}
List <Order> searchResults=[];
List<Order> mostPopular = [
  Order('T04B01S', "BUDWEISER KING OF BEERS", '110.0', 1, 'Beer'),
  Order("T04B01U", "BUDWEISER KING OF BEERS", '60', 1, 'Beer')
];
bool isSearching = true;
List<Order> itemList = [];
Future searchItems(String query) async {
  http.Response response = await http.post('$baseurl/api/v1/products/search/',
      body: {"search-text": "$query"});
  print(response.statusCode);
  isSearching = true;
  var data = jsonDecode(response.body);
  print(data.length);
  itemList = [];
  for (var item in data) {
    itemList.add(Order(
        item['item_id'],
        item['item_desc'],
        item['quantity'][0]['bottle_mrp_rate'].toString(),
        1,
        item['category']['subtype']['subtype_name']));
  }
  print('done');
  searchResults=itemList;
  return itemList;
}

class DataSearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.arrow_menu,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    List<Order> suggestionList = (query.isEmpty) ? mostPopular : itemList;
    print(itemList);
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return OrderTile(
            suggestionList[index].id,
            suggestionList[index].name,
            suggestionList[index].mrp,
            suggestionList[index].quantity,
            false,
            false,
            suggestionList[index].category);
      },
      itemCount: suggestionList.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions

    print(itemList);
    return (query != '')? FutureBuilder(
            builder: (context, list) {
              if (list.connectionState == ConnectionState.none ||
                  list.hasData == null) {
                //print('project snapshot data is: ${projectSnap.data}');
                return Container(
                  child: Center(
                    child: Text('No products found'),
                  ),
                );
              } else if (list.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                return (list.data.length!=0)?GridView.count(
           shrinkWrap: true,
                    crossAxisCount: 2,
                    children: List.generate(list.data.length, (index) {
                      bool isCommon = false;
                      cartList.forEach((element) {
                        if (element.id == list.data[index].id) isCommon = true;
                      });

                      return OrderTile(
                          list.data[index].id,
                          list.data[index].name,
                          list.data[index].mrp,
                          list.data[index].quantity,
                          isCommon,
                          false,
                          list.data[index].category);
                    })):Center(child: Text('No products found'),);
              }
            },
            future: searchItems(query),
          ) :GridView.count(crossAxisCount: 2,
        children: List.generate(searchResults.length, (index) {
          bool isCommon = false;
          cartList.forEach((element) {
            if (element.id == searchResults[index].id) isCommon = true;
          });

          return OrderTile(
              searchResults[index].id,
              searchResults[index].name,
              searchResults[index].mrp,
              searchResults[index].quantity,
              isCommon,
              false,
              searchResults[index].category);
        }));
  }
}
