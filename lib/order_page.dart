import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginapp/app_data.dart';
import 'package:loginapp/home_page.dart';
import 'package:provider/provider.dart';
import 'constant.dart';

class OrderPage extends StatelessWidget {
  dynamic orderData;
  OrderPage(this.orderData);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
cartList=[];
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(null)));

        return true;
      },

      child: Scaffold(
        appBar: AppBar(
          title: Text('order_id:${orderData['order_id']}'),
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Text('Order Details/Items',
                      style: kHeadingStyle.copyWith(color: Colors.black))),
              Expanded(
                flex: 2,
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    print(orderData['products_order'].length);
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black87,
                          gradient: LinearGradient(
                              colors: [Colors.black, Colors.black87],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Image(image: AssetImage('images/wine.png')),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                      '${orderData['products_order'][index]['product']['item_desc']}',
                                      style: kHeadingStyle),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      'Rs ${orderData['products_order'][index]['product']['quantity'][0]['bottle_mrp_rate']}',
                                      style: kHeadingStyle),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${orderData['products_order'][index]['quantity']}',
                                style: kHeadingStyle.copyWith(
                                    color: Colors.black,
                                    backgroundColor: Colors.white),
                                textAlign: TextAlign.end,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: orderData['products_order'].length,
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    reverse: true,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: Text(
                              'Bill Details',
                              style: kHeadingStyle.copyWith(color: Colors.black),
                            ),
                            title: Text(
                              '"New 20 applied"',
                              style: kTextStyle.copyWith(color: Colors.grey),
                            ),
                          ),
                          ListTile(
                            leading: Text(
                              'Item',
                              style: kTextStyle.copyWith(color: Colors.black),
                            ),
                            trailing: Text(
                              '24000',
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
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3.0, horizontal: 10),
                            child: Text(
                              'Date and Time Created:${orderData['date_created'].toString().substring(0, 10)}  ${orderData['date_created'].toString().substring(11, 16)}',
                              style: kTextStyle.copyWith(color: Colors.grey),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3.0, horizontal: 10),
                            child: Text(
                              'Date and Time Modified:${orderData['date_modified'].toString().substring(0, 10)}  ${orderData['date_modified'].toString().substring(11, 16)}',
                              style: kTextStyle.copyWith(color: Colors.grey),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3.0, horizontal: 10),
                            child: Text(
                              'Payment Status:${orderData['is_payment_success']}',
                              style: kTextStyle.copyWith(color: Colors.grey),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3.0, horizontal: 10),
                            child: Text(
                              'Delivery address:${orderData['customer_location']['address']},${orderData['customer_location']['city']},${orderData['customer_location']['zip_code']}',
                              style: kHeadingStyle.copyWith(color: Colors.black),
                            ),
                          )
                        ],
                      ),
                    ],
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