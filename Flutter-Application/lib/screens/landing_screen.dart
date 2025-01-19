import 'package:flutter/material.dart';
import '../widgets/featured_art_card.dart';
import '../widgets/stats_row.dart';
import 'login/investor_login.dart';
import 'login/curator_login.dart';
import 'login/artist_login.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Art', 
                        style: Theme.of(context).textTheme.headlineSmall),
                    Text('Block',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: Theme.of(context).primaryColor)),
                  ],
                ),
                const SizedBox(height: 24),

                Text(
                  'The Future of\nDigital Art\nis Here',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 16),
                Text(
                  'Experience the next evolution of digital art creation',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 24),
                const StatsRow(),
                const SizedBox(height: 32),

                Text(
                  'Featured Artworks',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.deepPurple.withOpacity(0.2),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.upcoming_outlined,
                        size: 48,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Featured Artworks Coming Soon',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Stay tuned for amazing digital art collections',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Join the Revolution',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildLoginButton(
                            context,
                            'Investor',
                            Icons.account_balance_wallet_outlined,
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const InvestorLoginScreen(),
                              ),
                            ),
                          ),
                          _buildLoginButton(
                            context,
                            'Curator',
                            Icons.collections_outlined,
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CuratorLoginScreen(),
                              ),
                            ),
                          ),
                          _buildLoginButton(
                            context,
                            'Artist',
                            Icons.palette_outlined,
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ArtistLoginScreen(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                Text(
                  'Why Choose ArtBlock?',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.1,
                  children: [
                    _buildFeatureCard(
                      context,
                      'Secure Trading',
                      'Trade with confidence',
                      Icons.security_outlined,
                      Colors.green,
                    ),
                    _buildFeatureCard(
                      context,
                      'Curated Content',
                      'Hand-picked masterpieces',
                      Icons.verified_outlined,
                      Colors.blue,
                    ),
                    _buildFeatureCard(
                      context,
                      'Artist Royalties',
                      'Fair compensation',
                      Icons.copyright_outlined,
                      Colors.orange,
                    ),
                    _buildFeatureCard(
                      context,
                      'Community',
                      'Join art enthusiasts',
                      Icons.people_outline,
                      Colors.purple,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(
      BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 28, color: Theme.of(context).primaryColor),
          const SizedBox(height: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white70,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, String title, String description,
      IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28, color: color),
          const SizedBox(height: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
} 