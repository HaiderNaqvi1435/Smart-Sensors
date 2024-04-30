import 'package:smart_sensors/res/routes/routes_name.dart';
import 'package:smart_sensors/views/my_devices_view/my_devices_view.dart';
import 'package:smart_sensors/views/scan_view/scan_view.dart';
import 'package:smart_sensors/views/sign_up_view/sign_up_view.dart';
import 'package:get/get.dart';
import 'package:smart_sensors/views/verify_email_view/verify_email_view.dart';

import '../../views/device_data_view/device_data_view.dart';
import '../../views/home_view/home_view.dart';
import '../../views/login_view/login_view.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
          name: RouteName.loginView,
          page: () => const LoginView(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.signUpView,
          page: () => const SignUpView(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
         GetPage(
          name: RouteName.verifyEmailView,
          page: () => const VerifyEmailView(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.homeView,
          page: () => const HomeView(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.scanView,
          page: () => const ScanView(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.myDevicesView,
          page: () => const MyDevicesView(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.deviceDataView,
          page: () => const DeviceDataView(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
      ];
}
