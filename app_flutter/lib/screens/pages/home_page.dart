import 'dart:convert';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sever/configDB/config.dart';
import 'package:flutter_sever/models/category.dart';
import 'package:flutter_sever/models/product.dart';
import 'package:flutter_sever/services/service_api.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> listProducts = [];
  List<CategoryItem> listCategory = [];
  bool checkCallApi = false;

  getData() async {
    listProducts = await ServiceApi.getProductList();
    listCategory = await ServiceApi.getCategoryList();
    if (listProducts != null && listCategory != null) {
      setState(() {
        checkCallApi = true;
      });
    }
    print(listProducts[0].name);
  }

  @override
  void initState() {
    super.initState();
    //lấy dữ liệu product
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Visibility(
            visible: checkCallApi,
            replacement: const Center(
              child: LinearProgressIndicator(),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      height: 60,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            child: CircleAvatar(
                              backgroundColor:
                                  const Color.fromARGB(255, 205, 205, 205),
                              child: ClipRRect(
                                borderRadius: const BorderRadiusDirectional.all(
                                    Radius.circular(100)),
                                child: CircleAvatar(
                                  radius: 30,
                                  child:
                                      Image.asset('assets/images/avatar.png'),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Hello !',
                                  style: TextStyle(fontWeight: FontWeight.w200),
                                ),
                                Text(
                                  "ABC",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () {},
                                  child: const Icon(
                                    Icons.notifications_none_outlined,
                                    color: Colors.black,
                                    size: 36,
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 30, 10, 20),
                    child: TextFormField(
                      showCursor: false,
                      readOnly: true,
                      onTap: () => {},
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.search_outlined,
                          size: 26,
                        ),
                        suffixIcon: Icon(Icons.bubble_chart),
                        hintText: 'Search ...',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 241, 19, 133),
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Special Offers',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    child: _slider(listProducts),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4),
                      itemCount: listCategory.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                                child: ClipRRect(
                              borderRadius: const BorderRadiusDirectional.all(
                                  Radius.circular(100)),
                              child: CircleAvatar(
                                radius: 30,
                                child: Image.network(
                                  IPCONFIG_image + listProducts[index].image[0],
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )),
                            Text(
                              listCategory[index].nameCategory!,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Most Popular',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent:
                            MediaQuery.of(context).size.height * 0.45,
                        // mainAxisExtent: 250,
                      ),
                      scrollDirection: Axis.vertical,
                      itemCount: listProducts.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 231, 231, 231),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 300,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      IPCONFIG_image +
                                          listProducts[index].image[0],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  listProducts[index].name,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  listProducts[index].price.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _slider(List listProducts) {
    return CarouselSlider.builder(
      itemCount: listProducts.length,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
          Container(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 234, 234, 234),
              ),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Image.network(
                  IPCONFIG_image + listProducts[itemIndex].image[0],
                  scale: 3,
                ),
              ),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: Container(
                height: 60,
                decoration: const BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                padding: const EdgeInsets.all(20),
                child: Text(
                  listProducts[itemIndex].name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
      options: CarouselOptions(
        height: 300.0,
        viewportFraction: 1,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        enlargeStrategy: CenterPageEnlargeStrategy.scale,
      ),
    );
  }
}
