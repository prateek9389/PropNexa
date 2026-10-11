import 'package:go_router/go_router.dart';
import '../../ui/screens/splash/splash_screen.dart';
import '../../ui/screens/onboarding/onboarding_screen.dart';
import '../../ui/screens/auth/login_screen.dart';
import '../../ui/screens/auth/register_screen.dart';
import '../../ui/screens/auth/otp_screen.dart';
import '../../ui/screens/auth/forgot_password_screen.dart';
import '../../ui/screens/home/main_navigation_screen.dart';
import '../../ui/screens/property/property_details_screen.dart';
import '../../ui/screens/post/sell_property_form.dart';
import '../../ui/screens/listings/my_listings_screen.dart';
import '../../ui/screens/explore/map_view_screen.dart';
import '../../ui/screens/explore/filter_screen.dart';
import '../../ui/screens/auth/otp_verification_screen.dart';

class AppRoutes {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const register = '/register';
  static const otp = '/otp';
  static const forgotPassword = '/forgot-password';
  static const mainNavigation = '/main';
  static const sellProperty = '/sell-property';
  static const myListings = '/my-listings';
  static const postSelection = '/post-selection';
  static const map = '/map';
  static const filter = '/filter';
  static const otpVerification = '/otp-verification';

  static final router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: otp,
        builder: (context, state) => const OtpScreen(),
      ),
      GoRoute(
        path: forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: mainNavigation,
        builder: (context, state) => const MainNavigationScreen(),
      ),
      GoRoute(
        path: '/property/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return PropertyDetailsScreen(propertyId: id);
        },
      ),
      GoRoute(
        path: postSelection,
        builder: (context, state) => const MainNavigationScreen(initialIndex: 2),
      ),
      GoRoute(
        path: map,
        builder: (context, state) => const MapViewScreen(),
      ),
      GoRoute(
        path: filter,
        builder: (context, state) => const FilterScreen(),
      ),
      GoRoute(
        path: otpVerification,
        builder: (context, state) => const OtpVerificationScreen(),
      ),
      GoRoute(
        path: sellProperty,
        builder: (context, state) => const SellPropertyForm(),
      ),
      GoRoute(
        path: myListings,
        builder: (context, state) => const MyListingsScreen(),
      ),
    ],
  );
}

