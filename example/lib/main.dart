import 'package:flutter/material.dart';

import 'package:umeng_analytics_plugin/umeng_analytics_plugin.dart'; // 导入你的插件

void main() {
  // 确保 Flutter Engine 绑定初始化
  WidgetsFlutterBinding.ensureInitialized();

  // 在 runApp 之前初始化友盟 (或者在 App 的 initState 中)
  // **重要：** 请替换为你自己的 AppKey 和 Channel
  UmengAnalyticsPlugin.initialize(
        androidAppKey: "xxx", // 替换为你的 Android AppKey
        iosAppKey: "xxx", // 替换为你的 iOS AppKey
        channel: "xxx", // 替换为你的渠道标识
        logEnabled: true, // 开发时建议开启日志
        encryptEnabled: true,
      )
      .then((_) {
        print("Umeng initialized successfully.");
      })
      .catchError((e) {
        print("Umeng initialization failed: $e");
      });

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // 进入首页时开始页面统计
    UmengAnalyticsPlugin.pageStart("HomePage");
  }

  @override
  void dispose() {
    // 离开首页时结束页面统计
    UmengAnalyticsPlugin.pageEnd("HomePage");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      // 可选：添加路由监听器，自动进行页面统计
      // navigatorObservers: [UmengPageObserver()],
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Umeng Plugin Example')),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 10),
                Text(
                  'Basic Events',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // 记录自定义事件
                    UmengAnalyticsPlugin.logEvent(
                      "button_click",
                      properties: {
                        "button_name": "TestEventButton",
                        "timestamp": DateTime.now().toIso8601String(),
                      },
                    );
                    print("Logged button_click event");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Logged "button_click" event')),
                    );
                  },
                  child: Text('Log Custom Event'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // 记录产品浏览事件
                    UmengAnalyticsPlugin.logEvent(
                      "product_view",
                      properties: {
                        "product_id": "P12345",
                        "product_name": "智能手表",
                        "category": "电子产品",
                        "price": "1299.00",
                        "currency": "CNY",
                      },
                    );
                    print("Logged product_view event");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Logged product view event')),
                    );
                  },
                  child: Text('Log Product View'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // 记录搜索事件
                    UmengAnalyticsPlugin.logEvent(
                      "search",
                      properties: {
                        "query": "智能手表",
                        "search_results_count": "42",
                        "filters_applied": "true",
                        "category_filter": "电子产品",
                        "price_range": "1000-2000",
                      },
                    );
                    print("Logged search event");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Logged search event')),
                    );
                  },
                  child: Text('Log Search'),
                ),
                const SizedBox(height: 20),
                Text(
                  'E-commerce Events',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // 记录加入购物车事件
                    UmengAnalyticsPlugin.logEvent(
                      "add_to_cart",
                      properties: {
                        "product_id": "P12345",
                        "product_name": "智能手表",
                        "price": "1299.00",
                        "currency": "CNY",
                        "quantity": "1",
                        "from_page": "productDetail",
                      },
                    );
                    print("Logged add_to_cart event");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Logged add to cart event')),
                    );
                  },
                  child: Text('Log Add to Cart'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // 记录购买事件
                    UmengAnalyticsPlugin.logEvent(
                      "purchase",
                      properties: {
                        "order_id": "O789456",
                        "total_items": "3",
                        "total_amount": "2598.00",
                        "currency": "CNY",
                        "payment_method": "Alipay",
                        "discount_applied": "true",
                        "discount_amount": "200.00",
                        "is_first_purchase": "true",
                        "products": "P12345,P23456,P34567",
                      },
                    );
                    print("Logged purchase event");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Logged purchase event')),
                    );
                  },
                  child: Text('Log Purchase'),
                ),
                const SizedBox(height: 20),
                Text(
                  'User Interaction Events',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // 记录内容分享事件
                    UmengAnalyticsPlugin.logEvent(
                      "content_share",
                      properties: {
                        "content_type": "article",
                        "content_id": "A98765",
                        "title": "如何使用友盟统计",
                        "share_platform": "WeChat",
                        "shared_by_user_id": "U12345",
                      },
                    );
                    print("Logged content_share event");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Logged content share event')),
                    );
                  },
                  child: Text('Log Content Share'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // 记录视频播放事件
                    UmengAnalyticsPlugin.logEvent(
                      "video_play",
                      properties: {
                        "video_id": "V75319",
                        "video_name": "Flutter 教程",
                        "duration": "324",
                        "category": "教育",
                        "creator": "开发者小王",
                        "quality": "HD",
                        "player_type": "embedded",
                      },
                    );
                    print("Logged video_play event");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Logged video play event')),
                    );
                  },
                  child: Text('Log Video Play'),
                ),
                const SizedBox(height: 20),
                Text(
                  'User Account Events',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // 模拟登录
                    UmengAnalyticsPlugin.signIn(
                      "testUser123",
                      provider: "Manual",
                    );
                    print("Logged signIn event for testUser123");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Logged signIn for "testUser123"'),
                      ),
                    );
                  },
                  child: Text('Log Sign In'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // 模拟登出
                    UmengAnalyticsPlugin.signOut();
                    print("Logged signOut event");
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Logged signOut')));
                  },
                  child: Text('Log Sign Out'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SecondPage()),
                    );
                  },
                  child: Text('Go to Second Page'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 可选：用于自动页面统计的路由监听器
// class UmengPageObserver extends RouteObserver<PageRoute<dynamic>> {
//   @override
//   void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
//     super.didPush(route, previousRoute);
//     if (route is PageRoute && route.settings.name != null) {
//       // 开始统计新页面
//       UmengAnalyticsPlugin.pageStart(route.settings.name!);
//     }
//   }

//   @override
//   void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
//     super.didPop(route, previousRoute);
//      if (route is PageRoute && route.settings.name != null) {
//       // 结束统计当前页面
//       UmengAnalyticsPlugin.pageEnd(route.settings.name!);
//     }
//      // 如果有上一页，需要重新开始统计上一页 (根据你的路由策略可能需要调整)
//      if (previousRoute is PageRoute && previousRoute.settings.name != null) {
//        UmengAnalyticsPlugin.pageStart(previousRoute.settings.name!);
//      }
//   }

//   @override
//   void didReplace({ Route<dynamic>? newRoute, Route<dynamic>? oldRoute }) {
//       super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
//       if (oldRoute is PageRoute && oldRoute.settings.name != null) {
//           UmengAnalyticsPlugin.pageEnd(oldRoute.settings.name!);
//       }
//       if (newRoute is PageRoute && newRoute.settings.name != null) {
//           UmengAnalyticsPlugin.pageStart(newRoute.settings.name!);
//       }
//   }
// }

// 第二个页面示例
class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  // 给页面设置一个名字，用于路由监听器
  static const routeName = '/secondPage';

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  void initState() {
    super.initState();
    // 手动模式：进入页面时开始统计
    UmengAnalyticsPlugin.pageStart("SecondPage");
  }

  @override
  void dispose() {
    // 手动模式：离开页面时结束统计
    UmengAnalyticsPlugin.pageEnd("SecondPage");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Second Page")),
      body: Center(child: Text("This is the second page.")),
    );
  }
}
