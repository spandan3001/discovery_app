import 'package:discovery_app/controller/api_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiscoveryPage extends StatefulWidget {
  const DiscoveryPage({super.key});

  @override
  State<DiscoveryPage> createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> {
  // Get the ApiController instance for state management
  final ApiController apiController = Get.put(ApiController());

  @override
  void initState() {
    super.initState();
    //initial check connectivity
    apiController.checkConnectivity(null);

    // Load initial data when the page is initialized
    apiController.process();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar with the title "Discovery Page"
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Discovery Page',
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      // Obx widget listens for changes in the ApiController's items and isLoading variables
      body: Obx(() {
        return Center(
          child: ListView.builder(
            // Total number of items includes existing items and a loading indicator
            itemCount: apiController.items.length + 1,
            controller: apiController.scrollController,
            itemBuilder: (context, index) {
              // If index is within the range of existing items, display a Card with item details
              if (index < apiController.items.length) {
                return Card(
                  elevation: 5.0,
                  child: ListTile(
                    title: Text(
                      apiController.items[index].title,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    subtitle: Column(
                      children: [
                        Text(apiController.items[index].description),

                        const SizedBox(height: 10),

                        // Display image only if the URL is not empty
                        if (apiController.items[index].imageUrl.isNotEmpty)
                          SizedBox(
                            width: double.maxFinite,
                            height: 200,
                            child: Image.network(
                              apiController.items[index].imageUrl,
                              fit: BoxFit.fill,
                            ),
                          ),
                      ],
                    ),
                  ),
                ).paddingAll(8.0);
              } else {
                // If index is beyond existing items, show loading indicator if data is still loading
                if (apiController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  // Otherwise, display an empty container to indicate the end of the list
                  return Container();
                }
              }
            },
          ),
        );
      }),
    );
  }
}
