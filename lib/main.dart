import 'package:flutter/material.dart';

void main() {
  runApp(const WeFriendsApp());
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
      ),
      home: const MainNavigationScreen(),
    );
  }
}

// ----------------- MAIN BOTTOM NAVIGATION CONTROLLER -----------------
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  void _showCreateRoomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF18102E),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Create Live Party Room 🎤", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                hintText: "Enter your party room title...",
                hintStyle: const TextStyle(color: Colors.white38),
                filled: true,
                fillColor: const Color(0xFF241842),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 15),
            const Text("Select Room Tag:", style: TextStyle(fontSize: 13, color: Colors.white70)),
            const SizedBox(height: 8),
            Row(
              children: [
                _tagChip("🎤 Karaoke"),
                const SizedBox(width: 8),
                _tagChip("🎲 Gaming"),
                const SizedBox(width: 8),
                _tagChip("❤️ Dating"),
              ],
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
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const VoiceRoomScreen(
                        roomData: {"id": 9999, "title": "My New Party Room ☕", "views": "1", "host": "Me 👑"},
                      ),
                    ),
                  );
                },
                child: const Text("Launch Room Now 🚀", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tagChip(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: const Color(0xFF281744), borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFF00F5D4))),
      child: Text(title, style: const TextStyle(color: Color(0xFF00F5D4), fontSize: 11, fontWeight: FontWeight.bold)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const HomeScreen(),
      const ChatScreen(),
      Container(), // Dummy for Center +
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
            _showCreateRoomSheet(); // Center Plus Opens Create Room
          } else {
            setState(() => _currentIndex = index);
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: "Chat"),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle, size: 42, color: Color(0xFFFF007F)), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: "Moments"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Me"),
        ],
      ),
    );
  }
}

// ----------------- 1. HOME SCREEN -----------------
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> rooms = const [
    {"id": 1024, "title": "Desi Adda ☕", "host": "Aryan 👑", "mics": "8/8", "views": "2.4K", "tag": "🔥 Trending"},
    {"id": 1089, "title": "Late Melodies 🎸", "host": "Simran ✨", "mics": "6/8", "views": "1.8K", "tag": "🎤 Karaoke"},
    {"id": 2011, "title": "Ludo Champions 🎲", "host": "Lucky", "mics": "4/8", "views": "890", "tag": "🎲 Gaming"},
    {"id": 3055, "title": "Soulmate Lounge ❤️", "host": "Neha", "mics": "8/8", "views": "3.1K", "tag": "❤️ Chill"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0813),
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFFFF007F), width: 2)),
              child: const CircleAvatar(radius: 16, backgroundColor: Color(0xFF2A1C44), child: Text("👑", style: TextStyle(fontSize: 14))),
            ),
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
            child: const Row(
              children: [
                Text("🪙 ", style: TextStyle(fontSize: 12)),
                Text("45.2K", style: TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold, fontSize: 13)),
              ],
            ),
          ),
          IconButton(icon: const Icon(Icons.search, color: Colors.white70), onPressed: () {}),
          IconButton(icon: const Icon(Icons.notifications_none, color: Colors.white70), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                    SizedBox(height: 6),
                    Text("Mega PK Voice Battle", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                    Text("Win 100,000 Diamonds & VIP Badges!", style: TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text("🔴 Live Party Rooms", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
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
                itemCount: rooms.length,
                itemBuilder: (context, index) {
                  final room = rooms[index];
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
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
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ----------------- 2. CHAT SCREEN -----------------
class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFF0B0813), elevation: 0, title: const Text("Messages & Friends 💬")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _chatTile("WeFriends Official 📢", "Welcome to WeFriends! Claim 500 bonus coins now.", "10:30 AM", true),
          _chatTile("Simran (Host) ✨", "Hey! Join my Karaoke room tonight at 9 PM!", "Yesterday", false),
          _chatTile("Aryan 👑", "Thanks for the sports car gift bro! 🏎️", "Yesterday", false),
        ],
      ),
    );
  }

  Widget _chatTile(String name, String msg, String time, bool isSystem) {
    return Container(
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
    );
  }
}

// ----------------- 3. MOMENTS SCREEN -----------------
class MomentsScreen extends StatelessWidget {
  const MomentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFF0B0813), elevation: 0, title: const Text("Moments & Stories ✨")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _momentPost("Aryan 👑", "Level 25 Party Star", "Won the Mega PK Battle yesterday! Thank you all supporters! ❤️🎉", "❤️ 342 Likes"),
          const SizedBox(height: 16),
          _momentPost("Neha 🌸", "Host", "Live singing session starting in 10 minutes. Drop your song requests! 🎶", "❤️ 189 Likes"),
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

// ----------------- 4. PROFILE SCREEN -----------------
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
            const CircleAvatar(radius: 40, backgroundColor: Color(0xFFFF007F), child: Text("👑", style: TextStyle(fontSize: 36))),
            const SizedBox(height: 10),
            const Text("User_Tarun 🌟", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text("WeFriends ID: 882910", style: TextStyle(color: Color(0xFF00F5D4), fontSize: 13, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),

            // Wallet Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(colors: [Color(0xFF241542), Color(0xFF140C26)]),
                border: Border.all(color: const Color(0xFFFFD700)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text("🪙 45,200", style: TextStyle(color: Color(0xFFFFD700), fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text("Coins Balance", style: TextStyle(color: Colors.white60, fontSize: 12)),
                    ],
                  ),
                  Column(
                    children: [
                      Text("💎 1,250", style: TextStyle(color: Color(0xFF00F5D4), fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text("Diamonds Earned", style: TextStyle(color: Colors.white60, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            _profileMenuItem(Icons.account_balance_wallet, "My Wallet & Recharge"),
            _profileMenuItem(Icons.stars, "VIP Membership & Crown"),
            _profileMenuItem(Icons.headset_mic, "Agency Center / Host Income"),
            _profileMenuItem(Icons.settings, "App Settings"),
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

// ----------------- 5. LIVE 8-SEAT VOICE PARTY ROOM -----------------
class VoiceRoomScreen extends StatefulWidget {
  final Map<String, dynamic> roomData;
  const VoiceRoomScreen({Key? key, required this.roomData}) : super(key: key);

  @override
  State<VoiceRoomScreen> createState() => _VoiceRoomScreenState();
}

class _VoiceRoomScreenState extends State<VoiceRoomScreen> {
  bool isMuted = false;
  late List<Map<String, dynamic>> seats;
  List<String> chatLogs = ["📢 System: Welcome to WeFriends Party Room!"];

  @override
  void initState() {
    super.initState();
    seats = List.generate(8, (index) {
      if (index == 0) {
        return {"name": widget.roomData['host'], "avatar": "👑", "speaking": true};
      }
      return {"name": "Mic ${index + 1}", "avatar": null, "speaking": false};
    });
  }

  void sitOnMic(int index) {
    setState(() {
      if (seats[index]['avatar'] == null) {
        seats[index]['avatar'] = "🎧";
        seats[index]['name'] = "You";
        chatLogs.add("🎙️ You sat on Mic ${index + 1}!");
      } else if (seats[index]['name'] == "You") {
        seats[index]['avatar'] = null;
        seats[index]['name'] = "Mic ${index + 1}";
        chatLogs.add("👋 You left the mic.");
      }
    });
  }

  void sendGift(String giftName) {
    setState(() {
      chatLogs.add("🎁 You sent a $giftName to Host!");
    });
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Sent $giftName successfully!"), backgroundColor: const Color(0xFFFF007F)),
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
            Text("Room ID: ${widget.roomData['id']} • Online: ${widget.roomData['views']}", style: const TextStyle(fontSize: 11, color: Color(0xFF00F5D4))),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
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
                  onTap: () => sitOnMic(index),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: seat['speaking'] ? const Color(0xFF00F5D4) : Colors.transparent, width: 2),
                            ),
                          ),
                          CircleAvatar(
                            radius: 26,
                            backgroundColor: const Color(0xFF1E1535),
                            child: hasUser
                                ? Text(seat['avatar'], style: const TextStyle(fontSize: 22))
                                : const Icon(Icons.mic_none, color: Colors.white38, size: 22),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(seat['name'], style: TextStyle(fontSize: 11, color: hasUser ? Colors.white : Colors.white54)),
                    ],
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                itemCount: chatLogs.length,
                itemBuilder: (context, i) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(chatLogs[i], style: const TextStyle(color: Colors.white70, fontSize: 13)),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: const Color(0xFF140D26),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 42,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(color: const Color(0xFF22173D), borderRadius: BorderRadius.circular(21)),
                    alignment: Alignment.centerLeft,
                    child: const Text("Say something friendly...", style: TextStyle(color: Colors.white54, fontSize: 12)),
                  ),
                ),
                IconButton(
                  icon: Icon(isMuted ? Icons.mic_off : Icons.mic, color: isMuted ? Colors.redAccent : const Color(0xFF00F5D4)),
                  onPressed: () => setState(() => isMuted = !isMuted),
                ),
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
                            const Text("Send Virtual Gift 🎁", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _giftItem("🌹 Rose", "50 🪙", () => sendGift("🌹 Rose")),
                                _giftItem("🏎️ Sports Car", "1,000 🪙", () => sendGift("🏎️ Sports Car")),
                                _giftItem("🚀 Rocket", "5,000 🪙", () => sendGift("🚀 Rocket")),
                                _giftItem("🏰 Castle", "10,000 🪙", () => sendGift("🏰 Castle")),
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
                    child: const Icon(Icons.card_giftcard, color: Colors.white, size: 22),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _giftItem(String name, String price, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(name.split(" ")[0], style: const TextStyle(fontSize: 32)),
          const SizedBox(height: 4),
          Text(price, style: const TextStyle(color: Color(0xFFFFD700), fontSize: 11, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}                              
