class ArObject {
  final String title;
  final String description;
  final String glbPath;
  final String gifPath;

  const ArObject({
    required this.title,
    required this.description,
    required this.glbPath,
    required this.gifPath,
  });
}

const List<ArObject> arObjects = [
  ArObject(
    title: 'Buku',
    description: 'Benda untuk membaca dan menulis',
    glbPath: 'assets/glb/buku.glb',
    gifPath: 'assets/gif/buku.gif',
  ),
  ArObject(
    title: 'Bola',
    description: 'Benda untuk bermain',
    glbPath: 'assets/glb/bola.glb',
    gifPath: 'assets/gif/bola.gif',
  ),
];
