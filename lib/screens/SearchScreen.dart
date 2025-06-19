import 'package:flutter/material.dart';
import 'package:learning_mgt/Utils/learning_colors.dart';
import 'package:provider/provider.dart';
import '../Utils/lms_styles.dart';
import '../provider/SearchProvider.dart';

class SearchScreen extends StatelessWidget {
  final VoidCallback onCloseSearch;

  const SearchScreen({Key? key, required this.onCloseSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchProvider(),
      child: Scaffold(
        // Apply gradient background to the entire scaffold
        body: Container(
          decoration: AppDecorations.gradientBackground,
          child: Column(
            children: [
              _buildAppBar(context),
              Expanded(
                child: _buildBody(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final provider = Provider.of<SearchProvider>(context, listen: false);

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: LearningColors.darkBlue),
        onPressed: onCloseSearch,
      ),
      title: Consumer<SearchProvider>(
        builder: (context, provider, child) {
          return Focus(
            onFocusChange: (hasFocus) {
              // This will trigger a rebuild when focus changes
              provider.setSearchFocus(hasFocus);
            },
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: provider.isSearchFocused
                      ? LearningColors.darkBlue
                      : LearningColors.lightBlue,
                  width: 2.0,
                ),
              ),
              child: TextField(
                controller: provider.searchController,
                focusNode: provider.searchFocusNode,
                decoration: InputDecoration(
                  hintText: 'Search courses, institutes...',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                  suffixIcon: provider.searchController.text.isNotEmpty
                      ? IconButton(
                    icon: Icon(Icons.clear, color: Colors.grey[600]),
                    onPressed: provider.clearSearch,
                  )
                      : null,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onChanged: (value) {
                  provider.notifyListeners();
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (context, provider, child) {
        return Container(
          decoration: AppDecorations.gradientBackground,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (provider.searchController.text.isEmpty) ...[
                  // Recent Searches Section
                  if (provider.recentSearches.isNotEmpty) ...[
                    _buildSectionHeader(
                      context,
                      title: 'Recent Searches',
                      actionText: 'Clear all',
                      onAction: provider.clearRecentSearches,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: provider.recentSearches
                          .map((search) => _buildSearchChip(
                        context,
                        search,
                        isRecent: true,
                      ))
                          .toList(),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Popular Searches Section
                  _buildSectionHeader(context, title: 'Popular Searches'),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: provider.popularSearches
                        .map((search) => _buildSearchChip(context, search))
                        .toList(),
                  ),
                ] else ...[
                  // Search Results Section
                  const Center(
                    child: Text(
                      'Search results will appear here',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(
      BuildContext context, {
        required String title,
        String? actionText,
        VoidCallback? onAction,
      }) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        if (actionText != null)
          TextButton(
            onPressed: onAction,
            child: Text(
              actionText,
              style: TextStyle(
                color: LearningColors.darkBlue,
                fontSize: 14,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSearchChip(BuildContext context, String text, {bool isRecent = false}) {
    final provider = Provider.of<SearchProvider>(context, listen: false);

    return GestureDetector(
      onTap: () {
        provider.searchController.text = text;
        provider.addRecentSearch(text);
        // Trigger search functionality here
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isRecent)
              const Icon(Icons.history, size: 16, color: Colors.grey),
            if (isRecent) const SizedBox(width: 8),
            Text(text),
          ],
        ),
      ),
    );
  }
}