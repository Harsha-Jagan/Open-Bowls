import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AssistanceProgramsPage extends StatelessWidget {
  const AssistanceProgramsPage({Key? key}) : super(key: key);

  // Function to launch URLs
  void _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assistance Programs'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Thrifty Food Plan',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'The Thrifty Food Plan is an example of a healthy diet plan that is both nutritious and cost-effective. It is used as the basis for SNAP allotments.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () =>
                  _launchURL('https://www.fns.usda.gov/snap/thriftyfoodplan'),
              child: const Text('Learn more about the Thrifty Food Plan'),
            ),
            const SizedBox(height: 16),
            const Text(
              'SNAP Program',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'The Supplemental Nutrition Assistance Program (SNAP) provides nutrition benefits to supplement the food budget of needy families so they can purchase healthy food and move towards self-sufficiency.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => _launchURL(
                  'https://www.fns.usda.gov/snap/supplemental-nutrition-assistance-program'),
              child: const Text('Learn more about the SNAP Program'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Enrollment',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'To enroll in the SNAP program, visit the official SNAP website or contact your local SNAP office.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () =>
                  _launchURL('https://www.fns.usda.gov/snap/state-directory'),
              child: const Text('Find your local SNAP office'),
            ),
          ],
        ),
      ),
    );
  }
}
