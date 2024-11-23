part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const Splash = _Paths.SPLASH;
   static const HomeViews =_Paths.HOMEVIEW;
   static const MOVIEDETAILS =_Paths.MOVIEDETAILSVIEW;
   static const Favourite =_Paths.FAVOURITEMOVIE;
}

abstract class _Paths {
  _Paths._();
  static const SPLASH = '/splash_views';
   static const HOMEVIEW ='/home_views';
   static const MOVIEDETAILSVIEW ='/movies_detailsviews';
   static const FAVOURITEMOVIE ='/favouriteViews';
}
