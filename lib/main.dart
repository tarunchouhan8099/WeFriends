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
      home: const HomeScreen(),
    );
  }
}

// ----------------- 1. HOME SCREEN -----------------
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> rooms = [
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
              // Event Banner
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

              // Room Cards Grid
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
                  return GestureDetector(
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF130E22),
        selectedItemColor: const Color(0xFFFF007F),
        unselectedItemColor: Colors.white54,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: "Chat"),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle, size: 38, color: Color(0xFFFF007F)), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: "Moments"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Me"),
        ],
      ),
    );
  }
}

// ----------------- 2. LIVE 8-SEAT VOICE PARTY ROOM -----------------
class VoiceRoomScreen extends StatefulWidget {
  final Map<String, dynamic> roomData;
  const VoiceRoomScreen({Key? key, required this.roomData}) : super(key: key);

  @override
  State<VoiceRoomScreen> createState() => _VoiceRoomScreenState();
}

class _VoiceRoomScreenState extends State<VoiceRoomScreen> {
  bool isMuted = false;
  List<String> chatLogs = ["📢 System: Welcome to WeFriends Party Room!"];

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
          // 8 Mic Seats Grid
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
                final isHostSeat = index == 0;
                return Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: isHostSeat ? const Color(0xFF00F5D4) : Colors.transparent, width: 2),
                          ),
                        ),
                        CircleAvatar(
                          radius: 26,
                          backgroundColor: const Color(0xFF1E1535),
                          child: Text(isHostSeat ? "👑" : (index == 1 ? "👧" : "🎙️"), style: const TextStyle(fontSize: 22)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(isHostSeat ? "Host" : "Mic ${index + 1}", style: const TextStyle(fontSize: 11, color: Colors.white70)),
                  ],
                );
              },
            ),
          ),

          // In-Room Chat Stream
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

          // Bottom Action Toolbar (Mic, Chat, Gift)
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
                // Virtual Gift Modal Button
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
