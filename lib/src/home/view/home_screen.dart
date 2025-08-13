import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/picsum_repository.dart';
import '../model/picsum_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<PicsumImage>> _futureImages;

  @override
  void initState() {
    super.initState();
    final PicsumRepository repository = context.read<PicsumRepository>();
    _futureImages = repository.fetchImages(limit: 10);
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = const EdgeInsets.symmetric(vertical: 12, horizontal: 12);
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: FutureBuilder<List<PicsumImage>>(
        future: _futureImages,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final List<PicsumImage> images = snapshot.data ?? <PicsumImage>[];
          return ListView.separated(
            padding: padding,
            itemCount: images.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final PicsumImage image = images[index];
              final double screenWidth = MediaQuery.of(context).size.width - padding.horizontal;
              final double height = image.height == 0
                  ? screenWidth * 0.75
                  : screenWidth * (image.height / image.width);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: image.downloadUrl,
                      width: double.infinity,
                      height: height,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey.shade200,
                        child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey.shade300,
                        height: height,
                        child: const Icon(Icons.broken_image),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    image.author,
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black87),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Photo ID: ${image.id}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.grey.shade700),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

