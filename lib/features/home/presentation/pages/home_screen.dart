import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_player/app/theme/app_styles.dart';
import 'package:music_player/app/theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String name = "/home-screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTabIndex = 2; // Tracks is selected by default
  final List<String> _tabs = ["Favorites", "Playlists", "Tracks", "Folders"];
  late final List<GlobalKey> _tabKeys = List.generate(
    _tabs.length,
    (index) => GlobalKey(),
  );
  bool _isTappingTab = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_tabKeys[_selectedTabIndex].currentContext != null) {
        Scrollable.ensureVisible(
          _tabKeys[_selectedTabIndex].currentContext!,
          alignment: 0.5,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _updateSelectedTabOnScroll() {
    if (!mounted) return;

    double screenCenter = MediaQuery.of(context).size.width / 2;
    double minDistance = double.infinity;
    int closestIndex = _selectedTabIndex;

    for (int i = 0; i < _tabs.length; i++) {
      final key = _tabKeys[i];
      if (key.currentContext != null) {
        final RenderBox box =
            key.currentContext!.findRenderObject() as RenderBox;
        final position = box.localToGlobal(Offset.zero);
        final itemCenter = position.dx + (box.size.width / 2);

        final distance = (screenCenter - itemCenter).abs();
        if (distance < minDistance) {
          minDistance = distance;
          closestIndex = i;
        }
      }
    }

    if (closestIndex != _selectedTabIndex) {
      setState(() {
        _selectedTabIndex = closestIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        bottom: false, // let the mini player sit near the bottom
        child: Stack(
          children: [
            Column(
              children: [
                // Header
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Music Player",
                          style: AppStyles.heading(context),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search),
                      ),
                      IconButton(
                        onPressed: () {
                          AppTheme.toggleTheme(
                            isDark ? ThemeMode.light : ThemeMode.dark,
                          );
                        },
                        icon: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 1000),
                          transitionBuilder: (child, animation) =>
                              RotationTransition(
                                turns: animation,
                                child: ScaleTransition(
                                  scale: animation,
                                  child: child,
                                ),
                              ),
                          child: Icon(
                            isDark ? Icons.light_mode : Icons.nightlight_round,
                            key: ValueKey<bool>(isDark),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_vert),
                      ),
                    ],
                  ),
                ),

                // Tabs
                SizedBox(
                  height: 40.h,
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      if (notification is ScrollUpdateNotification &&
                          !_isTappingTab) {
                        _updateSelectedTabOnScroll();
                      }
                      return false;
                    },
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth / 2 - 40.w,
                      ),
                      child: Row(
                        children: List.generate(_tabs.length, (index) {
                          final isSelected = _selectedTabIndex == index;
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _isTappingTab = true;
                                  setState(() => _selectedTabIndex = index);
                                  Scrollable.ensureVisible(
                                    _tabKeys[index].currentContext!,
                                    alignment: 0.5,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  ).then((_) {
                                    if (mounted) _isTappingTab = false;
                                  });
                                },
                                child: Container(
                                  key: _tabKeys[index],
                                  alignment: Alignment.center,
                                  color: Colors.transparent,
                                  child: Text(
                                    _tabs[index],
                                    style: AppStyles.subheading(context)
                                        .copyWith(
                                          color: isSelected
                                              ? Theme.of(context)
                                                    .colorScheme
                                                    .onSurface
                                              : Theme.of(context)
                                                    .colorScheme
                                                    .onSurface
                                                    .withValues(alpha: 0.5),
                                          fontWeight: isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          fontSize: isSelected ? 22.sp : 16.sp,
                                        ),
                                  ),
                                ),
                              ),
                              if (index < _tabs.length - 1)
                                SizedBox(width: 24.w),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 15.h),

                // Tracks Container
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainer,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.r),
                        topRight: Radius.circular(30.r),
                      ),
                    ),
                    child: Column(
                      children: [
                        // Container Header
                        Padding(
                          padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 10.h),
                          child: Row(
                            children: [
                              Icon(
                                Icons.sort,
                                color: Theme.of(context).colorScheme.onSurface
                                    .withValues(alpha: 0.7),
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                "Date added",
                                style: AppStyles.body(context).copyWith(
                                  color: Theme.of(context).colorScheme.onSurface
                                      .withValues(alpha: 0.7),
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.shuffle),
                                color: Theme.of(context).colorScheme.onSurface
                                    .withValues(alpha: 0.7),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.play_arrow),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Tracks List
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.only(
                              left: 20.w,
                              right: 20.w,
                              bottom: 90.h,
                            ), // padding for mini player
                            itemCount: 15,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 16.h),
                                child: Row(
                                  children: [
                                    // Track Icon Placeholder
                                    Container(
                                      width: 50.w,
                                      height: 50.w,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.surfaceContainerHighest,
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.music_note,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(width: 15.w),
                                    // Track Info
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "music _ ${index + 1}",
                                            style: AppStyles.body(context)
                                                .copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16.sp,
                                                ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 4.h),
                                          Text(
                                            "Unknown",
                                            style: AppStyles.caption(context),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // More icon
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.more_vert,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withValues(alpha: 0.5),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Mini Player
            Positioned(
              left: 10.w,
              right: 10.w,
              bottom: 20.h,
              child: Container(
                height: 70.h,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(35.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    // Album art placeholder
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.music_note, color: Colors.white),
                    ),
                    SizedBox(width: 15.w),
                    // Track details
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Kare (From \"Mujhse...",
                            style: AppStyles.body(context).copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "Udit Narayan, Alka Yagnik",
                            style: AppStyles.caption(context).copyWith(
                              color: Theme.of(context).colorScheme.onPrimaryContainer.withValues(alpha: 0.7),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    // Controls
                    Icon(
                      Icons.skip_previous,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                    SizedBox(width: 10.w),
                    Icon(
                      Icons.play_arrow,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                    SizedBox(width: 10.w),
                    Icon(
                      Icons.skip_next,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                    SizedBox(width: 10.w),
                    Icon(
                      Icons.queue_music,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
