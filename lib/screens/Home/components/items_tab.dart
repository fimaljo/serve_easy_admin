import 'package:flutter/material.dart';
import 'package:serve_easy/screens/Additem/add_item.dart';
import 'package:serve_easy/utils/colors.dart';

class ItemsTab extends StatelessWidget {
  const ItemsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          icon: Icon(Icons.add),
          label: Text('ADD YOUR ITEMS'),
          backgroundColor: blueColor,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AdminAddProductPage(),
              ),
            );
          },
        ),
        body: ListView.builder(
            shrinkWrap: true,
            itemCount: 10,
            //physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 30, right: 30, left: 30),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 100,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F19%2F2017%2F08%2F17%2FGettyImages-545286388-2000.jpg&q=60"),
                      ),
                    ),
                    child: Center(
                        child: Text(
                      "CHINESE",
                      style: TextStyle(
                          fontSize: 30,
                          color: scaffoldColor,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4,
                          shadows: [
                            Shadow(
                                color: Colors.black.withOpacity(0.8),
                                offset: const Offset(20, 15),
                                blurRadius: 15)
                          ]),
                    )),
                  ),
                ),
              );
            }));
  }
}
