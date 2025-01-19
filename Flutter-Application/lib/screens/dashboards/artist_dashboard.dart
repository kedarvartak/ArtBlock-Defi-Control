import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ArtistDashboard extends StatefulWidget {
  const ArtistDashboard({super.key});

  @override
  _ArtistDashboardState createState() => _ArtistDashboardState();
}

class _ArtistDashboardState extends State<ArtistDashboard> {
  Map<String, dynamic>? artistData;
  bool isLoading = true;
  final String apiUrl = 'http://192.168.1.4:8080/users/username/kedar2sexy';


  @override
  void initState() {
    super.initState();
    fetchArtistData();
  }

  Future<void> fetchArtistData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        setState(() {
          artistData = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Artist Dashboard'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : artistData == null
              ? const Center(child: Text('Failed to load data'))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back,\n${artistData!['username']}!',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(height: 32),
                      _buildStatsGrid(context),
                      const SizedBox(height: 24),
                      _buildContractInfo(context),
                      const SizedBox(height: 24),
                      _buildRecentSales(context),
                      const SizedBox(height: 24),
                      _buildMyArtworks(context),
                    ],
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle artwork creation
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context) {
    final analytics = artistData!['analytics'];
    final contract = artistData!['contract'];
    final profile = artistData!['profile'];
    final distribution = artistData!['distributionSettings'];
    
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.5,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildStatCard(
          context,
          'Total Sales',
          '${analytics['totalSalesValue']} ETH',
          Icons.sell,
          Colors.green,
        ),
        _buildStatCard(
          context,
          'Total Views',
          '${analytics['totalViews']}',
          Icons.visibility,
          Colors.blue,
        ),
        _buildStatCard(
          context,
          'Likes',
          '${analytics['totalLikes']}',
          Icons.favorite,
          Colors.red,
        ),
        _buildStatCard(
          context,
          'Artist Share',
          '${distribution['artistShare']}%',
          Icons.account_balance_wallet,
          Colors.orange,
        ),
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value,
      IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const Spacer(),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildContractInfo(BuildContext context) {
    final contract = artistData!['contract'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contract Details',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoRow('Network', contract['network']),
              _buildInfoRow('Status', contract['deploymentStatus']),
              _buildInfoRow('Address', contract['address']),
              if (contract['blockExplorerUrl'] != null)
                TextButton(
                  onPressed: () {
                    // Add URL launcher functionality here
                  },
                  child: const Text('View on Block Explorer'),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Flexible(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentSales(BuildContext context) {
    // Assuming no recent sales data in the API response
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Sales',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Center(
            child: Text('No recent sales'),
          ),
        ),
      ],
    );
  }

  Widget _buildMyArtworks(BuildContext context) {
    // Assuming no artworks data in the API response
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Artworks',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Center(
            child: Text('No artworks yet'),
          ),
        ),
      ],
    );
  }
}
