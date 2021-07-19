import 'package:flutter/material.dart';
import 'package:flutter_geen/views/app/navigation/unit_navigation.dart';
import 'package:flutter_geen/views/pages/chat/chat_page.dart';
import 'package:flutter_geen/views/pages/chat/conversation_list.dart';
import 'package:flutter_geen/views/pages/chat/group_page.dart';
import 'package:flutter_geen/views/pages/discovery/pages/discovery_page.dart';
import 'package:flutter_geen/views/pages/discovery/pages/nearby_list_page.dart';
import 'package:flutter_geen/views/pages/discovery/pages/topic_detail_page.dart';
import 'package:flutter_geen/views/pages/dynamic/pages/dynamic_detail_page.dart';
import 'package:flutter_geen/views/pages/dynamic/pages/dynamic_page.dart';
import 'package:flutter_geen/views/pages/dynamic/pages/dynamic_video_page.dart';
import 'package:flutter_geen/views/pages/dynamic/pages/search_page.dart';
import 'package:flutter_geen/views/pages/login/login_page.dart';
import 'package:flutter_geen/views/pages/user/pages/User.dart';


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
  static const String discoveryPage = "discoveryPage";
  static const String topicDetailPage = "topicDetailPage";
  static const String nearListPage = "nearbyListPage";

  static const String dynamicPage = "dynamicPage";
  static const String dynamicDetailPage = "dynamicDetailPage";
  static const String dynamicVideoPage = "dynamicVideoPage";
  static const String photoViewGalleryScreen = "photoViewGalleryScreen";
  static const String search_index = "searchIndexPage";
  static const String login_new = "loginNewPage";
  static const String send_code = "sendCodePage";
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case discoveryPage:
        return Right2LeftRouter(child: DiscoveryPage());
      case topicDetailPage:
        return Right2LeftRouter(child: TopicDetailPage());
      case nearListPage:
        return Right2LeftRouter(child: NearbyListPage());

      case dynamicPage:
        return Right2LeftRouter(child: DynamicPage());
      case dynamicDetailPage:
        return Right2LeftRouter(child: DynamicDetailPage());
      case dynamicVideoPage:
        return Right2LeftRouter(child: DynamicVideoPage());
      case search_index:
        return Right2LeftRouter(child: SearchIndexPage());
      case login:
        return Right2LeftRouter(child: LoginPage());

      case nav:
        return NoAnimRouter(child: UnitNavigation());

      // case baidu_map:
      //   return Right2LeftRouter(child: SelectLocationFromMapPage());
      case user:
        return Right2LeftRouter(child: UserPage());

      case to_chats:
        return Right2LeftRouter(child: ChatsPage(model: settings.arguments,));
      case to_group_chat:
        return Right2LeftRouter(child: GroupChatPage(model: settings.arguments,));

      case chat_list:
        return Right2LeftRouter(child: ImConversationListPage(memberId: settings.arguments,));


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
