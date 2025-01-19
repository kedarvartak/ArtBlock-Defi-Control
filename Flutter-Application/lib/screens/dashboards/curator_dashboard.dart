import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CuratorDashboard extends StatefulWidget {
  const CuratorDashboard({super.key});

  @override
  _CuratorDashboardState createState() => _CuratorDashboardState();
}

class _CuratorDashboardState extends State<CuratorDashboard> {
  Map<String, dynamic>? curatorData;
  bool isLoading = true;
  final String apiUrl = 'http://192.168.1.4:8080/curators/username/kedar';

  @override
  void initState() {
    super.initState();
    fetchCuratorData();
  }

  Future<void> fetchCuratorData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');
      
      if (response.statusCode == 200) {
        setState(() {
          curatorData = json.decode(response.body);
          isLoading = false;
        });
      } else {
        debugPrint('Failed with status code: ${response.statusCode}');
        debugPrint('Error response: ${response.body}');
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint('Error fetching data: $e');
      // Show error to user
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading data: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Curator Dashboard'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : curatorData == null
              ? const Center(child: Text('Failed to load data'))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back,\n${curatorData!['profile']['displayName']}!',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(height: 32),
                      _buildStatsGrid(context),
                      const SizedBox(height: 24),
                      _buildContractInfo(context),
                      const SizedBox(height: 24),
                      _buildGalleries(context),
                    ],
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle gallery creation
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context) {
    final analytics = curatorData!['analytics'];
    final profile = curatorData!['profile'];
    final contract = curatorData!['contract'];
    
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
          'Galleries',
          '${profile['galleriesCount']}',
          Icons.store,
          Colors.purple,
        ),
        _buildStatCard(
          context,
          'Artists Curated',
          '${analytics['totalArtistsCurated']}',
          Icons.people,
          Colors.blue,
        ),
        _buildStatCard(
          context,
          'Total Visitors',
          '${analytics['totalVisitors']}',
          Icons.visibility,
          Colors.green,
        ),
        _buildStatCard(
          context,
          'Artworks Sold',
          '${analytics['totalArtworksSold']}',
          Icons.sell,
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
    final contract = curatorData!['contract'];
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
              _buildInfoRow('Total Revenue', '${contract['totalRevenue']} ETH'),
              _buildInfoRow('Pending Revenue', '${contract['pendingRevenue']} ETH'),
              _buildInfoRow('Wallet', curatorData!['walletAddress']),
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

  Widget _buildGalleries(BuildContext context) {
    final galleries = curatorData!['contract']['galleries'] as List;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Galleries',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
          ),
          child: galleries.isEmpty
              ? const Center(child: Text('No galleries yet'))
              : ListView.builder(
                  itemCount: galleries.length,
                  itemBuilder: (context, index) {
                    final gallery = galleries[index];
                    return ListTile(
                      title: Text(gallery['name'] ?? 'Unnamed Gallery'),
                      subtitle: Text(gallery['address'] ?? 'No address'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Handle gallery selection
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
} 