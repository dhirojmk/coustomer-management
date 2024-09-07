import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher package

import '../../constants/text_strings.dart';
import '../../database/database_helper.dart';
import 'add_customer_page.dart';

class Customer {
  int? id;
  final String name;
  final String mobile;
  final String email;
  final String geoAddress;
  final double latitude;
  final double longitude;
  final String image;

  Customer({
    this.id,
    required this.name,
    required this.mobile,
    required this.email,
    required this.geoAddress,
    required this.latitude,
    required this.longitude,
    required this.image,
  });
}

class CustomerController extends GetxController {
  var customers = <Customer>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadCustomers();
  }

  Future<void> loadCustomers() async {
    final List<Map<String, dynamic>> customerData =
        await DBHelper.getCustomers();
    customers.value = customerData.map((data) {
      return Customer(
        id: data['id'],
        name: data['name'],
        mobile: data['mobile'],
        email: data['email'],
        geoAddress: data['geoAddress'],
        latitude: data['latitude'],
        longitude: data['longitude'],
        image: data['image'],
      );
    }).toList();
  }

  void deleteCustomer(int id) async {
    await DBHelper.deleteCustomer(id);
    loadCustomers();
  }
}

class CustomerListPage extends StatelessWidget {
  final customerController = Get.put(CustomerController());

  void _launchMap(double latitude, double longitude) async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Customer List', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent.shade200,
      ),
      body: Container(
        color: Colors.grey[200], // Set the background color here
        child: Obx(() {
          if (customerController.customers.isEmpty) {
            return const Center(
                child: Text('No customers found',
                    style: TextStyle(fontSize: 18, color: Colors.grey)));
          }
          return ListView.builder(
            itemCount: customerController.customers.length,
            itemBuilder: (context, index) {
              final customer = customerController.customers[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: CircleAvatar(
                        backgroundImage: FileImage(File(customer.image)),
                      ),
                      title: Text(customer.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Iconsax.call_copy,
                                  size: 20.0, color: Colors.black),
                              const SizedBox(width: 8.0),
                              Expanded(
                                  child: Text(customer.mobile,
                                      style:
                                          TextStyle(color: Colors.grey[700]))),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.mail_outlined,
                                  size: 20.0, color: Colors.black),
                              const SizedBox(width: 8.0),
                              Expanded(
                                  child: Text(customer.email,
                                      style:
                                          TextStyle(color: Colors.grey[700]))),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Iconsax.location_copy,
                                  size: 20.0, color: Colors.black),
                              const SizedBox(width: 8.0),
                              Expanded(
                                  child: Text(customer.geoAddress,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          TextStyle(color: Colors.grey[700]))),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Iconsax.map_copy,
                                size: 20.0, color: Colors.blue),
                            onPressed: () {
                              _launchMap(customer.latitude, customer.longitude);
                            },
                          ),
                          const SizedBox(height: 1),
                          IconButton(
                            icon: const Icon(Iconsax.edit_2_copy,
                                size: 20.0, color: Colors.blueAccent),
                            onPressed: () {
                              Get.to(() => AddCustomerPage(customer: customer))
                                  ?.then((_) =>
                                      customerController.loadCustomers());
                            },
                          ),
                          const SizedBox(height: 1),
                          IconButton(
                            icon: const Icon(Iconsax.profile_delete_copy,
                                size: 20.0, color: Colors.red),
                            onPressed: () {
                              customerController.deleteCustomer(customer.id!);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          Get.to(AddCustomerPage())
              ?.then((_) => customerController.loadCustomers());
        },
        child: const Icon(Iconsax.folder_add_copy),
      ),
    );
  }
}
