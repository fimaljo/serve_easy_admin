import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:readmore/readmore.dart';
import 'package:serve_easy/models/product.dart';
import 'package:serve_easy/screens/Additem/add_product.dart';
import 'package:serve_easy/screens/Home/components/products_update_page.dart';
import 'package:serve_easy/services/firestore_service.dart';
import 'package:serve_easy/utils/colors.dart';
import 'package:serve_easy/utils/shimmer_widget.dart';
import 'package:serve_easy/utils/utils.dart';
import 'package:serve_easy/widgets/submit_button.dart';

class ProductsPage extends StatefulWidget {
  final snap;
  const ProductsPage({Key? key, required this.snap}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    final productNameEditingController = TextEditingController();
    final productDescriptionEditingController = TextEditingController();
    final productPriceEditingController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: blueColor,
          ),
        ),
        backgroundColor: secondColor,
        centerTitle: true,
        elevation: 0,
        title: const Image(
          height: 40,
          image: AssetImage(
            'assets/images/products.png',
          ),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('category')
              .doc(widget.snap['categoryId'])
              .collection('products')
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.active &&
                snapshot.data != null) {
              if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("No products yet..."),
                      Lottie.asset(
                        "assets/anim/r9hU0MlATV.json",
                        width: 190,
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProductsUpdatePage(
                            snap: snapshot.data!.docs[index].data(),
                          ),
                        ),
                      );
                    },
                    child: ProductsCard(
                      snap: snapshot.data!.docs[index].data(),
                    ),
                  );
                },
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: const [
                  ShimmerWidget(height: 120),
                  ShimmerWidget(height: 120),
                  ShimmerWidget(height: 120),
                  ShimmerWidget(height: 120),
                  ShimmerWidget(height: 120),
                ],
              ),
            );
          }),
      bottomNavigationBar: SafeArea(
        child: Container(
          color: Colors.transparent,
          height: 90,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: SubmitButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AdminAddProductPage(
                          snap: widget.snap,
                        ),
                      ),
                    );
                  },
                  text: "Add Products",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProductsCard extends StatelessWidget {
  final snap;
  const ProductsCard({Key? key, required this.snap}) : super(key: key);

  deleteProduct(
    String categoryId,
    String productsId,
  ) async {
    try {
      String res =
          await FirestoreService().deleteProduct(categoryId, productsId);
      if (res == "success") {
        Utils.showSnackBar("product deleted successfully");
      }
    } catch (err) {
      Utils.showSnackBar(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: 200,
        height: 110,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                blueColor,
                blueColor,
              ],
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0xFFe8e8e8),
                blurRadius: 10.0,
                offset: Offset(0, 14),
              ),
              BoxShadow(
                color: Colors.transparent,
                offset: Offset(-5, 0),
              ),
              BoxShadow(
                color: scaffoldColor,
                offset: Offset(5, 0),
              ),
            ],
            borderRadius: BorderRadius.circular(17)),
        child: Padding(
          padding: const EdgeInsets.all(17.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 45,
                backgroundImage: NetworkImage(snap['imageUrl']),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    snap['name'],
                    maxLines: 4,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        overflow: TextOverflow.fade),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 30,
                    width: 160,
                    child: ReadMoreText(
                      snap['description'],
                      trimLines: 4,
                      colorClickableText: Colors.white,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Show more',
                      trimExpandedText: 'Show less',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Text(
                    "\u{20B9}${snap['price'].toString()}",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  )
                ],
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  deleteProduct(
                    snap['categoryId'] ?? "",
                    snap['productid'] ?? "",
                  );
                },
                icon: Image.asset(
                  'assets/icons/trash.png',
                  height: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
