import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:serve_easy/screens/Additem/add_item.dart';
import 'package:serve_easy/screens/Home/components/products_page.dart';
import 'package:serve_easy/services/firestore_service.dart';
import 'package:serve_easy/utils/colors.dart';
import 'package:serve_easy/utils/shimmer_widget.dart';
import 'package:serve_easy/utils/utils.dart';

class ItemsTab extends ConsumerWidget {
  const ItemsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        icon: Icon(Icons.add),
        label: Text('CREAT CATEGORY'),
        backgroundColor: blueColor,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AdminAddCategoryPage(),
            ),
          );
        },
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('category').snapshots(),
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
                      width: 300,
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return CategoryCard(
                    snap: snapshot.data!.docs[index].data(),
                  );
                });
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
        },
      ),
    );
  }
}

class CategoryCard extends StatefulWidget {
  final snap;
  const CategoryCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

deleteCategory(
  String categoryId,
) async {
  try {
    await FirestoreService().deleteCaregory(categoryId);
  } catch (err) {
    Utils.showSnackBar("Category Deleted");
  }
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, right: 30, left: 30),
      child: GestureDetector(
        onLongPress: () {
          deleteCategory(widget.snap['categoryId']!);
        },
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProductsPage(
                snap: widget.snap,
              ),
            ),
          );
        },
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Color(0xFFe8e8e8),
                blurRadius: 5.0,
                offset: Offset(0, 14),
              ),
              BoxShadow(
                color: blueColor,
                offset: Offset(-5, 0),
              ),
              BoxShadow(
                color: Color(0xFFe8e8e8),
                offset: Offset(5, 0),
              ),
            ],
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(widget.snap['categoryImage']),
            ),
          ),
          child: Center(
            child: Text(
              widget.snap["categoryName"],
              style: TextStyle(
                fontSize: 30,
                color: scaffoldColor,
                fontWeight: FontWeight.bold,
                letterSpacing: 4,
                shadows: [
                  Shadow(
                      color: Colors.black.withOpacity(0.8),
                      offset: const Offset(10, 15),
                      blurRadius: 15)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
