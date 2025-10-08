import 'package:flutter/material.dart';

import 'src/easy_bubble_container.dart';

class ChatDemo extends StatelessWidget {
  const ChatDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Container Bubble',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Inter',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Three Containers')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                BubbleContainer(
                  side: BubbleSide.right,
                  arrowPosition: 0,
                  arrowSize: 5,
                  borderRadius: 10,
                  borderColor: Colors.black,
                  borderWidth: 1,
                  color: Colors.blue,
                  child: Text("Hello Bubble 1", style: TextStyle(fontSize: 14)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                BubbleContainer(
                  side: BubbleSide.left,
                  arrowPosition: 1,
                  arrowSize: 5,
                  borderRadius: 10,
                  borderColor: Colors.black,
                  borderWidth: 0,
                  color: Colors.blue,
                  child: Text("Hello Bubble 2", style: TextStyle(fontSize: 14)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            BubbleContainer(
              side: BubbleSide.top,
              arrowPosition: 0.95,
              arrowSize: 15,
              borderRadius: 16,
              borderColor: Colors.black,
              borderWidth: 0,
              color: Color(0xFF112E5A),
              padding: const EdgeInsets.all(12),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reason:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Andrew engaged consistently with the chatbot throughout the week, showed interest in learning about managing gout and related health conditions, and explored strategies for dietary changes. However, he expressed feelings of depression and doubts about his ability to achieve goals, and didn’t strongly commit to specific actions like exercise or reducing alcohol and smoking.",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Feedback:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Andrew, it’s great that you’re taking steps to learn about your health. Remember, change is a journey and it’s okay to move at your own pace. Focusing on small goals can make things more manageable. Staying engaged with supportive resources and reaching out to others for emotional support can also help. Keep moving forward, and know that every small step counts. You’re not alone in this.",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
