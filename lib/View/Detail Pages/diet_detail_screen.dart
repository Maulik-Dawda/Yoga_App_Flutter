import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yoga_app/Controller/detail_diet_controller.dart';
import 'package:yoga_app/Themes/app_colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DietDetailScreen extends StatefulWidget {
  final String title;
  final String id;

  const DietDetailScreen({
    super.key,
    required this.title,
    required this.id,
  });

  @override
  State<DietDetailScreen> createState() => _DietDetailScreenState();
}

class _DietDetailScreenState extends State<DietDetailScreen> {
  late final DetailDietController detailDietController;
  YoutubePlayerController? _youtubeController;

  @override
  void initState() {
    super.initState();

    // Safe controller initialization
    if (Get.isRegistered<DetailDietController>(tag: widget.id)) {
      detailDietController = Get.find<DetailDietController>(tag: widget.id);
    } else {
      detailDietController = Get.put(DetailDietController(widget.id), tag: widget.id);
    }

    // Initialize player when diet detail loads
    detailDietController.dietDetail.listen((detail) {
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

    return Obx(() {
      if (detailDietController.isLoading.value) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }

      final dietDetail = detailDietController.dietDetail.value;
      if (dietDetail == null) {
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
          return DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                iconTheme: const IconThemeData(color: Colors.white),
                backgroundColor: AppColors.dietTheme,
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
              body: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.3,
                    width: double.infinity,
                    child: player,
                  ),
                  const TabBar(
                    indicatorColor: AppColors.dietTheme,
                    labelColor: AppColors.dietTheme,
                    unselectedLabelColor: Colors.black,
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    dividerColor: Colors.transparent,
                    tabs: [
                      Tab(text: "Ingredients"),
                      Tab(text: "Instructions"),
                      Tab(text: "Nutritions"),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        dietDetail.ingredients == null || dietDetail.ingredients!.isEmpty
                            ? const Center(child: Text("No Ingredients Found"))
                            : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: dietDetail.ingredients!.length,
                          itemBuilder: (context, index) => Text(
                            "• ${dietDetail.ingredients![index]}",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        dietDetail.instructions == null || dietDetail.instructions!.isEmpty
                            ? const Center(child: Text("No Instructions Found"))
                            : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: dietDetail.instructions!.length,
                          itemBuilder: (context, index) => Text(
                            dietDetail.instructions![index],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        dietDetail.nutritions == null || dietDetail.nutritions!.isEmpty
                            ? const Center(child: Text("No Nutritions Found"))
                            : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: dietDetail.nutritions!.length,
                          itemBuilder: (context, index) => Text(
                            "• ${dietDetail.nutritions![index]}",
                            style: const TextStyle(fontSize: 16),
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
      );
    });
  }
}
