import 'package:flutter/material.dart';

void main() {
  runApp(const ChaleeApp());
}

class ChaleeApp extends StatelessWidget {
  const ChaleeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chalee',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[200],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
      ),
      home: const LoginPage(),
    );
  }
}

// --- LOGIN PAGE ---

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.school, size: 80, color: Colors.blue),
              const SizedBox(height: 10),
              const Text(
                'Chalee',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const Text(
                'Connect with your campus',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 40),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Student Email',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                child: const Text(
                  'Log In',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUpPage()),
                      );
                    },
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- SIGN UP PAGE ---

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? selectedYear;
  bool isNewStudent = false;
  bool admissionLetterUploaded = false;

  final List<String> years = [
    'Freshman (1st Year)',
    'Sophomore (2nd Year)',
    'Junior (3rd Year)',
    'Senior (4th Year)',
    'Graduate Student'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Join Chalee',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            // Full Name
            TextField(
              decoration: InputDecoration(
                labelText: 'Full Name',
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 15),

            // Student Email
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Student Email (.edu)',
                prefixIcon: const Icon(Icons.school),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                helperText: "Use your university email address.",
              ),
            ),
            const SizedBox(height: 15),

            // Password
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 15),

            // Student Year Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Year of Study',
                prefixIcon: const Icon(Icons.calendar_today),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              value: selectedYear,
              items: years.map((year) {
                return DropdownMenuItem(
                  value: year,
                  child: Text(year),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedYear = value;
                  isNewStudent = (value == 'Freshman (1st Year)');
                  if (!isNewStudent) {
                    admissionLetterUploaded = false;
                  }
                });
              },
            ),
            const SizedBox(height: 20),

            // Conditional UI: Admission Letter Upload
            if (isNewStudent) ...[
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.upload_file, color: Colors.blue, size: 40),
                    const SizedBox(height: 10),
                    const Text(
                      "You are a new student!",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    const Text(
                      "Please upload your Admission Letter to verify your enrollment.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: admissionLetterUploaded ? Colors.green : Colors.blue,
                      ),
                      icon: Icon(admissionLetterUploaded ? Icons.check : Icons.upload),
                      label: Text(
                        admissionLetterUploaded 
                          ? "Letter Uploaded" 
                          : "Upload Admission Letter (PDF/Image)"
                      ),
                      onPressed: () {
                        setState(() {
                          admissionLetterUploaded = true;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Admission letter uploaded successfully!")),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],

            // Terms Checkbox
            CheckboxListTile(
              value: true,
              onChanged: (val) {},
              title: const Text("I agree to the Terms of Service and Privacy Policy"),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 10),

            // Sign Up Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                if (isNewStudent && !admissionLetterUploaded) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please upload your admission letter first!")),
                  );
                  return;
                }
                
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: const Text(
                'Sign Up',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- HOME PAGE ---

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainFeed();
  }
}

// --- MAIN FEED ---

class MainFeed extends StatefulWidget {
  const MainFeed({super.key});

  @override
  State<MainFeed> createState() => _MainFeedState();
}

class _MainFeedState extends State<MainFeed> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> posts = [
    {
      "userName": "Sarah Jenkins",
      "uniTag": "Biology '24",
      "timeAgo": "2h",
      "content": "Does anyone have notes for Bio 101? The lecture on Monday was so fast! 📚",
      "likes": 24,
      "comments": 5,
    },
    {
      "userName": "Chalee Events",
      "uniTag": "Official",
      "timeAgo": "4h",
      "content": "Don't forget! The Spring Festival is this Friday at the Main Quad. Food trucks will be there! 🍔",
      "likes": 156,
      "comments": 42,
      "hasImage": true,
    },
    {
      "userName": "Mike Ross",
      "uniTag": "Law School",
      "timeAgo": "5h",
      "content": "Looking for a study group for Contracts. Who is in?",
      "likes": 8,
      "comments": 12,
    },
    {
      "userName": "Housing Office",
      "uniTag": "Admin",
      "timeAgo": "1d",
      "content": "Dorm applications for next semester are now open. Click the link to apply.",
      "likes": 300,
      "comments": 50,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chalee',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Stories Section
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                children: [
                  _buildStoryCircle("My Story", Icons.add),
                  _buildStoryCircle("John Doe", "JD"),
                  _buildStoryCircle("Emily Blunt", "EB"),
                  _buildStoryCircle("Campus Crush", "CC"),
                  _buildStoryCircle("Lost & Found", "LF"),
                ],
              ),
            ),
          ),
          
          // Create Post Input
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(top: 1),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3'),
                  radius: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text("What's on your mind?", style: TextStyle(color: Colors.grey)),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.photo_library, color: Colors.green),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          const SizedBox(height: 5),

          // The Feed
          Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return _buildPostCard(posts[index]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {},
        child: const Icon(Icons.message, color: Colors.white),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Friends'),
          BottomNavigationBarItem(icon: Icon(Icons.play_circle_fill), label: 'Watch'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Alerts'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
        ],
      ),
      endDrawer: _buildDrawer(),
    );
  }

  Widget _buildStoryCircle(String name, dynamic imageOrIcon) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.blue[100],
                child: imageOrIcon is IconData
                    ? Icon(imageOrIcon, color: Colors.blue, size: 30)
                    : Text(imageOrIcon, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              if (name == "My Story")
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                    child: const Icon(Icons.add, color: Colors.white, size: 14),
                  ),
                )
            ],
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: 60,
            child: Text(name, textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _buildPostCard(Map<String, dynamic> post) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Post Header
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12'),
                  radius: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post["userName"], style: const TextStyle(fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          Text(post["uniTag"], style: const TextStyle(fontSize: 12, color: Colors.grey)),
                          const Text(" • ", style: TextStyle(color: Colors.grey)),
                          Text(post["timeAgo"], style: const TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(icon: const Icon(Icons.more_horiz, color: Colors.grey), onPressed: () {}),
              ],
            ),
            
            // Post Content
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(post["content"]),
            ),

            // Post Image (Placeholder)
            if (post["hasImage"] == true)
              Container(
                height: 200,
                width: double.infinity,
                color: Colors.grey[300],
                child: const Center(child: Icon(Icons.image, size: 50, color: Colors.grey)),
              ),

            // Likes/Comments Count
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  const Icon(Icons.thumb_up, size: 16, color: Colors.blue),
                  const SizedBox(width: 4),
                  Text("${post["likes"]}"),
                  const SizedBox(width: 15),
                  Text("${post["comments"]} Comments"),
                  const Spacer(),
                  const Text("Share", style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),

            const Divider(height: 1),
            
            // Action