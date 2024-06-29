import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_car_rental_app/presentation/viewmodel/home/searchlocation_viewmodel.dart';
import 'package:one_car_rental_app/presentation/views/home/pick_map_location_screen.dart';

class PersonalChauffeurLocationScreen extends StatelessWidget {
  const PersonalChauffeurLocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchLocationViewModel());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Chauffeur'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Row(
              children: [
                Text(
                  'One Way',
                  style: TextStyle(color: Colors.white),
                ),
                Icon(Icons.arrow_drop_down, color: Colors.white),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Column(
                  children: [
                    ...controller.locationControllers
                        .asMap()
                        .entries
                        .map((entry) {
                      final index = entry.key;
                      final textController = entry.value;
                      return Column(
                        children: [
                          buildLocationSearchBar(
                            context,
                            hintText: index == 0
                                ? 'Enter pickup location'
                                : 'Enter dropoff location',
                            icon: index == 0
                                ? Icons.my_location
                                : Icons.location_on,
                            showAddButton: index ==
                                    controller.locationControllers.length - 1 &&
                                controller.locationControllers.length < 3,
                            index: index,
                            textController: textController,
                            controller: controller,
                            onChanged: (value) async {
                              await controller.fetchSuggestions(value, index);
                            },
                            onSelectSuggestion: (selectedSuggestion) {
                              textController.text = selectedSuggestion;
                              controller.clearSuggestions(index);
                            },
                          ),
                          const SizedBox(height: 8),
                        ],
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.place),
                title: Text('Set Location on map'),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(16),
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        width: MediaQuery.of(context).size.width * .9,
        child: Text(
          'Done',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }

  Widget buildLocationSearchBar(BuildContext context,
      {required String hintText,
      required IconData icon,
      bool showAddButton = false,
      required int index,
      required TextEditingController textController,
      required SearchLocationViewModel controller,
      required Function(String) onChanged,
      required Function(String) onSelectSuggestion}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  const Icon(Icons.circle, size: 8, color: Colors.grey),
                  Container(
                    height: 24,
                    width: 2,
                    color: Colors.grey,
                  ),
                  const Icon(Icons.circle, size: 8, color: Colors.grey),
                ],
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: textController,
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    hintText: hintText,
                    border: InputBorder.none,
                  ),
                ),
              ),
              if (showAddButton)
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => controller.addLocationField(),
                )
              else if (index > 1)
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => controller.removeLocationField(index),
                ),
            ],
          ),
          Obx(
            () {
              final suggestions = controller.suggestionsList[index];
              return suggestions.isEmpty
                  ? SizedBox.shrink()
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: suggestions.length,
                      itemBuilder: (context, suggestionIndex) {
                        return ListTile(
                          title: Text(suggestions[suggestionIndex]),
                          onTap: () {
                            onSelectSuggestion(suggestions[suggestionIndex]);
                          },
                        );
                      },
                    );
            },
          ),
        ],
      ),
    );
  }
}
