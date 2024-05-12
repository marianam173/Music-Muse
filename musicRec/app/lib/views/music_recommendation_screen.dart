import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:app/constants.dart';
import 'package:app/models/music.dart';
import 'package:app/views/music_recommender.dart';

import 'widgets/music_list_tile.dart';

class MusicRecommendationScreen extends StatefulWidget {
  const MusicRecommendationScreen({super.key});

  @override
  State<MusicRecommendationScreen> createState() =>
      _MusicRecommendationScreenState();
}

class _MusicRecommendationScreenState extends State<MusicRecommendationScreen> {
  List<String> selectedGenres = [];
  final TextEditingController artistController = TextEditingController();
  bool isSearched = false;
  List<Music> musicList = [
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 168, 185, 232),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SafeArea(
              child: SizedBox(
                height: 36,
              ),
            ),
            Text(
              'Find your best music',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Color.fromARGB(255, 42, 73, 210),
                    fontWeight: FontWeight.w600
                  ),
            ),
            const SizedBox(
              height: 22,
            ),
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: const Color(0xFF1a2038),
                  borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  const SizedBox(
                    width: 16,
                  ),
                  Flexible(
                    child: TextField(
                      controller: artistController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Artist Name",
                          hintStyle: TextStyle(
                              color: Colors.white54,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      isSearched = true;
                      if (artistController.text.trim().isNotEmpty) {
                        musicList = await MusicRecommender.search(
                            artistController.text.trim(), selectedGenres);
                      }
                      setState(() {});
                    },
                    color: Colors.white,
                    icon: const Icon(Icons.search),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ChipsChoice<String>.multiple(
              value: selectedGenres,
              choiceCheckmark: true,
              choiceStyle: C2ChipStyle.outlined(
                foregroundStyle: const TextStyle(color: Colors.white54),
                selectedStyle: const C2ChipStyle(
                  borderColor: Colors.white,
                  foregroundColor: Colors.white,
                ),
              ),
              onChanged: (val) => setState(() => selectedGenres = val),
              choiceItems: C2Choice.listFrom<String, String>(
                source: genres,
                value: (i, v) => v,
                label: (i, v) => v,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            if (musicList.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: musicList.length,
                  itemBuilder: (context, index) => MusicListTile(
                    music: musicList[index],
                    index: index,
                  ),
                ),
              )
            else
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isSearched ? Icons.warning_amber : Icons.search,
                        color: Color.fromARGB(255, 42, 73, 210),
                        size: MediaQuery.of(context).size.width * 0.3,
                      ),
                      Text(
                        isSearched
                            ? 'Data not found'
                            : 'Search to get recommendations',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(color: Color.fromARGB(255, 42, 73, 210)),
                      )
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
