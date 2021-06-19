class Destination {
  final String name;
  final String image;
  Destination({
    required this.image,
    required this.name,
  });
}

final destinationsList = [
  Destination(
    image:
        'https://www.un.org/africarenewal/sites/www.un.org.africarenewal/files/styles/ar_main_story_big_picture/public/ssimg_210.jpg',
    name: 'Africa',
  ),
  Destination(
    image:
        'https://img.freepik.com/free-photo/old-tower-with-city_1127-4061.jpg',
    name: 'Asia',
  ),
  Destination(
    image:
        'https://cdn.adventuretravelnews.com/wp-content/uploads/2018/03/south-australia-to-host-the-australian-tourism-exchange-the-_5ab561e259a19-1024x681.jpg',
    name: 'Australia',
  ),
  Destination(
    image:
        'https://www.lelongweekend.com/wp-content/uploads/2019/12/morgan-ohoBiu7_KNc-unsplash-1024x683.jpg',
    name: 'Europe',
  ),
  Destination(
    image:
        'https://image.arrivalguides.com/415x300/Continent/North_America.jpg',
    name: 'North America',
  ),
  Destination(
    image:
        'https://www.riocopter.com.br/wp-content/uploads/2019/10/voo-romantico-no-rio-de-janeiro-1024x683.jpg',
    name: 'South America',
  ),
]..shuffle();
