import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const WeFriendsApp());
}

// ========================================================
// GLOBAL APP STATE & ECONOMY ENGINE (BoloHi System)
// ========================================================
class AppState {
  static String myName = "Tarun Chouhan";
  static String myId = "882910";
  static String myAvatar = "👑";
  static int coins = 85000;
  static int diamonds = 24500;
  static int level = 28;
  static String vipTitle = "King 👑";
  static bool isLoggedIn = false;

  static List<Map<String, dynamic>> rooms = [
    {"id": 1024, "title": "Desi Adda ☕", "host": "Aryan 👑", "hostAvatar": "🤴", "views": "3.8K", "isPK": true},
    {"id": 1089, "title": "Late Melodies 🎸", "host": "Simran ✨", "hostAvatar": "👧", "views": "2.1K", "isPK": false},
    {"id": 2011, "title": "Ludo & Lucky 777 🎲", "host": "Lucky Gamer", "hostAvatar": "🎲", "views": "1.4K", "isPK": false},
    {"id": 3055, "title": "Soulmate Lounge ❤️", "host": "Neha", "hostAvatar": "🌸", "views": "4.2K", "isPK": true},
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

// ========================================================
// 1. SPLASH SCREEN (BOLOHI STYLE)
// ========================================================
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AppState.isLoggedIn ? const MainNavigationScreen() : const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(center: Alignment.center, radius: 1.2, colors: [Color(0xFF2B104A), Color(0xFF0B0813)]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [Color(0xFF7B2CBF), Color(0xFFFF007F)]),
              ),
              child: const Center(child: Text("W", style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold, color: Colors.white))),
            ),
            const SizedBox(height: 20),
            RichText(
              text: const TextSpan(
                text: 'We',
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.5),
                children: [TextSpan(text: 'Friends', style: TextStyle(color: Color(0xFFFF007F)))],
              ),
            ),
            const SizedBox(height: 6),
            const Text("Live Voice Party & Social World", style: TextStyle(color: Color(0xFF00F5D4), fontSize: 13)),
          ],
        ),
      ),
    );
  }
}

// ========================================================
// 2. MULTI-LOGIN SCREEN
// ========================================================
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
            const Text("WeFriends", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 8),
            const Text("Enter the party with millions of friends worldwide", style: TextStyle(color: Colors.white60, fontSize: 13), textAlign: TextAlign.center),
            const Spacer(),
            _socialButton("🌐 Continue with Google", const Color(0xFF1F1635), () => _login(context)),
            const SizedBox(height: 12),
            _socialButton("📱 Phone Number Login", const Color(0xFF1F1635), () => _login(context)),
            const SizedBox(height: 12),
            _socialButton("👥 Continue with Facebook", const Color(0xFF1877F2), () => _login(context)),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => _login(context),
              child: const Text("⚡ Fast Guest Login", style: TextStyle(color: Color(0xFF00F5D4), fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _socialButton(String text, Color bg, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: bg, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
        onPressed: onTap,
        child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ),
    );
  }
}

// ========================================================
// 3. MAIN NAVIGATION TABS
// ========================================================
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomeScreen(),
      const ChatListScreen(),
      Container(), // Center trigger
      const MomentsFeedScreen(),
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
            _showCreateRoomDialog();
          } else {
            setState(() => _currentIndex = index);
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Party"),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: "Chat"),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle, size: 44, color: Color(0xFFFF007F)), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: "Moments"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Me"),
        ],
      ),
    );
  }

  void _showCreateRoomDialog() {
    final controller = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1A1230),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 20, right: 20, top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Create Live Voice Room 🎤", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Enter Room Name...",
                filled: true,
                fillColor: const Color(0xFF251A44),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF007F)),
                onPressed: () {
                  final title = controller.text.trim();
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VoiceRoomScreen(
                        roomData: {
                          "id": 9901,
                          "title": title.isEmpty ? "My Super Party ☕" : title,
                          "host": AppState.myName,
                          "hostAvatar": AppState.myAvatar,
                          "views": "1",
                          "isPK": false,
                        },
                      ),
                    ),
                  );
                },
                child: const Text("Launch Live Room 🚀", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// ========================================================
// 4. HOMEPAGE: BOLOHI PARTY HALL
// ========================================================
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0813),
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(radius: 16, backgroundColor: const Color(0xFFFF007F), child: Text(AppState.myAvatar, style: const TextStyle(fontSize: 15))),
            const SizedBox(width: 10),
            const Text("WeFriends", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: const Color(0xFF1E1535), borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFFFD700))),
            child: Row(
              children: [
                const Text("🪙 ", style: TextStyle(fontSize: 12)),
                Text("${AppState.coins}", style: const TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold, fontSize: 12)),
              ],
            ),
          ),
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // PK Banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(colors: [Color(0xFF7B2CBF), Color(0xFFFF007F)]),
              ),
              child: const Row(
                children: [
                  Text("⚔️", style: TextStyle(fontSize: 32)),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("LIVE PK TOURNAMENT", style: TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold, fontSize: 12)),
                      Text("Watch Top Hosts Battle Live!", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text("🔥 Popular Rooms", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.95,
              ),
              itemCount: AppState.rooms.length,
              itemBuilder: (context, index) {
                final room = AppState.rooms[index];
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
                      border: Border.all(color: room['isPK'] == true ? const Color(0xFFFF007F) : const Color(0xFF2E1C4F), width: 1.5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (room['isPK'] == true)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(6)),
                                child: const Text("⚔️ PK", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                              )
                            else
                              const Text("🎙️ 8/8", style: TextStyle(color: Color(0xFF00F5D4), fontSize: 11, fontWeight: FontWeight.bold)),
                            Text("👁️ ${room['views']}", style: const TextStyle(color: Color(0xFFFFD700), fontSize: 11)),
                          ],
                        ),
                        const Spacer(),
                        Text(room['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        const SizedBox(height: 4),
                        Text("Host: ${room['host']}", style: const TextStyle(color: Colors.white60, fontSize: 11)),
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

// ========================================================
// 5. LIVE VOICE ROOM (PK BATTLE, 8-MICS, MINI-GAMES, GIFTS)
// ========================================================
class VoiceRoomScreen extends StatefulWidget {
  final Map<String, dynamic> roomData;
  const VoiceRoomScreen({Key? key, required this.roomData}) : super(key: key);

  @override
  State<VoiceRoomScreen> createState() => _VoiceRoomScreenState();
}

class _VoiceRoomScreenState extends State<VoiceRoomScreen> {
  bool isMuted = false;
  bool isPKActive = false;
  int pkBluePoints = 5200;
  int pkRedPoints = 3800;
  String? activeGiftBanner;

  late List<Map<String, dynamic>> seats;
  final TextEditingController _msgCtrl = TextEditingController();
  final ScrollController _scrollCtrl = ScrollController();

  List<Map<String, String>> chatList = [
    {"user": "System 📢", "msg": "Welcome to WeFriends live room! Respect host & members."},
  ];

  @override
  void initState() {
    super.initState();
    isPKActive = widget.roomData['isPK'] ?? false;
    seats = List.generate(8, (i) {
      if (i == 0) return {"name": widget.roomData['host'], "avatar": widget.roomData['hostAvatar'] ?? "👑", "isMe": false};
      return {"name": "Mic ${i + 1}", "avatar": null, "isMe": false};
    });
  }

  void _onSeatTap(int index) {
    setState(() {
      final seat = seats[index];
      if (seat['avatar'] == null) {
        seat['avatar'] = AppState.myAvatar;
        seat['name'] = AppState.myName;
        seat['isMe'] = true;
        chatList.add({"user": "System 📢", "msg": "${AppState.myName} joined Mic ${index + 1} 🎙️"});
      } else if (seat['isMe'] == true) {
        seat['avatar'] = null;
        seat['name'] = "Mic ${index + 1}";
        seat['isMe'] = false;
        chatList.add({"user": "System 📢", "msg": "${AppState.myName} left the mic."});
      }
    });
  }

  void _sendChat() {
    final text = _msgCtrl.text.trim();
    if (text.isEmpty) return;
    setState(() {
      chatList.add({"user": AppState.myName, "msg": text});
    });
    _msgCtrl.clear();
    Timer(const Duration(milliseconds: 100), () {
      if (_scrollCtrl.hasClients) _scrollCtrl.jumpTo(_scrollCtrl.position.maxScrollExtent);
    });
  }

  void _sendGift(String name, int price, String emoji) {
    if (AppState.coins < price) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Coins khatam! Please recharge."), backgroundColor: Colors.red));
      return;
    }
    setState(() {
      AppState.coins -= price;
      AppState.diamonds += (price * 0.7).toInt();
      if (isPKActive) pkBluePoints += price; // Send gift in PK battle
      activeGiftBanner = "$emoji $name Sent by ${AppState.myName}!";
      chatList.add({"user": "🎁 GIFT", "msg": "${AppState.myName} sent $name to Host!"});
    });
    Navigator.pop(context);
    Timer(const Duration(seconds: 3), () {
      if (mounted) setState(() => activeGiftBanner = null);
    });
  }

  // Mini-Game Modal (Lucky Spin Wheel & Ludo)
  void _openGamesModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E1436),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("In-Room Mini Games 🎲", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _gameItem("🎡 Lucky Spin", () {
                  Navigator.pop(context);
                  _playLuckySpin();
                }),
                _gameItem("🎲 Ludo Arena", () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Ludo match starting... 🎲")));
                }),
                _gameItem("🎰 777 Slots", () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Connecting to 777 Slots server...")));
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _playLuckySpin() {
    setState(() {
      AppState.coins += 500;
      chatList.add({"user": "🎉 GAME", "msg": "${AppState.myName} won 500 Coins in Lucky Spin Wheel!"});
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("🎉 Congratulations! You won 500 Coins!"), backgroundColor: Colors.green));
  }

  Widget _gameItem(String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(color: const Color(0xFF2E1C4F), borderRadius: BorderRadius.circular(15)),
        child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF00F5D4))),
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
            Text(widget.roomData['title'], style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            Text("Room ID: ${widget.roomData['id']} • Online: ${widget.roomData['views']}", style: const TextStyle(fontSize: 11, color: Color(0xFF00F5D4))),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(isPKActive ? Icons.flash_on : Icons.flash_off, color: isPKActive ? Colors.redAccent : Colors.grey),
            onPressed: () => setState(() => isPKActive = !isPKActive),
          ),
          IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // =================== PK BATTLE ARENA ===================
              if (isPKActive)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B112E),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.redAccent, width: 1.5),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("🔵 Host 1: $pkBluePoints", style: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold)),
                          const Text("⚔️ PK BATTLE (03:45)", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 12)),
                          Text("🔴 Host 2: $pkRedPoints", style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Progress Battle Bar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Row(
                          children: [
                            Expanded(flex: pkBluePoints, child: Container(height: 10, color: Colors.blueAccent)),
                            Expanded(flex: pkRedPoints, child: Container(height: 10, color: Colors.redAccent)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              // =================== 8-SEAT MIC MATRIX ===================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                  itemBuilder: (context, i) {
                    final seat = seats[i];
                    final hasUser = seat['avatar'] != null;

                    return GestureDetector(
                      onTap: () => _onSeatTap(i),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 26,
                            backgroundColor: const Color(0xFF1F1635),
                            child: hasUser ? Text(seat['avatar'], style: const TextStyle(fontSize: 22)) : const Icon(Icons.mic_none, color: Colors.white38),
                          ),
                          const SizedBox(height: 4),
                          Text(seat['name'], style: TextStyle(fontSize: 11, color: hasUser ? Colors.white : Colors.white54), overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // =================== LIVE CHAT ===================
              Expanded(
                child: ListView.builder(
                  controller: _scrollCtrl,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: chatList.length,
                  itemBuilder: (context, i) {
                    final item = chatList[i];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Text("${item['user']}: ${item['msg']}", style: const TextStyle(fontSize: 13, color: Colors.white70)),
                    );
                  },
                ),
              ),

              // =================== BOTTOM BAR ===================
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                color: const Color(0xFF130D24),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(color: const Color(0xFF22173D), borderRadius: BorderRadius.circular(20)),
                        child: TextField(
                          controller: _msgCtrl,
                          decoration: const InputDecoration(hintText: "Say something...", border: InputBorder.none, hintStyle: TextStyle(color: Colors.white38, fontSize: 12)),
                          onSubmitted: (_) => _sendChat(),
                        ),
                      ),
                    ),
                    IconButton(icon: const Icon(Icons.send, color: Color(0xFFFF007F)), onPressed: _sendChat),
                    IconButton(icon: const Icon(Icons.sports_esports, color: Color(0xFFFFD700)), onPressed: _openGamesModal),
                    IconButton(
                      icon: Icon(isMuted ? Icons.mic_off : Icons.mic, color: isMuted ? Colors.red : const Color(0xFF00F5D4)),
                      onPressed: () => setState(() => isMuted = !isMuted),
                    ),
                    // Gift Button
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: const Color(0xFF1A1230),
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
                          builder: (context) => Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("BoloHi Gifts 🎁", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                    Text("Coins: ${AppState.coins} 🪙", style: const TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    _giftBtn("Rose", 50, "🌹"),
                                    _giftBtn("Sports Car", 1000, "🏎️"),
                                    _giftBtn("Rocket", 5000, "🚀"),
                                    _giftBtn("Castle", 10000, "🏰"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [Color(0xFF7B2CBF), Color(0xFFFF007F)])),
                        child: const Icon(Icons.card_giftcard, color: Colors.white, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Gift Popup
          if (activeGiftBanner != null)
            Positioned(
              top: 80,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFFFF007F), Color(0xFF7B2CBF)]),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: Text(activeGiftBanner!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white)),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _giftBtn(String name, int price, String emoji) {
    return GestureDetector(
      onTap: () => _sendGift(name, price, emoji),
      child: Column(
        children: [
          Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFF261846), borderRadius: BorderRadius.circular(15)), child: Text(emoji, style: const TextStyle(fontSize: 30))),
          const SizedBox(height: 4),
          Text(name, style: const TextStyle(fontSize: 11)),
          Text("$price 🪙", style: const TextStyle(color: Color(0xFFFFD700), fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// ========================================================
// 6. CHAT LIST SCREEN
// ========================================================
class ChatListScreen extends StatelessWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFF0B0813), elevation: 0, title: const Text("Messages & DMs 💬")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(leading: CircleAvatar(backgroundColor: Color(0xFFFF007F), child: Text("📢")), title: Text("WeFriends Official"), subtitle: Text("Welcome! Claim daily login bonus.")),
          ListTile(leading: CircleAvatar(backgroundColor: Color(0xFF7B2CBF), child: Text("👧")), title: Text("Simran ✨"), subtitle: Text("Hey, join the PK Battle tonight!")),
        ],
      ),
    );
  }
}

// ========================================================
// 7. MOMENTS FEED
// ========================================================
class MomentsFeedScreen extends StatelessWidget {
  const MomentsFeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFF0B0813), elevation: 0, title: const Text("Moments ✨")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: const Color(0xFF171129), borderRadius: BorderRadius.circular(18)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Aryan 👑 (VIP King)", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF00F5D4))),
                SizedBox(height: 6),
                Text("Just hit 50,000 Diamonds in PK Battle! Thanks to my supporters! 🚀🔥"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ========================================================
// 8. PROFILE (ME) - VIP & DIAMONDS CASHOUT
// ========================================================
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFF0B0813), elevation: 0, title: const Text("My Account 👤")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(radius: 38, backgroundColor: const Color(0xFFFF007F), child: Text(AppState.myAvatar, style: const TextStyle(fontSize: 34))),
            const SizedBox(height: 8),
            Text(AppState.myName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text("WeFriends ID: ${AppState.myId} • ${AppState.vipTitle}", style: const TextStyle(color: Color(0xFF00F5D4), fontSize: 13, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),

            // Wallet & Cashout Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(colors: [Color(0xFF281545), Color(0xFF150C26)]),
                border: Border.all(color: const Color(0xFFFFD700)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text("🪙 ${AppState.coins}", style: const TextStyle(color: Color(0xFFFFD700), fontSize: 18, fontWeight: FontWeight.bold)),
                      const Text("Coins Balance", style: TextStyle(color: Colors.white60, fontSize: 12)),
                    ],
                  ),
                  Column(
                    children: [
                      Text("💎 ${AppState.diamonds}", style: const TextStyle(color: Color(0xFF00F5D4), fontSize: 18, fontWeight: FontWeight.bold)),
                      const Text("Host Diamonds", style: TextStyle(color: Colors.white60, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Withdrawal Button
            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00F5D4), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Cashout Request: ₹${AppState.diamonds ~/ 100} initiated to Bank/UPI!"), backgroundColor: Colors.green),
                  );
                },
                child: const Text("💸 Withdraw Diamonds to Cash (Bank/UPI)", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
