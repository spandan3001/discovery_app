import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/item.dart';
import '../utils/snackbar_helper.dart';

class ApiController extends GetxController {
  static const _baseApi = "https://api-stg.together.buzz/mocks/discovery";

  // List to store the item model
  late RxList<Item> items = <Item>[].obs;

  //scroll controller for list builder
  final ScrollController scrollController = ScrollController();
  // Variable to handle loading indication
  Rx<bool> isLoading = false.obs;

  // The page number which will increment always
  int page = 1;

  @override
  void onReady() {
    super.onReady();
    super.onInit();

    //added listener to scroll controller
    scrollController.addListener(() {
      if (scrollController.position.atEdge &&
          scrollController.position.pixels != 0 &&
          !isLoading.value) {
        // Load more data when reaching the bottom
        process();
      }
    });
  }

  // Function to get data from the API
  Future<Map<String, dynamic>> getData() async {
    // Try-catch to handle errors
    try {
      // Get response from the API using the http package
      final response = await http.get(
        Uri.parse('$_baseApi?page=$page&limit=10'),
      );

      if (response.statusCode == 200) {
        // Return the decoded JSON
        return json.decode(response.body);
      } else {
        //handle error
        SnackBarHelper.showSnackBar(
            title: "Error",
            message: '${response.statusCode}',
            contentType: ContentType.failure);
      }
    } catch (e) {
      //handle error
      SnackBarHelper.showSnackBar(
          title: "Error",
          message: "Error occurred while getting the data: $e",
          contentType: ContentType.failure);
    }
    return {};
  }

  // Function to process the data
  void process() async {
    // If already loading, return
    if (isLoading.value) {
      return;
    } else {
      // Show loading
      isLoading(true);
    }

    // Call getData function
    final data = await getData();

    if (data.isNotEmpty) {
      // Convert data to a list of Item models
      List<Item> newItems =
          (data['data'] as List).map((item) => Item.fromJson(item)).toList();

      // Add new items to the existing list
      items.addAll(newItems);

      // Update the page number
      page = data['page'] + 1;

      // Stop loading
      isLoading(false);
    } else {
      // Stop loading in case of an error or empty response
      isLoading(false);
      // Handle error
      SnackBarHelper.showSnackBar(
          title: "Error",
          message:
              "Error occurred while getting the data ,may the data is empty",
          contentType: ContentType.failure);
    }
  }
}
