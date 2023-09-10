import 'package:faza_app/Module/auth/intro/intro_screen.dart';
import 'package:faza_app/Module/auth/login/login_screen.dart';
import 'package:faza_app/Module/auth/otp/otp.dart';
import 'package:faza_app/Module/auth/register/register.dart';
import 'package:faza_app/Module/events/add_event/add_event_screen.dart';
import 'package:faza_app/Module/events/my_events/my_events_screen.dart';
import 'package:faza_app/Module/favorite/favorite_product_screen.dart';
import 'package:faza_app/Module/home/category/category_screen.dart';
import 'package:faza_app/Module/language/language_selector.dart';
import 'package:faza_app/Module/location_permission/location_permission_screen.dart';
import 'package:faza_app/Module/notification/notification_screen.dart';
import 'package:faza_app/Module/order/order_checkout/order_checkout.dart';
import 'package:faza_app/Module/order/order_completed_order/order_completed_detail.dart';
import 'package:faza_app/Module/order/order_detail/order_detail.dart';
import 'package:faza_app/Module/order/order_listing/order_listing.dart';
import 'package:faza_app/Module/product/cart/cart_screen.dart';
import 'package:faza_app/Module/home/personal_shopping/personal_shopping_screen.dart';
import 'package:faza_app/Module/product/product_detail/components/gallery.dart';
import 'package:faza_app/Module/product/product_detail/product_detail_screen.dart';
import 'package:faza_app/Module/product/product_list/product_list_screen.dart';
import 'package:faza_app/Module/search/search_screen.dart';
import 'package:faza_app/Module/setting/about_us/about_us.dart';
import 'package:faza_app/Module/setting/address/add_address/add_address_screen.dart';
import 'package:faza_app/Module/setting/address/address_list/address_list_screen.dart';
import 'package:faza_app/Module/setting/contant_us/contact_us_screen.dart';
import 'package:faza_app/Module/setting/edit_profile/edit_profile.dart';
import 'package:faza_app/Module/setting/portfolio/portfolio.dart';
import 'package:faza_app/Module/setting/profile/profile.dart';
import 'package:faza_app/Module/setting/subscription/subscription_screen.dart';
import 'package:faza_app/Module/tab/tab.dart';
import 'package:get/get.dart';
import '../Module/home/category/catogery_list_screen.dart';
import '../Module/home/category/subCatogery_list_screen.dart';
import '../Module/select_city/select_city.dart';
import '../Module/setting/T_C/t_c.dart';

class Routes {
  static const initial = '/';
  static final routes = [
    GetPage(name: '/language', page: () => const LanguageSelectorScreen()),
    GetPage(name: '/intro', page: () => const IntroScreen()),
    GetPage(name: '/select-city', page: () => const CitySelectionPage()),
    GetPage(name: '/login', page: () => const LoginScreen()),
    GetPage(name: '/otp', page: () => const OtpScreen()),
    GetPage(name: '/register', page: () => const RegisterScreen()),
    GetPage(name: '/', page: () => const NavigationTabScreen()),
    GetPage(name: '/profile', page: () => const ProfileScreen()),
    GetPage(name: '/edit-profile', page: () => const EditProfileScreen()),
    GetPage(name: '/portfolio', page: () => const PortfolioScreen()),
    GetPage(name: '/add-address', page: () => const AddAddressScreen()),
    GetPage(name: '/address-list', page: () => const AddressListScreen()),
    GetPage(name: '/contact-us', page: () => const ContactUsScreen()),
    GetPage(name: '/T&C', page: () => const TAndCScreen()),
    GetPage(name: '/about-us', page: () => const AboutUsScreen()),
    GetPage(name: '/category', page: () => const CategoryScreen()),
    GetPage(name: '/product-list', page: () => const ProductListScreen()),
    GetPage(name: '/Category-list', page: () => const CategoryListScreen()),
    GetPage(
        name: '/subCategory-list', page: () => const SubCategoryListScreen()),
    GetPage(name: '/product-detail', page: () => const ProductDetailScreen()),
    GetPage(name: '/cart', page: () => const CartScreen()),
    GetPage(name: '/my-events', page: () => const MyEventScreen()),
    GetPage(name: '/create-event', page: () => const CreateEventScreen()),
    GetPage(
        name: '/favorite-product', page: () => const FavoriteProductScreen()),
    GetPage(name: '/notification', page: () => const NotificationScreen()),
    GetPage(name: '/order-list', page: () => const OrderListScreen()),
    GetPage(name: '/order-detail', page: () => const OrderDetailScreen()),
    GetPage(name: '/order-checkout', page: () => const OrderCheckOutScreen()),
    GetPage(name: '/search', page: () => const SearchScreen()),
    GetPage(name: '/subscription', page: () => const SubscriptionScreen()),
    GetPage(
        name: '/personal_shopping', page: () => const PersonalShoppingScreen()),
    GetPage(name: '/gallery', page: () => const GalleryPage()),
    GetPage(
        name: '/order-complete-detail',
        page: () => const OrderCompletedDetailScreen()),
    GetPage(
        name: '/location-permission',
        page: () => const LocationPermissionScreen()),
  ];
}
