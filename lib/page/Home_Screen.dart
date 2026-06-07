import 'package:anubhuti/core/Provider/Ambience_provider.dart';
import 'package:anubhuti/data/Repository/Ambidence_repo.dart';
import 'package:anubhuti/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Ambience> ambience = [];
  late int Selected_index;
  List<String> data_list = [];
  Map<String, String> tagColorMap = {};
  int s_index = 0;
  List<String> data_list_card = [];
  late double size_item = 100;
  late double size_item_card = 90;
  late TextEditingController Search_Control;
  late double Size_height = 400;
  List<String> data_amb_list = [];
  String searchQuery = '';
  String selectedTag = '';
  List<Ambience> filteredAmbience = [];
  late FixedExtentScrollController wheelController;

  @override
  void initState() {
    super.initState();
    Search_Control = TextEditingController();
    wheelController = FixedExtentScrollController(initialItem: 0);
    _loadAmbience();
  }

  Future<void> _loadAmbience() async {
    ambience = await AmbienceRepo.loadAll();
    final uniqueTags = <String>{};
    final tagColors = <String, String>{};
    for (final item in ambience) {
      if (uniqueTags.add(item.tag)) {
        tagColors[item.tag] = item.color;
      }
    }
    data_list = uniqueTags.toList();
    tagColorMap = tagColors;
    data_amb_list = ambience.map((a) => a.title).toList();
    filteredAmbience = List<Ambience>.from(ambience);
    if (filteredAmbience.isNotEmpty) {
      if (s_index >= filteredAmbience.length) s_index = 0;
      data_list_card = filteredAmbience[s_index].suggestedMoods.toList();
      // FIX: Set provider id on initial load
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<AmbienceProvider>().setId(filteredAmbience[s_index].id);
      });
    }
    setState(() {});
  }

  void _applyFilter() {
    final query = searchQuery.toLowerCase();
    final tag = selectedTag.toLowerCase();

    filteredAmbience = ambience.where((a) {
      final matchesQuery =
          query.isEmpty ||
          a.title.toLowerCase().contains(query) ||
          a.tag.toLowerCase().contains(query);

      final matchesTag = selectedTag.isEmpty || a.tag.toLowerCase() == tag;

      return matchesQuery && matchesTag;
    }).toList();

    if (filteredAmbience.isNotEmpty) {
      s_index = 0;
      data_list_card = filteredAmbience[0].suggestedMoods.toList();
      // FIX: Set provider id explicitly since onSelectedItemChanged won't fire at index 0
      context.read<AmbienceProvider>().setId(filteredAmbience[0].id);
      // FIX: Jump after the new widget tree is built (new key rebuilds the wheel)
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (wheelController.hasClients) {
          wheelController.jumpToItem(0);
        }
      });
    } else {
      data_list_card = [];
    }
  }

  @override
  void dispose() {
    Search_Control.dispose();
    wheelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          scrollDirection: Axis.vertical,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.search,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: TextField(
                          controller: Search_Control,
                          onChanged: (value) {
                            setState(() {
                              searchQuery = value;
                              _applyFilter();
                            });
                          },
                          decoration: InputDecoration(
                            label: Text(
                              "Search",
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.color,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  height: 32,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      final tag = data_list[index];
                      final ambienceColor = Color(
                        int.parse(tagColorMap[tag] ?? '0xFF0D5C3A'),
                      );
                      final isSelected = selectedTag == tag;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTag = isSelected ? '' : tag;
                            _applyFilter();
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? ambienceColor.withValues(alpha: 0.25)
                                : Colors.transparent,
                            border: Border.all(
                              color: isSelected
                                  ? ambienceColor
                                  : Theme.of(context).colorScheme.primary,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              tag,
                              style: TextStyle(
                                color: isSelected
                                    ? (Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black)
                                    : Theme.of(
                                        context,
                                      ).textTheme.bodyMedium?.color,
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: data_list.length,
                    itemExtent: size_item,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),

            const SizedBox(height: 32),
            Consumer<AmbienceProvider>(
              builder: (_, provider, _) {
                return SizedBox(
                  height: Size_height,
                  width: double.infinity,
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: ListWheelScrollView(
                      controller: wheelController,
                      key: ValueKey(
                        '$selectedTag|$searchQuery|${filteredAmbience.length}',
                      ),
                      itemExtent: Size_height * 0.8,
                      physics: const FixedExtentScrollPhysics(),
                      diameterRatio: 2.0,
                      offAxisFraction: 0.0,
                      perspective: 0.003,
                      clipBehavior: Clip.none,
                      onSelectedItemChanged: (index) {
                        setState(() {
                          s_index = index;
                          if (filteredAmbience.isNotEmpty &&
                              index < filteredAmbience.length) {
                            provider.setId(filteredAmbience[index].id);
                            data_list_card = filteredAmbience[index]
                                .suggestedMoods
                                .toList();
                          } else {
                            data_list_card = [];
                          }
                        });
                      },
                      children: filteredAmbience
                          .map(
                            (value) => RotatedBox(
                              quarterTurns: -1,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    "/Player_Screen",
                                    
                                  );
                                },
                                child: Hero(
                                  tag: "Ambience_Card",
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(32),
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          value.title,
                                          style: TextStyle(
                                            color: Theme.of(
                                              context,
                                            ).textTheme.bodyMedium?.color,
                                            fontSize: 32,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                        const SizedBox(height: 300),
                                        // FIX: Use value.suggestedMoods directly instead of shared data_list_card
                                        List_Data(
                                          value.suggestedMoods.toList(),
                                          size_item_card,
                                          Theme.of(context).colorScheme.secondary,
                                        ),
                                        const SizedBox(height: 4),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
