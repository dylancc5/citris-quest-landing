import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';
import '../../core/breakpoints.dart';
import '../faq/faq_item.dart';

/// FAQ section with accordion-style questions and answers
class FaqSection extends StatefulWidget {
  const FaqSection({super.key});

  @override
  State<FaqSection> createState() => _FaqSectionState();
}

class _FaqSectionState extends State<FaqSection> {
  int? _expandedIndex;

  final List<Map<String, String>> _faqs = const [
    {
      'question': 'Is this app free?',
      'answer':
          'Yes! CITRIS Quest is completely free to play with no in-app purchases or hidden costs.',
    },
    {
      'question': 'What happens when I scan an artwork?',
      'answer':
          'Your camera captures the artwork, our ML model classifies it, GPS verifies your location, and you instantly earn XP and coins! You\'ll see your rewards and the artwork unlocked in your gallery.',
    },
    {
      'question': 'How do I compete with friends?',
      'answer':
          'Add friends in the app, compare your scan galleries, compete on the global rankings, and see who can collect the most XP! Check the rankings page to see where you stand.',
    },
    {
      'question': 'How long will it be around?',
      'answer':
          'CITRIS Quest will be available for at least 1 year. We\'re working to extend it longer, celebrating CITRIS\' 25th anniversary and beyond!',
    },
    {
      'question': 'Where do I need to be to play?',
      'answer':
          'Artworks are located on any CITRIS campus: UC Berkeley, UC Davis, UC Merced, and UC Santa Cruz. Visit campus to discover and scan!',
    },
    {
      'question': 'When is Android coming out?',
      'answer':
          'Coming shortly! We\'re actively working on the Android version. Join our email list or check back soon for updates.',
    },
    {
      'question': 'Is my location data private?',
      'answer':
          'Yes. We only use your location to verify scans and show your city on your profile. We never share your location data with third parties. See our Privacy Policy for details.',
    },
    {
      'question': 'How do I get TestFlight access?',
      'answer':
          'Click the \'Open TestFlight Invite\' button in the Download section, or scan the QR code with your iPhone. Install TestFlight from the App Store if you don\'t have it, then accept the invite. Need help? Contact us via the Contribute form.',
    },
    {
      'question': 'What if I find a bug?',
      'answer':
          'We\'d love your feedback! Use the Contribute form at the bottom of this page and select \'Bug Reports\' from the dropdown. Include as much detail as possible so we can fix it quickly.',
    },
  ];

  void _toggleItem(int index) {
    setState(() {
      // If clicking the same item, collapse it; otherwise expand new item
      _expandedIndex = _expandedIndex == index ? null : index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: Breakpoints.horizontalPadding(context),
      ),
      child: Column(
        children: [
          // Section title
          Text(
            'FREQUENTLY ASKED QUESTIONS',
            style: GoogleFonts.tiny5(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: AppTheme.cyanAccent,
              letterSpacing: 2,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),

          // FAQ items
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Column(
              children: _faqs.asMap().entries.map((entry) {
                final index = entry.key;
                final faq = entry.value;

                return FaqItem(
                  question: faq['question']!,
                  answer: faq['answer']!,
                  isExpanded: _expandedIndex == index,
                  onTap: () => _toggleItem(index),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
