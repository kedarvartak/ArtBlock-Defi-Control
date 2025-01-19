import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InvestorDashboard extends StatefulWidget {
  const InvestorDashboard({super.key});

  @override
  _InvestorDashboardState createState() => _InvestorDashboardState();
}

class _InvestorDashboardState extends State<InvestorDashboard> {
  Map<String, dynamic>? investorData;
  bool isLoading = true;
  final String apiUrl = 'http://192.168.1.4:8080/investors/username/testinvestor';

  @override
  void initState() {
    super.initState();
    fetchInvestorData();
  }

  Future<void> fetchInvestorData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');
      
      if (response.statusCode == 200) {
        setState(() {
          investorData = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
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
        title: const Text('Investor Dashboard'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : investorData == null
              ? const Center(child: Text('Failed to load data'))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome, ${investorData!['username']}!',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: investorData!['profile']['badges']
                                .map<Widget>(
                                  (badge) => Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: Text(
                                      badge,
                                      style: const TextStyle(fontSize: 24),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      _buildStatsGrid(context),
                      const SizedBox(height: 24),
                      _buildWalletInfo(context),
                      const SizedBox(height: 24),
                      _buildWatchlist(context),
                    ],
                  ),
                ),
    );
  }

  Widget _buildStatsGrid(BuildContext context) {
    final analytics = investorData!['analytics'];
    final profile = investorData!['profile'];
    
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
          'Total Invested',
          '${analytics['totalInvested']} ETH',
          Icons.account_balance,
          Colors.blue,
        ),
        _buildStatCard(
          context,
          'Portfolio Value',
          '${analytics['portfolioValue']} ETH',
          Icons.wallet,
          Colors.green,
        ),
        _buildStatCard(
          context,
          'Total ROI',
          '${analytics['totalROI']}%',
          Icons.trending_up,
          Colors.purple,
        ),
        _buildStatCard(
          context,
          'Investments',
          '${profile['investmentsCount']}',
          Icons.diamond,
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

  Widget _buildWalletInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Wallet Details',
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
              _buildInfoRow('Address', investorData!['walletAddress']),
              _buildInfoRow('Role', investorData!['role'].toString().toUpperCase()),
              _buildInfoRow('Followers', '${investorData!['profile']['followersCount']}'),
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

  Widget _buildWatchlist(BuildContext context) {
    final watchlist = investorData!['portfolio']['watchlist'] as List;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Watchlist',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
          ),
          child: watchlist.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.visibility_outlined,
                        size: 48,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(height: 16),
                      const Text('No items in watchlist'),
                      const SizedBox(height: 8),
                      const Text(
                        'Add galleries or artworks to track them',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: watchlist.length,
                  itemBuilder: (context, index) {
                    final item = watchlist[index];
                    return ListTile(
                      title: Text(item['name'] ?? 'Unnamed Item'),
                      subtitle: Text(item['type'] ?? 'Unknown Type'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Handle watchlist item selection
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
} 