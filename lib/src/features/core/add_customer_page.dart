import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../database/database_helper.dart';

import 'customer_list_page.dart';

class AddCustomerController extends GetxController {
  var name = ''.obs;
  var mobile = ''.obs;
  var email = ''.obs;
  var address = ''.obs;
  var latitude = ''.obs;
  var longitude = ''.obs;
  var image = ''.obs;

  File? selectedImage;

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      image.value = pickedFile.path;
    }
  }

  void saveCustomer({int? id}) async {
    if (name.isEmpty ||
        mobile.isEmpty ||
        email.isEmpty ||
        address.isEmpty ||
        latitude.isEmpty ||
        longitude.isEmpty ||
        image.isEmpty) {
      Get.snackbar('Error', 'All fields are required');
      return;
    }

    double? lat;
    double? lon;
    try {
      lat = double.parse(latitude.value);
      lon = double.parse(longitude.value);
    } catch (e) {
      Get.snackbar('Error', 'Invalid latitude or longitude');
      return;
    }

    await DBHelper.addCustomer(
      name.value,
      mobile.value,
      email.value,
      address.value,
      lat,
      lon,
      image.value,
      id: id,
    );
    Get.back();
  }
}

class AddCustomerPage extends StatelessWidget {
  final Customer? customer;
  final addCustomerController = Get.put(AddCustomerController());

  AddCustomerPage({this.customer}) {
    if (customer != null) {
      addCustomerController.name.value = customer!.name;
      addCustomerController.mobile.value = customer!.mobile;
      addCustomerController.email.value = customer!.email;
      addCustomerController.address.value = customer!.geoAddress;
      addCustomerController.latitude.value = customer!.latitude.toString();
      addCustomerController.longitude.value = customer!.longitude.toString();
      addCustomerController.image.value = customer!.image;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(customer != null ? 'Edit Customer' : 'Add Customer',
            style: const TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent.shade200,
      ),
      body: Container(
        color: Colors.grey[200], // Set the background color here
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTextField(
                label: 'Full Name',
                icon: Iconsax.user_copy,
                onChanged: (value) => addCustomerController.name.value = value,
                controller: TextEditingController(text: customer?.name),
              ),
              _buildTextField(
                label: 'Mobile No',
                icon: Iconsax.call_copy,
                onChanged: (value) =>
                    addCustomerController.mobile.value = value,
                controller: TextEditingController(text: customer?.mobile),
              ),
              _buildTextField(
                label: 'Email',
                icon: Icons.email_outlined,
                onChanged: (value) => addCustomerController.email.value = value,
                controller: TextEditingController(text: customer?.email),
              ),
              _buildTextField(
                label: 'Geo Address',
                icon: Iconsax.location_copy,
                onChanged: (value) =>
                    addCustomerController.address.value = value,
                controller: TextEditingController(text: customer?.geoAddress),
              ),
              _buildTextField(
                label: 'Latitude',
                icon: Iconsax.map_copy,
                onChanged: (value) =>
                    addCustomerController.latitude.value = value,
                controller:
                    TextEditingController(text: customer?.latitude.toString()),
              ),
              _buildTextField(
                label: 'Longitude',
                icon: Iconsax.map_copy,
                onChanged: (value) =>
                    addCustomerController.longitude.value = value,
                controller:
                    TextEditingController(text: customer?.longitude.toString()),
              ),
              const SizedBox(height: 16.0),
              Obx(() {
                return addCustomerController.image.value.isEmpty
                    ? const Text('No Image Selected',
                        style: TextStyle(fontSize: 16))
                    : Image.file(File(addCustomerController.image.value));
              }),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => addCustomerController.pickImage(),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Text('Pick Image'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () =>
                    addCustomerController.saveCustomer(id: customer?.id),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: Text(
                    customer != null ? 'Update Customer' : 'Save Customer'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    required ValueChanged<String> onChanged,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.blue, width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.blue, width: 2.0),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        ),
      ),
    );
  }
}
