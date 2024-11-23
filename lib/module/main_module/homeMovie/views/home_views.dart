import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_movies_app/data/utils/colour_manager.dart';
import 'package:my_movies_app/module/main_module/homeMovie/views/favouriteViews.dart';
import 'package:my_movies_app/module/main_module/homeMovie/controller/home_controller.dart';
import 'package:my_movies_app/module/main_module/homeMovie/views/movies_detailsviews.dart';
import 'package:my_movies_app/module/routes/app_pages.dart';

class HomeViews extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: TextFormField(
            //   controller: controller.searchController,
            onChanged: (String s) {},
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.only(left: Get.width * .05, top: Get.height * .01),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: ColourManager.blueColor)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      color: Theme.of(context).splashColor, width: 1)),
              hintText: 'Search by product name',
              border: OutlineInputBorder(),
              suffixIcon: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  height: 40.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                      color: Colors.greenAccent.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6.5.r)),
                  child: Icon(
                    Icons.search,
                    color: ColourManager.greenColor,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(()=>FavouriteViews());
                },
                icon: Icon(Icons.favorite_border))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemCount: controller.homeServiceProvider.movieList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {

                      Get.to(MovieDetailsViews(), arguments: controller.homeServiceProvider.movieList[index]);

                    },
                    child: Container(
                      width: double.infinity,
                      height: Get.height * .20,
                      decoration: BoxDecoration(
                        color: Colors.pinkAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Container(
                            // width: Get.width * .25,

                            child: Image.network(
                              height: Get.height * .130,
                              width: double.infinity,
                              fit: BoxFit.fill,
                              //"https://images.pexels.com/photos/8088371/pexels-photo-8088371.jpeg?auto=compress&cs=tinysrgb&w=600"
                              "${controller.homeServiceProvider.movieList[index].posterUrl}",
                            ),
                          ),
                          SizedBox(height: Get.height * .01),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(alignment: Alignment.topLeft, child: Text(
                                //    "MoviesApp"
                                "${controller.homeServiceProvider.movieList[index].title}")),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      );
    });
  }
}
