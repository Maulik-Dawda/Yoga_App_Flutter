import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yoga_app/Controller/detail_meditation_controller.dart';
import 'package:yoga_app/Themes/app_colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MeditationDetailScreen extends StatefulWidget {
  final String title;
  final String id;

  const MeditationDetailScreen({
    super.key,
    required this.title,
    required this.id,
  });

  @override
  State<MeditationDetailScreen> createState() => _MeditationDetailScreenState();
}

class _MeditationDetailScreenState extends State<MeditationDetailScreen> {
  late final DetailMeditationController detailMeditationController;

  YoutubePlayerController? _youtubeController;

  @override
  void initState() {
    super.initState();

    // Safe controller initialization
    if (Get.isRegistered<DetailMeditationController>(tag: widget.id)) {
      detailMeditationController =
          Get.find<DetailMeditationController>(tag: widget.id);
    } else {
      detailMeditationController =
          Get.put(DetailMeditationController(widget.id), tag: widget.id);
    }

    // Initialize player when detail loads
    detailMeditationController.meditationDetail.listen((detail) {
      if (detail != null && detail.videoLink != null) {
        final videoUrl = "https://www.youtube.com/watch?v=${detail.videoLink}";
        _initPlayer(videoUrl);
      }
    });
  }

  @override
  void dispose() {
    _youtubeController?.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  void _initPlayer(String videoLink) {
    final videoId = YoutubePlayer.convertUrlToId(videoLink) ?? "";
    if (_youtubeController == null) {
      _youtubeController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
      );
    } else {
      _youtubeController!.load(videoId);
      _youtubeController!.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Obx(() {
      if (detailMeditationController.isLoading.value) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }

      final meditationDetail = detailMeditationController.meditationDetail.value;
      if (meditationDetail == null) {
        return const Scaffold(
          body: Center(child: Text("No Data Found")),
        );
      }

      return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _youtubeController!,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.red,
        ),
        onEnterFullScreen: () {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeRight,
            DeviceOrientation.landscapeLeft,
          ]);
        },
        onExitFullScreen: () {
          SystemChrome.setEnabledSystemUIMode(
              SystemUiMode.manual, overlays: SystemUiOverlay.values);
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
        },
        builder: (context, player) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: AppColors.meditationTheme,
              title: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                SizedBox(
                  height: screenHeight * 0.4,
                  width: double.infinity,
                  child: player,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: screenHeight * 0.5,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Up Next",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Expanded(
                            child: meditationDetail.upNext == null ||
                                meditationDetail.upNext!.isEmpty
                                ? const Center(child: Text("No Up Next Meditation"))
                                : ListView.builder(
                              itemCount: meditationDetail.upNext!.length,
                              itemBuilder: (context, index) {
                                var meditation =
                                meditationDetail.upNext![index];
                                return GestureDetector(
                                  onTap: () {
                                    // Navigate to next meditation detail screen
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MeditationDetailScreen(
                                              title: meditation.title ?? "",
                                              id: meditation.id ?? "",
                                            ),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    color: Colors.white,
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(12),
                                          child: Image.network(
                                            meditation.img ?? "",
                                            height: screenHeight * 0.14,
                                            width: screenWidth * 0.3,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(width: screenWidth * 0.05),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                meditation.title ?? "",
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight:
                                                  FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                meditation.category ?? "",
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
