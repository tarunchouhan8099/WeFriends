import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const WeFriendsApp());
}

// Global App State (User Data & Economy)
class AppState {
  static String myName = "Tarun Chouhan";
  static String myId = "882910";
  static String myAvatar = "👑";
  static int coins = 50000;
  static int diamonds = 12450;
  static int level = 18;
  static bool isLoggedIn = false;

  static List<Map<String, String>> visitors = [
    {"name": "Simran (Host) ✨", "avatar": "👧", "time": "2 mins ago"},
    {"name": "Aryan 👑", "avatar": "🤴", "time": "15 mins ago"},
    {"name": "Priya Sharma", "avatar": "🌸", "time": "1 hour ago"},
    {"name": "Lucky Gamer", "avatar": "🎲", "time": "Yesterday"},
  ];
}

class WeFriendsApp extends StatelessWidget {
  const WeFriendsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeFriends',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B0813),
        fontFamily: 'sans-serif',
      ),
      home: const SplashScreen(),
    );
  }
}

// ==========================================
// 1. FULL-SCREEN CINEMATIC SPLASH SCREEN
// ==========================================
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    _scaleAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack);
    _controller.forward();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AppState.isLoggedIn ? const MainNavigationScreen() : const LoginScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.2,
            colors: [Color(0xFF261245), Color(0xFF0B0813)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(colors: [Color(0xFF7B2CBF), Color(0xFFFF007F)]),
                  boxShadow: [
                    BoxShadow(color: const Color(0xFFFF007F).withOpacity(0.5), blurRadius: 40, spreadRadius: 10),
                  ],
                ),
                child: const Center(
                  child: Text("W", style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ),
            const SizedBox(height: 25),
            RichText(
              text: const TextSpan(
                text: 'We',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 2),
                children: [
                  TextSpan(text: 'Friends', style: TextStyle(color: Color(0xFFFF007F))),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Text("Live Voice Party & Virtual World", style: TextStyle(color: Color(0xFF00F5D4), fontSize: 13, letterSpacing: 1.2)),
            const SizedBox(height: 50),
            const SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(strokeWidth: 2.5, color: Color(0xFFFF007F)),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 2. MULTI-LOGIN SYSTEM SCREEN
// ==========================================
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  void _login(BuildContext context) {
    AppState.isLoggedIn = true;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainNavigationScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [Color(0xFF7B2CBF), Color(0xFFFF007F)]),
              ),
              child: const Center(child: Text("W", style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold, color: Colors.white))),
            ),
            const SizedBox(height: 15),
            const Text("Welcome to WeFriends", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const Text("Join thousands of live voice parties worldwide", style: TextStyle(color: Colors.white60, fontSize: 12)),
            const Spacer(),

            // Google Login
            _loginButton(
              title: "Continue with Google",
              icon: "🌐",
              color: const Color(0xFF1F1635),
              textColor: Colors.white,
              onTap: () => _login(context),
            ),
            const SizedBox(height: 12),

            // Phone Login
            _loginButton(
              title: "Log in with Phone OTP",
              icon: "📱",
              color: const Color(0xFF1F1635),
              textColor: Colors.white,
              onTap: () => _login(context),
            ),
            const SizedBox(height: 12),

            // Facebook Login
            _loginButton(
              title: "Continue with Facebook",
              icon: "👥",
              color: const Color(0xFF1877F2),
              textColor: Colors.white,
              onTap: () => _login(context),
            ),
            const SizedBox(height: 16),

            // Fast Guest Login
            TextButton(
              onPressed: () => _login(context),
              child: const Text("⚡ Fast Guest Login (Instant Play)", style: TextStyle(color: Color(0xFF00F5D4), fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _loginButton({required String title, required String icon, required Color color, required Color textColor, required VoidCallback onTap}) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25), side: BorderSide(color: Colors.white.withOpacity(0.1))),
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(icon, style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 12),
            Text(title, style: TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 3. MAIN APP CONTROLLER & BOTTOM TABS
// ==========================================
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  void _showCreateRoomSheet() {
    final titleController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF18102E),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 20, right: 20, top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Create Live Voice Party 🎤", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 15),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Enter room title (e.g. Chill & Music 🎵)",
                hintStyle: const TextStyle(color: Colors.white38),
                filled: true,
                fillColor: const Color(0xFF241842),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF007F),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                onPressed: () {
                  final text = titleController.text.trim();
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VoiceRoomScreen(
                        roomData: {
                          "id": 9012,
                          "title": text.isEmpty ? "My WeFriends Party ☕" : text,
                          "views": "1",
                          "host": AppState.myName,
                          "hostAvatar": AppState.myAvatar,
                        },
                      ),
                    ),
                  );
                },
                child: const Text("Launch Room Now 🚀", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomeScreen(),
      const ChatScreen(),
      Container(),
      const MomentsScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF130E22),
        selectedItemColor: const Color(0xFFFF007F),
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 2) {
            _showCreateRoomSheet();
          } else {
            setState(() => _currentIndex = index);
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Rooms"),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: "Messages"),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle, size: 42, color: Color(0xFFFF007F)), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: "Moments"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Me"),
        ],
      ),
    );
  }
}

// ==========================================
// 4. HOMEPAGE: LIVE CHATROOMS HALL
// ==========================================
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> rooms = const [
    {"id": 1024, "title": "Desi Adda ☕", "host": "Aryan 👑", "hostAvatar": "🤴", "mics": "8/8", "views": "2.4K", "tag": "🔥 Trending"},
    {"id": 1089, "title": "Late Melodies 🎸", "host": "Simran ✨", "hostAvatar": "👧", "mics": "6/8", "views": "1.8K", "tag": "🎤 Karaoke"},
    {"id": 2011, "title": "Ludo Arena 🎲", "host": "Lucky", "hostAvatar": "🎲", "mics": "4/8", "views": "890", "tag": "🎲 Gaming"},
    {"id": 3055, "title": "Soulmate Lounge ❤️", "host": "Neha", "hostAvatar": "🌸", "mics": "8/8", "views": "3.1K", "tag": "❤️ Chill"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0813),
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(radius: 17, backgroundColor: const Color(0xFFFF007F), child: Text(AppState.myAvatar, style: const TextStyle(fontSize: 16))),
            const SizedBox(width: 10),
            RichText(
              text: const TextSpan(
                text: 'We',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                children: [TextSpan(text: 'Friends', style: TextStyle(color: Color(0xFFFF007F)))],
              ),
            ),
          ],
        ),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: const Color(0xFF1E1535), borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFFFD700))),
            child: Row(
              children: [
                const Text("🪙 ", style: TextStyle(fontSize: 12)),
                Text("${AppState.coins ~/ 1000}K", style: const TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold, fontSize: 13)),
              ],
            ),
          ),
          IconButton(icon: const Icon(Icons.notifications_none, color: Colors.white70), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carnival Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(colors: [Color(0xFF7B2CBF), Color(0xFFFF007F)]),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("🌟 WEFRIENDS CARNIVAL", style: TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold, fontSize: 12)),
                  SizedBox(height: 4),
                  Text("Mega PK Voice Championship", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text("Send gifts & rank #1 on the leaderboard!", style: TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text("🔴 Live Voice Chatrooms", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 12),

            // Live Rooms Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.95,
              ),
              itemCount: rooms.length,
              itemBuilder: (context, index) {
                final room = rooms[index];
                return InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => VoiceRoomScreen(roomData: room)));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF171129),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFF2E1C4F)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("🎙️ ${room['mics']}", style: const TextStyle(color: Color(0xFF00F5D4), fontSize: 11, fontWeight: FontWeight.bold)),
                            Text("👁️ ${room['views']}", style: const TextStyle(color: Color(0xFFFFD700), fontSize: 11)),
                          ],
                        ),
                        const Spacer(),
                        Text(room['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white)),
                        const SizedBox(height: 4),
                        Text("Host: ${room['host']}", style: const TextStyle(color: Colors.white60, fontSize: 12)),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(color: const Color(0xFF281744), borderRadius: BorderRadius.circular(6)),
                          child: Text(room['tag'], style: const TextStyle(color: Color(0xFF00F5D4), fontSize: 10)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 5. LIVE 8-SEAT VOICE ROOM WITH PROFILE SEATS,
//    WORKING CHAT TYPING & VIRTUAL GIFTS
// ==========================================
class VoiceRoomScreen extends StatefulWidget {
  final Map<String, dynamic> roomData;
  const VoiceRoomScreen({Key? key, required this.roomData}) : super(key: key);

  @override
  State<VoiceRoomScreen> createState() => _VoiceRoomScreenState();
}

class _VoiceRoomScreenState extends State<VoiceRoomScreen> {
  bool isMuted = false;
  late List<Map<String, dynamic>> seats;
  final TextEditingController _chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String? activeGiftAnimation;

  List<Map<String, String>> chatMessages = [
    {"user": "System 📢", "msg": "Welcome to WeFriends official live voice party!"},
  ];

  @override
  void initState() {
    super.initState();
    // 8 Seats Matrix
    seats = List.generate(8, (index) {
      if (index == 0) {
        return {
          "name": widget.roomData['host'] ?? "Host 👑",
          "avatar": widget.roomData['hostAvatar'] ?? "👑",
          "isSpeaking": true,
          "isMe": false,
        };
      }
      return {
        "name": "Mic ${index + 1}",
        "avatar": null,
        "isSpeaking": false,
        "isMe": false,
      };
    });
  }

  // Sit or Leave Seat
  void _handleSeatTap(int index) {
    setState(() {
      final seat = seats[index];
      if (seat['avatar'] == null) {
        // Sit down on mic with MY Profile and MY Name
        seat['name'] = AppState.myName;
        seat['avatar'] = AppState.myAvatar;
        seat['isSpeaking'] = true;
        seat['isMe'] = true;
        _addChatMessage("System 📢", "${AppState.myName} sat on Mic ${index + 1} 🎙️");
      } else if (seat['isMe'] == true) {
        // Leave seat
        seat['name'] = "Mic ${index + 1}";
        seat['avatar'] = null;
        seat['isSpeaking'] = false;
        seat['isMe'] = false;
        _addChatMessage("System 📢", "${AppState.myName} left the mic.");
      } else {
        // View Other User's Mini Profile
        _showUserProfileModal(seat['name'], seat['avatar'] ?? "👤");
      }
    });
  }

  void _addChatMessage(String sender, String message) {
    setState(() {
      chatMessages.add({"user": sender, "msg": message});
    });
    Timer(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage() {
    final text = _chatController.text.trim();
    if (text.isEmpty) return;
    _addChatMessage(AppState.myName, text);
    _chatController.clear();
  }

  // Virtual Gifting Logic (Coins deduction + Diamond earnings + Big Screen Animation)
  void _sendGift(String name, int coinPrice, String emoji) {
    if (AppState.coins < coinPrice) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Insufficient coins! Please recharge in wallet."), backgroundColor: Colors.redAccent),
      );
      return;
    }

    setState(() {
      AppState.coins -= coinPrice;
      AppState.diamonds += (coinPrice * 0.7).toInt(); // Host earns 70% in diamonds
      activeGiftAnimation = "$emoji $name";
      _addChatMessage("🎁 GIFT", "${AppState.myName} sent $name ($coinPrice 🪙) to Host!");
    });

    Navigator.pop(context); // Close gift modal

    // Remove gift animation after 3.5 seconds
    Timer(const Duration(milliseconds: 3500), () {
      if (mounted) setState(() => activeGiftAnimation = null);
    });
  }

  void _showUserProfileModal(String name, String avatar) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1B1230),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(radius: 36, backgroundColor: const Color(0xFFFF007F), child: Text(avatar, style: const TextStyle(fontSize: 32))),
            const SizedBox(height: 10),
            Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Text("WeFriends Star Member • Level 15", style: TextStyle(color: Color(0xFF00F5D4), fontSize: 12)),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF007F)),
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Followed $name!")));
                    },
                    child: const Text("Follow +"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF281A44)),
                    onPressed: () {
                      Navigator.pop(context);
                      _addChatMessage(AppState.myName, "@$name Hey, let's talk in DM!");
                    },
                    child: const Text("Say Hi 👋"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.roomData['title'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text("ID: ${widget.roomData['id']} • Online: ${widget.roomData['views']}", style: const TextStyle(fontSize: 11, color: Color(0xFF00F5D4))),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.close, color: Colors.white), onPressed: () => Navigator.pop(context)),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // 8-SEAT MIC GRID
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 0.82,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    final seat = seats[index];
                    final hasUser = seat['avatar'] != null;

                    return GestureDetector(
                      onTap: () => _handleSeatTap(index),
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              // Pulse ring for speaker
                              Container(
                                width: 62,
                                height: 62,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: (seat['isSpeaking'] == true) ? const Color(0xFF00F5D4) : Colors.transparent,
                                    width: 2.5,
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                radius: 26,
                                backgroundColor: const Color(0xFF1E1535),
                                child: hasUser
                                    ? Text(seat['avatar'], style: const TextStyle(fontSize: 22))
                                    : const Icon(Icons.mic_none, color: Colors.white38, size: 22),
                              ),
                              if (index == 0)
                                const Positioned(top: 0, child: Text("👑", style: TextStyle(fontSize: 13))),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            seat['name'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 11, color: hasUser ? Colors.white : Colors.white54, fontWeight: hasUser ? FontWeight.bold : FontWeight.normal),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // LIVE IN-ROOM CHAT STREAM
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: chatMessages.length,
                    itemBuilder: (context, i) {
                      final item = chatMessages[i];
                      final isSystem = item['user']!.contains("System") || item['user']!.contains("GIFT");
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3.0),
                        child: RichText(
                          text: TextSpan(
                            text: "${item['user']}: ",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: isSystem ? const Color(0xFFFFD700) : const Color(0xFF00F5D4),
                            ),
                            children: [
                              TextSpan(
                                text: item['msg']!,
                                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // BOTTOM WORKING TYPING INPUT & GIFT CONTROLS
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                color: const Color(0xFF130D24),
                child: Row(
                  children: [
                    // Text Input Field
                    Expanded(
                      child: Container(
                        height: 42,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(color: const Color(0xFF22173D), borderRadius: BorderRadius.circular(21)),
                        child: TextField(
                          controller: _chatController,
                          style: const TextStyle(color: Colors.white, fontSize: 13),
                          decoration: const InputDecoration(
                            hintText: "Say something friendly...",
                            hintStyle: TextStyle(color: Colors.white38, fontSize: 12),
                            border: InputBorder.none,
                          ),
                          onSubmitted: (_) => _sendMessage(),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send, color: Color(0xFFFF007F), size: 20),
                      onPressed: _sendMessage,
                    ),

                    // Mic Mute / Unmute
                    IconButton(
                      icon: Icon(isMuted ? Icons.mic_off : Icons.mic, color: isMuted ? Colors.redAccent : const Color(0xFF00F5D4)),
                      onPressed: () => setState(() => isMuted = !isMuted),
                    ),

                    // Gifting Store Button
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: const Color(0xFF18102E),
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
                          builder: (context) => Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Gift Store 🎁", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                                    Text("Balance: ${AppState.coins} 🪙", style: const TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    _giftItem("Rose", 50, "🌹"),
                                    _giftItem("Sports Car", 1000, "🏎️"),
                                    _giftItem("Rocket", 5000, "🚀"),
                                    _giftItem("Castle", 10000, "🏰"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(colors: [Color(0xFF7B2CBF), Color(0xFFFF007F)]),
                        ),
                        child: const Icon(Icons.card_giftcard, color: Colors.white, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // FULL-SCREEN GIFT BANNER POPUP ANIMATION
          if (activeGiftAnimation != null)
            Positioned(
              top: 100,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFFFF007F), Color(0xFF7B2CBF)]),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(color: const Color(0xFFFF007F).withOpacity(0.6), blurRadius: 25, spreadRadius: 5),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("🌟 ", style: TextStyle(fontSize: 22)),
                    Text(
                      activeGiftAnimation!,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const Text(" 🌟", style: TextStyle(fontSize: 22)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _giftItem(String name, int price, String emoji) {
    return GestureDetector(
      onTap: () => _sendGift(name, price, emoji),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: const Color(0xFF261947), borderRadius: BorderRadius.circular(15)),
            child: Text(emoji, style: const TextStyle(fontSize: 32)),
          ),
          const SizedBox(height: 6),
          Text(name, style: const TextStyle(fontSize: 12, color: Colors.white)),
          Text("$price 🪙", style: const TextStyle(color: Color(0xFFFFD700), fontSize: 11, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// ==========================================
// 6. DIRECT MESSAGING (DM) SCREEN
// ==========================================
class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFF0B0813), elevation: 0, title: const Text("Direct Messages 💬")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _chatTile(context, "WeFriends Official 📢", "Welcome! Check out the new VIP store rewards.", "Just now", true),
          _chatTile(context, "Simran (Host) ✨", "Hey Tarun! Join my room, we are singing Bollywood songs!", "5m ago", false),
          _chatTile(context, "Aryan 👑", "Bro thanks for supporting in the PK battle! 🏎️", "1h ago", false),
        ],
      ),
    );
  }

  Widget _chatTile(BuildContext context, String name, String msg, String time, bool isSystem) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => PrivateConversationScreen(friendName: name)));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: const Color(0xFF171129), borderRadius: BorderRadius.circular(15), border: Border.all(color: const Color(0xFF24163E))),
        child: Row(
          children: [
            CircleAvatar(backgroundColor: isSystem ? const Color(0xFFFF007F) : const Color(0xFF7B2CBF), child: Text(isSystem ? "📢" : "👤")),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 4),
                  Text(msg, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white60, fontSize: 12)),
                ],
              ),
            ),
            Text(time, style: const TextStyle(color: Colors.white38, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}

class PrivateConversationScreen extends StatefulWidget {
  final String friendName;
  const PrivateConversationScreen({Key? key, required this.friendName}) : super(key: key);

  @override
  State<PrivateConversationScreen> createState() => _PrivateConversationScreenState();
}

class _PrivateConversationScreenState extends State<PrivateConversationScreen> {
  final List<String> messages = ["Hey there!", "Welcome to WeFriends!"];
  final TextEditingController _msgController = TextEditingController();

  void _send() {
    if (_msgController.text.trim().isEmpty) return;
    setState(() => messages.add(_msgController.text.trim()));
    _msgController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.friendName), backgroundColor: const Color(0xFF130E22)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, i) => Align(
                alignment: i % 2 == 0 ? Alignment.centerLeft : Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: i % 2 == 0 ? const Color(0xFF20163B) : const Color(0xFFFF007F),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(messages[i], style: const TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            color: const Color(0xFF130E22),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _msgController,
                    decoration: InputDecoration(
                      hintText: "Type a secret message...",
                      filled: true,
                      fillColor: const Color(0xFF22173D),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                    ),
                  ),
                ),
                IconButton(icon: const Icon(Icons.send, color: Color(0xFFFF007F)), onPressed: _send),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 7. MOMENTS & STORIES FEED SCREEN
// ==========================================
class MomentsScreen extends StatelessWidget {
  const MomentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFF0B0813), elevation: 0, title: const Text("Moments & Stories ✨")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _momentPost("Aryan 👑", "VIP Star", "Won the Mega PK Battle yesterday! Thank you everyone for the rockets 🚀❤️", "❤️ 412 Likes"),
          const SizedBox(height: 16),
          _momentPost("Neha 🌸", "Top Singer", "Live singing session starting in 10 minutes. Drop in and chill 🎶", "❤️ 298 Likes"),
        ],
      ),
    );
  }

  Widget _momentPost(String name, String badge, String content, String likes) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF171129), borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFF2E1C4F))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(backgroundColor: Color(0xFFFF007F), child: Text("👑")),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  Text(badge, style: const TextStyle(color: Color(0xFF00F5D4), fontSize: 11)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(content, style: const TextStyle(fontSize: 13, color: Colors.white)),
          const SizedBox(height: 12),
          Text(likes, style: const TextStyle(color: Color(0xFFFF007F), fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// ==========================================
// 8. PROFILE ("ME") SCREEN: VISITORS & WALLET
// ==========================================
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFF0B0813), elevation: 0, title: const Text("My Profile 👤")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(radius: 40, backgroundColor: const Color(0xFFFF007F), child: Text(AppState.myAvatar, style: const TextStyle(fontSize: 36))),
            const SizedBox(height: 10),
            Text(AppState.myName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text("WeFriends ID: ${AppState.myId}", style: const TextStyle(color: Color(0xFF00F5D4), fontSize: 13, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),

            // Coins & Diamonds Wallet Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(colors: [Color(0xFF241542), Color(0xFF140C26)]),
                border: Border.all(color: const Color(0xFFFFD700)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text("🪙 ${AppState.coins}", style: const TextStyle(color: Color(0xFFFFD700), fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      const Text("Coins Balance", style: TextStyle(color: Colors.white60, fontSize: 12)),
                    ],
                  ),
                  Column(
                    children: [
                      Text("💎 ${AppState.diamonds}", style: const TextStyle(color: Color(0xFF00F5D4), fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      const Text("Diamonds Earned", style: TextStyle(color: Colors.white60, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // Profile Visitors Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF171129),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF2A1C44)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("👀 Profile Visitors (Who Viewed You)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      Text("4 New", style: TextStyle(color: Color(0xFFFF007F), fontSize: 11, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...AppState.visitors.map((v) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Row(
                      children: [
                        CircleAvatar(radius: 16, backgroundColor: const Color(0xFF251842), child: Text(v['avatar']!)),
                        const SizedBox(width: 10),
                        Text(v['name']!, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                        const Spacer(),
                        Text(v['time']!, style: const TextStyle(color: Colors.white38, fontSize: 11)),
                      ],
                    ),
                  )),
                ],
              ),
            ),
            const SizedBox(height: 15),

            _profileMenuItem(Icons.stars, "VIP Membership & Badges"),
            _profileMenuItem(Icons.headset_mic, "Agency Center / Host Income Cashout"),
            _profileMenuItem(Icons.settings, "Privacy & Safety Settings"),
          ],
        ),
      ),
    );
  }

  Widget _profileMenuItem(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(color: const Color(0xFF171129), borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFFF007F), size: 20),
          const SizedBox(width: 14),
          Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, color: Colors.white38, size: 14),
        ],
      ),
    );
  }
}
