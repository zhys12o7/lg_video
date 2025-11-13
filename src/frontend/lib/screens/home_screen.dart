import 'package:flutter/material.dart';
import 'package:frontend/services/volume_service.dart';
import 'package:frontend/widgets/custom_video_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 28, 40, 32),
          child: Column(
            children: [
              const _TopStatusBar(),
              const SizedBox(height: 28),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Row(
                            children: const [
                              Expanded(
                                flex: 5,
                                child: _HeroMediaCard(
                                  videoUrl:
                                      'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
                                ),
                              ),
                              SizedBox(width: 32),
                              Expanded(
                                flex: 4,
                                child: _SideColumn(),
                              ),
                            ],
                          ),
                          const Positioned(
                            top: 56,
                            right: -28,
                            child: _VerticalBadge(label: '빈버드'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    const _AppDock(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopStatusBar extends StatelessWidget {
  const _TopStatusBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        _TimeAndWeather(),
        SizedBox(width: 36),
        Expanded(child: _SearchField()),
        SizedBox(width: 36),
        _ProfileSummary(),
      ],
    );
  }
}

class _TimeAndWeather extends StatelessWidget {
  const _TimeAndWeather();

  String _formatTime(DateTime time) {
    final int hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
    final String minute = time.minute.toString().padLeft(2, '0');
    return '${hour.toString().padLeft(2, '0')}:$minute';
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle timeStyle = Theme.of(context).textTheme.displaySmall ??
        const TextStyle(fontSize: 40, fontWeight: FontWeight.w700);

    return SizedBox(
      width: 240,
      child: StreamBuilder<DateTime>(
        stream: Stream<DateTime>.periodic(
          const Duration(seconds: 1),
          (_) => DateTime.now(),
        ),
        builder: (context, snapshot) {
          final DateTime now = snapshot.data ?? DateTime.now();
          final String period = now.hour >= 12 ? 'PM' : 'AM';

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _formatTime(now),
                    style: timeStyle.copyWith(
                      fontSize: 38,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF222328),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      period,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF5D606A),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: const [
                  Icon(Icons.wb_sunny_rounded, color: Color(0xFFF5A623)),
                  SizedBox(width: 6),
                  Text(
                    '17°C',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF3C3F47),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: TextField(
          readOnly: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: '무엇을 도와드릴까요?',
            hintStyle: const TextStyle(color: Color(0xFF9AA0AF)),
            prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF9AA0AF)),
            suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.mic_none_rounded, color: Color(0xFF9AA0AF)),
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          ),
        ),
      ),
    );
  }
}

class _ProfileSummary extends StatelessWidget {
  const _ProfileSummary();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 196,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 22,
            backgroundColor: Color(0xFFD8DAE5),
            child: Icon(Icons.person_outline_rounded, color: Color(0xFF626678)),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                '홍길동',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Color(0xFF232533),
                ),
              ),
              SizedBox(height: 4),
              Text(
                '다른 계정으로 전환하기',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF7B7F8E),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroMediaCard extends StatelessWidget {
  const _HeroMediaCard({required this.videoUrl});

  final String videoUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 32,
            offset: const Offset(0, 24),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: CustomVideoWidget(
                videoUrl: videoUrl,
                autoplay: true,
                looping: true,
                volume: 0.0,
              ),
            ),
          ),
          const SizedBox(width: 28),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'THE GENTLEMEN',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1E1F25),
                  ),
                ),
                SizedBox(height: 14),
                Text(
                  'An American expat tries to sell off his highly profitable marijuana '
                  'empire in London, triggering plots, schemes, bribery and blackmail in '
                  'an attempt to steal his domain out from under him.',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.6,
                    color: Color(0xFF4D515E),
                  ),
                ),
                SizedBox(height: 28),
                _WatchNowButton(),
                SizedBox(height: 32),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _TagChip(label: '액션'),
                    _TagChip(label: '코미디'),
                    _TagChip(label: '영국'),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  '자동 재생 중인 예고편의 볼륨은 우측 컨트롤러에서 조절할 수 있어요.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF818796),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WatchNowButton extends StatelessWidget {
  const _WatchNowButton();

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {},
      style: FilledButton.styleFrom(
        backgroundColor: const Color(0xFFE53935),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: const Text(
        '지금 보러가기',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _SideColumn extends StatelessWidget {
  const _SideColumn();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Expanded(child: _MemoBoard()),
        SizedBox(height: 24),
        _VolumeQuickPanel(),
      ],
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F3F8),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF5F6372),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _MemoBoard extends StatelessWidget {
  const _MemoBoard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 28,
            offset: const Offset(0, 22),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Row(
            children: [
              Text(
                '메모하기',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E1F25),
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.edit_note_rounded, color: Color(0xFF9AA0AF)),
            ],
          ),
          SizedBox(height: 24),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: _MemoSticky(
                    title: '할일 정리',
                    content: '이벤트 준비\n장보기',
                    color: Color(0xFF6DE4A5),
                  ),
                ),
                SizedBox(width: 18),
                Expanded(
                  child: _MemoSticky(
                    title: '아이디어',
                    content: '홈 디자인 스케치',
                    color: Color(0xFFFFE28B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MemoSticky extends StatelessWidget {
  const _MemoSticky({
    required this.title,
    required this.content,
    required this.color,
  });

  final String title;
  final String content;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 18,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Color(0xFF272B33),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Text(
              content,
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Color(0xFF3B3F46),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VolumeQuickPanel extends StatefulWidget {
  const _VolumeQuickPanel();

  @override
  State<_VolumeQuickPanel> createState() => _VolumeQuickPanelState();
}

class _VolumeQuickPanelState extends State<_VolumeQuickPanel> {
  int _volume = 15;
  bool _muted = false;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: const Color(0xFF1E2533),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 24,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.volume_up_rounded, color: Colors.white),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _muted ? '음소거됨' : '볼륨 $_volume',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 6),
                LinearProgressIndicator(
                  value: _muted ? 0 : _volume / 100,
                  backgroundColor: Colors.white.withValues(alpha: 0.15),
                  color: Colors.white,
                  minHeight: 4,
                ),
              ],
            ),
          ),
          const SizedBox(width: 18),
          Row(
            children: [
              _roundIconButton(
                icon: Icons.remove_rounded,
                onTap: _loading ? null : () => _changeVolume(false),
              ),
              const SizedBox(width: 10),
              _roundIconButton(
                icon: Icons.add_rounded,
                onTap: _loading ? null : () => _changeVolume(true),
              ),
              const SizedBox(width: 14),
              _roundIconButton(
                icon: _muted ? Icons.volume_off_rounded : Icons.volume_mute_rounded,
                onTap: _loading ? null : _toggleMute,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _roundIconButton({required IconData icon, VoidCallback? onTap}) {
    return Material(
      color: Colors.white.withValues(alpha: onTap == null ? 0.08 : 0.18),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 42,
          height: 42,
          child: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }

  Future<void> _changeVolume(bool increase) async {
    setState(() => _loading = true);
    final bool success = increase
        ? await volumeService.volumeUp()
        : await volumeService.volumeDown();
    if (!mounted) {
      return;
    }
    if (success) {
      setState(() {
        _muted = false;
        _volume = (increase ? _volume + 1 : _volume - 1).clamp(0, 100).toInt();
      });
    } else {
      _showMessage('볼륨을 변경하지 못했어요.');
    }
    setState(() => _loading = false);
  }

  Future<void> _toggleMute() async {
    setState(() => _loading = true);
    final bool success = await volumeService.setMuted(!_muted);
    if (!mounted) {
      return;
    }
    if (success) {
      setState(() => _muted = !_muted);
    } else {
      _showMessage('음소거 상태를 변경하지 못했어요.');
    }
    setState(() => _loading = false);
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

class _VerticalBadge extends StatelessWidget {
  const _VerticalBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 68,
      padding: const EdgeInsets.symmetric(vertical: 28),
      decoration: BoxDecoration(
        color: const Color(0xFF4C1E1E),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 30,
            offset: const Offset(12, 18),
          ),
        ],
      ),
      child: RotatedBox(
        quarterTurns: 3,
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              letterSpacing: 2,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

class _AppDock extends StatelessWidget {
  const _AppDock();

  static final List<_DockItem> _items = [
    _DockItem(icon: Icons.movie_outlined, label: 'Disney+', color: const Color(0xFF0E7FE1)),
    _DockItem(icon: Icons.movie_outlined, label: 'Disney+', color: const Color(0xFF0E7FE1)),
    _DockItem(icon: Icons.ondemand_video_rounded, label: 'Netflix', color: Colors.red),
    _DockItem(icon: Icons.movie_outlined, label: 'Disney+', color: const Color(0xFF0E7FE1)),
    _DockItem(icon: Icons.video_library_rounded, label: 'YouTube', color: Colors.redAccent),
    _DockItem(icon: Icons.play_circle_fill_rounded, label: 'Play', color: const Color(0xFF6F9CFF)),
    _DockItem(icon: Icons.web_rounded, label: 'Wavve', color: const Color(0xFFBF3EFF)),
    _DockItem(icon: Icons.grid_view_rounded, label: 'Apps', color: const Color(0xFF4A90E2)),
    _DockItem(icon: Icons.photo_rounded, label: 'Gallery', color: const Color(0xFFFF6F91)),
    _DockItem(icon: Icons.photo_rounded, label: 'Gallery', color: const Color(0xFFFF6F91)),
    _DockItem(icon: Icons.add_rounded, label: '추가', color: const Color(0xFFE0E3EC)),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 28,
            offset: const Offset(0, 24),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (final _DockItem item in _items) _DockIcon(item: item),
          const _FriendBubble(),
        ],
      ),
    );
  }
}

class _DockItem {
  const _DockItem({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;
}

class _DockIcon extends StatelessWidget {
  const _DockIcon({required this.item});

  final _DockItem item;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 68,
          height: 68,
          decoration: BoxDecoration(
            color: item.color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(item.icon, size: 32, color: item.color),
        ),
        const SizedBox(height: 8),
        Text(
          item.label,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF6E7281),
          ),
        ),
      ],
    );
  }
}

class _FriendBubble extends StatelessWidget {
  const _FriendBubble();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _avatarCircle(label: 'Z', color: const Color(0xFF3E92FF)),
        Positioned(
          left: -28,
          child: _avatarCircle(label: '정', color: const Color(0xFF1E66FF)),
        ),
      ],
    );
  }

  Widget _avatarCircle({required String label, required Color color}) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.35),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
    );
  }
}

