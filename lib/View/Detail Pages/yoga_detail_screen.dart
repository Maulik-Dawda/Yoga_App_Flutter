import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yoga_app/Controller/detail_yoga_controller.dart';
import 'package:yoga_app/Themes/app_colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YogaDetailScreen extends StatefulWidget {
  final String title;
  final String id;

  const YogaDetailScreen({
    super.key,
    required this.title,
    required this.id,
  });

  @override
  State<YogaDetailScreen> createState() => _YogaDetailScreenState();
}

class _YogaDetailScreenState extends State<YogaDetailScreen> {
  late final DetailYogaController detailYogaController;
  YoutubePlayerController? _youtubeController;

  @override
  void initState() {
    super.initState();
    if (Get.isRegistered<DetailYogaController>(tag: widget.id)) {
      detailYogaController = Get.find<DetailYogaController>(tag: widget.id);
    } else {
      detailYogaController =
          Get.put(DetailYogaController(widget.id), tag: widget.id);
    }
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
      if (detailYogaController.isLoading.value) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }

      final yogaDetail = detailYogaController.yogaDetail.value;
      if (yogaDetail == null) {
        return const Scaffold(
          body: Center(child: Text("No Data Found")),
        );
      }

      final videoUrl =
          "https://www.youtube.com/watch?v=${yogaDetail.videoLink}";
      _initPlayer(videoUrl);

      return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _youtubeController!,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.red,
        ),
        builder: (context, player) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: AppColors.yogaTheme,
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
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.title,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600)),
                        SizedBox(height: screenHeight * 0.03),
                        const Text("Up Next",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                        SizedBox(height: screenHeight * 0.01),
                        Expanded(
                          child: yogaDetail.upNext == null ||
                              yogaDetail.upNext!.isEmpty
                              ? const Center(child: Text("No Up Next Yoga"))
                              : ListView.builder(
                            itemCount: yogaDetail.upNext!.length,
                            itemBuilder: (context, index) {
                              var yoga = yogaDetail.upNext![index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              YogaDetailScreen(
                                                  title: yoga.title ?? "",
                                                  id: yoga.id ?? "")));
                                },
                                child: Card(
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(12),
                                        child: Image.network(
                                          yoga.img ?? "",
                                          height: screenHeight * 0.14,
                                          width: screenWidth * 0.3,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                          width: screenWidth * 0.05),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(yoga.title ?? "",
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.w600)),
                                            Text(yoga.category ?? "",
                                                style: const TextStyle(
                                                    color: Colors.grey)),
                                            Text(yoga.subCategory ?? "",
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey)),
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
              ],
            ),
          );
        },
      );
    });
  }
}
