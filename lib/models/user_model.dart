class UserModel {
  String id;
  String name;
  String age;
  String height;
  String weight;
  String gender;
  String healthConditions;
  String foodType;
  String email;

  UserModel({
    required this.id,
    required this.name,
    required this.age,
    required this.height,
    required this.weight,
    required this.gender,
    required this.healthConditions,
    required this.foodType,
    required this.email,
  });

  // Convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'height': height,
      'weight': weight,
      'gender': gender,
      'healthConditions': healthConditions,
      'foodType': foodType,
      'email': email,
    };
  }

  // Factory constructor to create UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      height: json['height'],
      weight: json['weight'],
      gender: json['gender'],
      healthConditions: json['healthConditions'],
      foodType: json['foodType'],
      email: json['email'],
    );
  }
}
