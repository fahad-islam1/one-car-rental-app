class AddCarDetails {
  String carName;
  String carImage;
  String carCategory;
  String color;
  String numberPlate;
  String alphabet;
  String city;
  String transmissionType; // Added transmissionType field
  String hasInsurance; // Added hasInsurance field

  AddCarDetails({
    required this.carName,
    required this.carImage,
    required this.carCategory,
    required this.color,
    required this.numberPlate,
    required this.alphabet,
    required this.city,
    required this.transmissionType,
    required this.hasInsurance,
  });

  Map<String, dynamic> toMap() {
    return {
      'carName': carName,
      'carImage': carImage,
      'carCategory': carCategory,
      'color': color,
      'numberPlate': numberPlate,
      'alphabet': alphabet,
      'city': city,
      'transmissionType': transmissionType,
      'hasInsurance': hasInsurance,
    };
  }

  factory AddCarDetails.fromMap(Map<String, dynamic> map) {
    return AddCarDetails(
      carName: map['carName'],
      carImage: map['carImage'],
      carCategory: map['carCategory'],
      color: map['color'],
      numberPlate: map['numberPlate'],
      alphabet: map['alphabet'],
      city: map['city'],
      transmissionType: map['transmissionType'],
      hasInsurance: map['hasInsurance'],
    );
  }
}
