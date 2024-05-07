import 'package:smart_sensors/res/routes/routes_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/device_data_model/device_data_model.dart';
import '../../../res/colors/app_colors/app_colors.dart';
import '../../../res/components/default_text/default_text.dart';

class DataTableWidget extends StatelessWidget {
  final RxList<DeviceDataModel?> deviceList;
  const DataTableWidget({super.key, required this.deviceList});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowHeight: 30,
        columnSpacing: 30,
        dataRowMinHeight: 0,
        dataRowMaxHeight: 30,
        dataTextStyle: const TextStyle(
            color: AppColors.whiteColor,
            overflow: TextOverflow.clip,
            fontSize: 9),
        border: const TableBorder(
          top: BorderSide(color: Colors.grey),
          bottom: BorderSide(color: Colors.grey),
          left: BorderSide(color: Colors.grey),
          right: BorderSide(color: Colors.grey),
          verticalInside: BorderSide(color: Colors.grey),
        ),
        columns: const [
          DataColumn(
            label: DefaultText(
              text: 'User ID',
              fontSize: 9,
              color: AppColors.linearColor1,
            ),
          ),
          DataColumn(
              label: DefaultText(
            text: 'Device ID',
            fontSize: 9,
            color: AppColors.linearColor1,
          )),
        ],
        rows: deviceList.map((doc) {
          // final userId = doc['userId'] as String; // Replace with your field names
          // final deviceId = doc['deviceId'] as String;
          return DataRow(cells: [
            DataCell(Text(FirebaseAuth.instance.currentUser!.email!)),
            DataCell(onTap: () {
              Get.toNamed(RouteName.deviceDataView, arguments: doc);
            },
                Text(doc?.deviceName?.isEmpty ?? true
                    ? "Unknown device"
                    : doc!.deviceName!)),
          ]);
        }).toList(),
      ),
    );
  }
}
