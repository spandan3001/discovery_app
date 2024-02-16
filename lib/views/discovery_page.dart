import 'package:discovery_app/controller/api_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiscoveryPage extends StatelessWidget {
  const DiscoveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the ApiController instance for state management
    final ApiController apiController = Get.put(ApiController());

    return Scaffold(
      // App Bar with the title "Discovery Page"
      appBar: AppBar(
        title: const Text('Discovery Page'),
      ),
      // Obx widget listens for changes in the ApiController's items and isLoading variables
      body: Obx(() {
        return ListView.builder(
          // Total number of items includes existing items and a loading indicator
          itemCount: apiController.items.length + 1,
          itemBuilder: (context, index) {
            // If index is within the range of existing items, display a Card with item details
            if (index < apiController.items.length) {
              return Card(
                child: ListTile(
                  title: Text(apiController.items[index].title),
                  subtitle: Column(
                    children: [
                      Text(apiController.items[index].description),
                      // Display image only if the URL is not empty
                      if (apiController.items[index].imageUrl.isNotEmpty)
                        Image.network(apiController.items[index].imageUrl),
                    ],
                  ),
                ),
              );
            } else {
              // If index is beyond existing items, show loading indicator if data is still loading
              if (apiController.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                // Otherwise, display an empty container to indicate the end of the list
                return Container();
              }
            }
          },
        );
      }),
    );
  }
}
