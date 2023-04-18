import 'package:flutter/material.dart';
import 'package:flutter_sever/configDB/config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailItem extends StatefulWidget {
  final product;
  const DetailItem({super.key, required this.product});

  @override
  State<DetailItem> createState() => _DetailItemState();
}

int count = 1;

class _DetailItemState extends State<DetailItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          widget.product.category,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Builder(builder: (context) {
        return Material(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        height: 400,
                        child: Image.network(
                            IPCONFIG_image + widget.product.image[0]),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 238, 238, 238),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 16.0, left: 15, right: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Wrap(
                                      children: [
                                        Text(
                                          widget.product.name,
                                          style: const TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      FontAwesomeIcons.heartCircleCheck,
                                      color: Colors.pink,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            ListTile(
                              title: const Padding(
                                padding: EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  'Description',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              subtitle: Text(widget.product.description),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                children: [
                                  const Expanded(
                                    flex: 1,
                                    child: Text(
                                      'Quantity',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 202, 202, 202),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      width: 100,
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                if (count != 1) {
                                                  count--;
                                                }
                                              });
                                            },
                                            icon: const Icon(
                                                FontAwesomeIcons.minus),
                                          ),
                                          Text(
                                            '$count',
                                            style: const TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                count++;
                                              });
                                            },
                                            icon: const Icon(
                                                FontAwesomeIcons.plus),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                color: const Color.fromARGB(255, 244, 244, 244),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: ListTile(
                        title: const Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text('Total Price'),
                        ),
                        subtitle: Text(
                          '\$${(widget.product.price * count)}',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 56,
                        child: ElevatedButton.icon(
                          icon: const Icon(FontAwesomeIcons.cartShopping),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              elevation: 8,
                              shape: (RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(130)))),
                          onPressed: () {},
                          label: const Text(
                            '    ADD TO CART',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
