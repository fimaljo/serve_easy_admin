import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serve_easy/models/category.dart';
import 'package:serve_easy/screens/Additem/add_item.dart';
import 'package:serve_easy/screens/Home/components/products_page.dart';
import 'package:serve_easy/screens/providers.dart';
import 'package:serve_easy/services/firestore_service.dart';
import 'package:serve_easy/utils/colors.dart';
import 'package:serve_easy/utils/shimmer_widget.dart';
import 'package:shimmer/shimmer.dart';

class ItemsTab extends ConsumerWidget {
  const ItemsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        icon: Icon(Icons.add),
        label: Text('ADD YOUR ITEMS'),
        backgroundColor: blueColor,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AdminAddCategoryPage(),
            ),
          );
        },
      ),
      body: StreamBuilder<List<Category>>(
        //  shrinkWrap: true,
        // itemCount: 10,
        //physics: const ClampingScrollPhysics(),
        // scrollDirection: Axis.vertical,
        stream:
            FirestoreService(uid: _auth.currentUser!.uid).getProductsCategory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active &&
              snapshot.data != null) {
            if (snapshot.data!.isEmpty) {
              return Center(
                child: Text('No Data Add Products'),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final categoryrec = snapshot.data![index];
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 30, right: 30, left: 30),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProductsPage(),
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
                            image: NetworkImage(categoryrec.categoryImage),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            categoryrec.categoryName,
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
                });
          }
          return SingleChildScrollView(
            child: Column(
              children: [
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
