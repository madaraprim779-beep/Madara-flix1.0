
import 'package:flutter/material.dart';

void main() {
  runApp(const MadaraFlixApp());
}

const bg = Color(0xFF080B14);
const purple = Color(0xFF7565FF);

class MadaraFlixApp extends StatelessWidget {
  const MadaraFlixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MADARA FLIX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: purple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class Film {
  final String title;
  final String category;
  final String emoji;
  final Color color;
  final String description;

  const Film(
    this.title,
    this.category,
    this.emoji,
    this.color,
    this.description,
  );
}

const films = [
  Film('L’Empire des Ombres', 'Action', '🌑',
      Color(0xFF35255F), 'Une création originale MADARA FLIX.'),
  Film('Mission Horizon', 'Aventure', '🚀',
      Color(0xFF173B57), 'Une aventure au-delà des frontières.'),
  Film('Le Dernier Royaume', 'Drame', '🏰',
      Color(0xFF59332D), 'Un royaume face à son destin.'),
  Film('Pixel Warriors', 'Animation', '🎮',
      Color(0xFF174B42), 'Une aventure animée dans un monde numérique.'),
  Film('Code Fantôme', 'Action', '💻',
      Color(0xFF30354D), 'Un mystère technologique à résoudre.'),
  Film('Planète Bleue', 'Documentaire', '🌍',
      Color(0xFF164B70), 'Découvrez les merveilles de notre planète.'),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = 'Tout';
  String search = '';

  final categories = [
    'Tout', 'Action', 'Aventure', 'Drame',
    'Animation', 'Documentaire'
  ];

  @override
  Widget build(BuildContext context) {
    final visibleFilms = films.where((film) {
      final matchesCategory = selectedCategory == 'Tout' ||
          film.category == selectedCategory;
      final matchesSearch =
          film.title.toLowerCase().contains(search.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [purple, Color(0xFF34247F)],
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(
                        Icons.play_arrow_rounded,
                        size: 34,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'MADARA FLIX',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1,
                            ),
                          ),
                          Text(
                            'TON UNIVERS DE DIVERTISSEMENT',
                            style: TextStyle(
                              fontSize: 9,
                              color: Colors.white60,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.account_circle_outlined, size: 30),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF35266D), Color(0xFF11182C)],
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'BIENVENUE DANS',
                        style: TextStyle(
                          color: Color(0xFFB8AEFF),
                          letterSpacing: 2,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Le cinéma,\\nà ta façon.',
                        style: TextStyle(
                          fontSize: 32,
                          height: 1.1,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Découvre des histoires, des aventures '
                        'et des créations originales.',
                        style: TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 18),
                      FilledButton.icon(
                        onPressed: () {
                          setState(() {
                            selectedCategory = 'Tout';
                            search = '';
                          });
                        },
                        icon: const Icon(Icons.explore_outlined),
                        label: const Text('Explorer le catalogue'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  onChanged: (value) => setState(() => search = value),
                  decoration: InputDecoration(
                    hintText: 'Rechercher un film...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: const Color(0xFF151A29),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 64,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 14,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final active = category == selectedCategory;
                    return ChoiceChip(
                      label: Text(category),
                      selected: active,
                      onSelected: (_) => setState(
                        () => selectedCategory = category,
                      ),
                      selectedColor: purple,
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                child: Text(
                  'À DÉCOUVRIR  ·  ${visibleFilms.length}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
            if (visibleFilms.isEmpty)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(28),
                  child: Center(
                    child: Text('Aucun titre trouvé.'),
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final film = visibleFilms[index];
                      return InkWell(
                        borderRadius: BorderRadius.circular(18),
                        onTap: () => showModalBottomSheet(
                          context: context,
                          backgroundColor: const Color(0xFF151A29),
                          builder: (context) => Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${film.emoji}  ${film.title}',
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(film.description),
                                const SizedBox(height: 10),
                                Text('Catégorie : ${film.category}'),
                                const SizedBox(height: 20),
                                const Text(
                                  'La lecture vidéo sera ajoutée '
                                  'dans une prochaine étape.',
                                  style: TextStyle(color: Colors.white60),
                                ),
                                const SizedBox(height: 12),
                              ],
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: film.color,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Stack(
                                  children: [
                                    Center(
                                      child: Text(
                                        film.emoji,
                                        style: const TextStyle(fontSize: 54),
                                      ),
                                    ),
                                    const Positioned(
                                      right: 10,
                                      bottom: 10,
                                      child: Icon(
                                        Icons.play_circle_fill,
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              film.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              film.category,
                              style: const TextStyle(
                                color: Colors.white60,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    childCount: visibleFilms.length,
                  ),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 18,
                    crossAxisSpacing: 14,
                    childAspectRatio: 0.70,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
