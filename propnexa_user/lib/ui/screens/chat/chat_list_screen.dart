import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  int _activeFilter = 0; // 0: All, 1: Unread, 2: Property, 3: Support
  
  final List<Map<String, dynamic>> _chats = [
    {
      'name': 'PropNexa Support',
      'message': 'Your property is under review. We...',
      'time': '10:30 AM',
      'unread': 1,
      'isOnline': true,
      'isSystem': true,
      'icon': Icons.real_estate_agent,
    },
    {
      'name': 'Rahul Sharma',
      'message': 'Is this property still available?',
      'time': '09:20 AM',
      'unread': 1,
      'isOnline': true,
      'avatar': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200',
    },
    {
      'name': 'Neha Verma',
      'message': 'Thank you for the information!',
      'time': 'Yesterday',
      'unread': 0,
      'isOnline': true,
      'avatar': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200',
    },
    {
      'name': 'Amit Kumar',
      'message': 'Can we schedule a visit this week?',
      'time': 'Yesterday',
      'unread': 0,
      'isOnline': true,
      'avatar': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200',
    },
    {
      'name': 'Property Inquiry',
      'message': 'You: Sent 3 photos',
      'time': '14 Sep',
      'unread': 0,
      'isOnline': false,
      'isSystem': true,
      'iconImage': 'assets/images/home_header_bg.jpg', // Using an existing property image
    },
    {
      'name': 'Visit Request',
      'message': 'Your visit request has been confirmed.',
      'time': '13 Sep',
      'unread': 0,
      'isOnline': false,
      'isSystem': true,
      'icon': Icons.calendar_today,
    },
    {
      'name': 'System Notifications',
      'message': 'Your property has been approved! 🎉',
      'time': '12 Sep',
      'unread': 0,
      'isOnline': false,
      'isSystem': true,
      'icon': Icons.notifications_none,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar
            _buildTopBar(),
            
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: Row(
                children: const [
                  Text(
                    'Messages',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primaryDark,
                    ),
                  ),
                ],
              ),
            ),
            
            // Filters
            _buildFilters(),
            const SizedBox(height: 16),
            
            // Chat List
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                itemCount: _chats.length,
                separatorBuilder: (context, index) => const SizedBox(height: 24),
                itemBuilder: (context, index) {
                  return _buildChatTile(_chats[index]);
                },
              ),
            ),
            const SizedBox(height: 80), // Padding for bottom nav
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.real_estate_agent, color: AppColors.primaryBlue, size: 28),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'PropNexa',
                    style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Find. List. Connect.',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 8),
                  )
                ],
              ),
            ],
          ),
          Row(
            children: const [
              Icon(Icons.search, color: AppColors.textPrimary, size: 24),
              SizedBox(width: 16),
              Icon(Icons.more_vert, color: AppColors.textPrimary, size: 24),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          _buildFilterPill('All', 0),
          const SizedBox(width: 8),
          _buildFilterPill('Unread', 1, badge: 3),
          const SizedBox(width: 8),
          _buildFilterPill('Property', 2),
          const SizedBox(width: 8),
          _buildFilterPill('Support', 3),
        ],
      ),
    );
  }

  Widget _buildFilterPill(String label, int index, {int? badge}) {
    final isActive = _activeFilter == index;
    return GestureDetector(
      onTap: () => setState(() => _activeFilter = index),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: isActive ? AppColors.primaryBlue : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : AppColors.textPrimary,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
          if (badge != null)
            Positioned(
              right: -4,
              top: -4,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  badge.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            )
        ],
      ),
    );
  }

  Widget _buildChatTile(Map<String, dynamic> chat) {
    final isSystem = chat['isSystem'] == true;
    final isOnline = chat['isOnline'] == true;
    final unreadCount = chat['unread'] as int;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Avatar Area
        Stack(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSystem ? Colors.blue.shade50 : Colors.grey.shade200,
                image: chat['avatar'] != null
                    ? DecorationImage(image: NetworkImage(chat['avatar']), fit: BoxFit.cover)
                    : (chat['iconImage'] != null
                        ? DecorationImage(image: AssetImage(chat['iconImage']), fit: BoxFit.cover)
                        : null),
              ),
              child: (chat['avatar'] == null && chat['iconImage'] == null)
                  ? Icon(chat['icon'], color: AppColors.primaryBlue, size: 28)
                  : null,
            ),
            if (isOnline)
              Positioned(
                right: 2,
                bottom: 2,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              )
          ],
        ),
        const SizedBox(width: 16),
        
        // Text Area
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                chat['name'],
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                chat['message'],
                style: TextStyle(
                  fontSize: 13,
                  color: unreadCount > 0 ? AppColors.textPrimary : AppColors.textSecondary,
                  fontWeight: unreadCount > 0 ? FontWeight.w600 : FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        
        // Time & Badge Area
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              chat['time'],
              style: TextStyle(
                fontSize: 11,
                color: unreadCount > 0 ? AppColors.primaryBlue : AppColors.textSecondary,
                fontWeight: unreadCount > 0 ? FontWeight.bold : FontWeight.w500,
              ),
            ),
            const SizedBox(height: 6),
            if (unreadCount > 0)
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  unreadCount.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              )
            else
              const SizedBox(height: 22),
          ],
        )
      ],
    );
  }
}
