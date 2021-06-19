class Feature {
  Feature({required this.image, required this.title});
  final String image;
  final String title;
}

final featuresList = [
  Feature(
    title: 'Trekking',
    image:
        'https://blog.penatrilha.com.br/wp-content/uploads/2016/09/Trekking.jpg',
  ),
  Feature(
    title: 'Animals',
    image:
        'https://painel.portalamazonia.com/uploads/RTEmagicC_animal-poder-onca.jpg.jpg',
  ),
  Feature(
    title: 'Call your name',
    image: 'https://i1.sndcdn.com/artworks-000207970023-xdevev-t500x500.jpg',
  ),
  Feature(
    title: 'Photography',
    image:
        'https://t2.ea.ltmcdn.com/pt/images/2/3/3/o_guaxinim_como_animal_de_estimacao_2332_orig.jpg',
  ),
  Feature(
    title: 'Space',
    image:
        'https://c4.wallpaperflare.com/wallpaper/917/114/344/planet-earth-universe-darkness-wallpaper-preview.jpg',
  ),
]..shuffle();
