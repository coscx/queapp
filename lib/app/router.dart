import 'package:flutter/material.dart';
import 'package:flutter_geen/views/app/navigation/unit_navigation.dart';
import 'package:flutter_geen/views/items/QrCode.dart';
import 'package:flutter_geen/views/pages/about/about_me_page.dart';
import 'package:flutter_geen/views/pages/about/about_app_page.dart';
import 'package:flutter_geen/views/pages/about/person_center_page.dart';
import 'package:flutter_geen/views/pages/about/recommendedCard.dart';
import 'package:flutter_geen/views/pages/about/time_line.dart';
import 'package:flutter_geen/views/pages/about/version_info.dart';
import 'package:flutter_geen/views/pages/category/category_detail.dart';
import 'package:flutter_geen/views/pages/category/collect_page.dart';
import 'package:flutter_geen/views/pages/chat/chat_page.dart';
import 'package:flutter_geen/views/pages/chat/conversation_list.dart';
import 'package:flutter_geen/views/pages/chat/group_page.dart';
import 'package:flutter_geen/views/pages/data/brower.dart';
import 'package:flutter_geen/views/pages/data/card.dart';
import 'package:flutter_geen/views/pages/gallery/gallery_page.dart';
import 'package:flutter_geen/views/pages/index/amap.dart';
import 'package:flutter_geen/views/pages/index/amap_index.dart';
import 'package:flutter_geen/views/pages/index/map.dart';
import 'package:flutter_geen/views/pages/issues_point/issues_detail.dart';
import 'package:flutter_geen/views/pages/issues_point/issues_point_page.dart';
import 'package:flutter_geen/views/pages/login/login_page.dart';
import 'package:flutter_geen/views/pages/login/logins.dart';
import 'package:flutter_geen/views/pages/search/serach_page.dart';
import 'package:flutter_geen/views/pages/search/serach_page_appoint.dart';
import 'package:flutter_geen/views/pages/setting/code_style_setting.dart';
import 'package:flutter_geen/views/pages/setting/font_setting.dart';
import 'package:flutter_geen/views/pages/setting/item_style_setting.dart';
import 'package:flutter_geen/views/pages/setting/theme_color_setting.dart';
import 'package:flutter_geen/views/pages/home/CreateUserPage.dart';
import 'package:flutter_geen/views/items/select.dart';
import 'package:flutter_geen/views/pages/user/User.dart';
import 'package:flutter_geen/views/pages/widget_detail/widget_detail_page.dart';

import 'package:flutter_geen/views/pages/setting/setting_page.dart';

import 'utils/router_utils.dart';

class UnitRouter {
  static const String detail = 'detail';
  static const String home = '/';
  static const String logo = 'logo';
  static const String search = 'search';
  static const String nav = 'nav';
  static const String widget_detail = 'WidgetDetail';
  static const String collect = 'CollectPage';
  static const String point = 'IssuesPointPage';
  static const String point_detail = 'IssuesDetailPage';

  static const String setting = 'SettingPage';
  static const String font_setting = 'FountSettingPage';
  static const String theme_color_setting = 'ThemeColorSettingPage';
  static const String code_style_setting = 'CodeStyleSettingPage';
  static const String item_style_setting = 'ItemStyleSettingPage';
  static const String version_info = 'VersionInfo';
  static const String login = 'login';

  static const String category_show = 'CategoryShow';
  static const String issues_point = 'IssuesPointPage';

  static const String attr = 'AttrUnitPage';
  static const String bug = 'BugUnitPage';
  static const String galley = 'GalleryPage';
  static const String layout = 'LayoutUnitPage';
  static const String about_me = 'AboutMePage';
  static const String about_app = 'AboutAppPage';
  static const String to_chat = 'ToChatPage';
  static const String to_chats = 'ChatsPage';
  static const String to_group_chat = 'GroupChatPage';
  static const String time_line = 'TimeLine';
  static const String chat_list = 'ChatList';
  static const String index_page = 'IndexPage';
  static const String brower = 'Brower';
  static const String recommended_card = 'RecommendedCard';
  static const String login_phone = 'LoginPhone';
  static const String person_page ='PersonCenterPage';
  static const String create_user_page ='CreateUserPage';
  static const String select_page ='SelectPage';
  static const String search_page_appoint ='SearchPageAppoint';
  static const String baidu_map ='BaiduMap';
  static const String user ='User';
  static const String qr_view ='QrView';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //根据名称跳转相应页面
      case widget_detail:
        return Right2LeftRouter(
            child: WidgetDetailPage(
        ));

      case search:
        return Right2LeftRouter(child: SearchPage());
      case search_page_appoint:
        return Right2LeftRouter(child: SearchPageAppoint());
      case select_page:
        return Right2LeftRouter(child: SelectPage(title: "ttt",));
      case collect:
        return Right2LeftRouter(child: CollectPage());
      case nav:
        return Left2RightRouter(child: UnitNavigation());
      case setting:
        return Right2LeftRouter(child: SettingPage());
      case font_setting:
        return Right2LeftRouter(child: FontSettingPage());
      case theme_color_setting:
        return Right2LeftRouter(child: ThemeColorSettingPage());
      case code_style_setting:
        return Right2LeftRouter(child: CodeStyleSettingPage());
      case item_style_setting:
        return Right2LeftRouter(child: ItemStyleSettingPage());
      case user:
        return Right2LeftRouter(child: UserPage());
      case version_info:
        return Right2LeftRouter(child: VersionInfo());
      case issues_point:
        return Right2LeftRouter(child: IssuesPointPage());
      case qr_view:
        return Right2LeftRouter(child: ScanView());
      case login:
        return Right2LeftRouter(child: LoginPage());
      // case baidu_map:
      //   return Right2LeftRouter(child: SelectLocationFromMapPage());

      case galley:
        return Right2LeftRouter(child: GalleryPage());

      case about_app:
        return Right2LeftRouter(child: AboutAppPage());
      case about_me:
        return Right2LeftRouter(child: AboutMePage());
      case to_chat:
        return Right2LeftRouter(child: AboutMePage());
      case to_chats:
        return Right2LeftRouter(child: ChatsPage(model: settings.arguments,));
      case to_group_chat:
        return Right2LeftRouter(child: GroupChatPage(model: settings.arguments,));
      case point_detail:
        return Right2LeftRouter(child: IssuesDetailPage());
      case index_page:
        return Right2LeftRouter(child: IndexPage());
      case login_phone:
        return Right2LeftRouter(child: LoginPhone());
      case recommended_card:
        return Right2LeftRouter(child: RecommendedCard());
      case create_user_page:
        return Right2LeftRouter(child: CreateUserPage());
      case person_page:
        return Right2LeftRouter(child: MinePage());

      case time_line:
        return Right2LeftRouter(child: TimelinePage(title: settings.arguments,));
      case brower:
        return Right2LeftRouter(child: Brower(url: settings.arguments,));
      case chat_list:
        return Right2LeftRouter(child: ImConversationListPage(memberId: settings.arguments,));
      case category_show:
        return Right2LeftRouter(
            child: CategoryShow(
          model: settings.arguments,
        ));

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
