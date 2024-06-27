import 'package:get/get.dart';
import 'package:one_car_rental_app/data/model/add_car_details_model.dart';
import 'package:one_car_rental_app/data/services/firebase/addcars.db.dart';
import 'package:one_car_rental_app/presentation/components/common/common_text.dart';
import 'package:one_car_rental_app/presentation/views/cars/add_cars_screen.dart';
import 'package:one_car_rental_app/res/colors/colors.dart';
import 'package:flutter/material.dart';

class YourCarScreen extends StatelessWidget {
  const YourCarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AddCarDetailsFireStore _addCarDetailsFirestore =
        AddCarDetailsFireStore();
    return Scaffold(
      bottomNavigationBar: InkWell(
        onTap: () {
          Get.to(
            () => AddCarsScreen(),
            transition: Transition.leftToRight,
            duration: const Duration(milliseconds: 700),
          );
        },
        child: Container(
          margin: EdgeInsets.all(10),
          height: 45,
          width: double.infinity,
          decoration: BoxDecoration(
            color: primaryColors,
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center,
          child: CustomText(
              text: 'Add Car',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: white,
                fontSize: 20,
              )),
        ),
      ),
      appBar: AppBar(
        title: CustomText(
          text: 'Your Cars',
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: FutureBuilder<List<AddCarDetails>>(
        future: _addCarDetailsFirestore.getUserCars(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final userCars = snapshot.data ?? [];

          if (userCars.isEmpty) {
            return Center(
              child: Text('No Cars Found'),
            );
          }

          return ListView.builder(
            itemCount: userCars.length,
            itemBuilder: (context, index) {
              final car = userCars[index];
              return ListTile(
                title: Text(car.carName),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Color: ${car.color}'),
                    Text('City: ${car.city}'),
                    Text('Transmission: ${car.transmissionType}'),
                    Text('Insurance: ${car.hasInsurance}'),
                  ],
                ),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(car.carImage),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
