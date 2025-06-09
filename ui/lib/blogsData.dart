import 'package:wijha/models/Blogs/BlogPost.dart';
import 'package:wijha/models/Users/Guide.dart';

import 'data.dart';

List<BlogPost> blogData = [
  BlogPost(
      creator: Guide(userName: "Khalifa Alhomely"),
      date: t.subtract(Duration(days: 2)),
      title: "Al-Ahsa: Among UNESCO creative cities",
      likes: 4000,
      // tags: ["hasa", "heritage"],
      tags: [],
      imageUrl:
          "https://pbs.twimg.com/media/FAKCZ2QXoAUvvZY?format=jpg&name=large",
      body: "Saudi Arabia’s Al-Ahsa has been named as one of the most creative cities in the world for the economic development of its arts and crafts by the world’s heritage body UNESCO.\n\n" +
          "The city, of 1.3 million people in the southeast of the Kingdom, has been included in the UNESCO Creative Cities Network.\n\n" +
          "UNESCO said: “The city has an ancient tradition of handicrafts, considered as both cultural and social practices passed on from one generation to the next. Around 50 expressions of crafts and folk art have remained throughout the city’s history and bear witness to Al-Ahsa’s scenic wealth, including textiles from palm trees, pottery, weaving and joinery.”\n\n" +
          "Al-Ahsa, which also has one of the largest palm tree oases in the world, hosts 36 weekly open markets and stages several festivals a year.\n\n"),
  BlogPost(
      creator: Guide(userName: "Yousef Taj"),
      date: t,
      title: "Authentic Saudi desert experience in Hail",
      likes: 2000,
      // tags: ["desert", "hail", "fun"],
      tags: [],
      imageUrl:
          "https://www.arabnews.com/sites/default/files/styles/n_670_395/public/2022/03/14/3120466-1158741468.jpg?itok=FlQK8oZF",
      body: "The northwestern Saudi city of Jubbah has the most famous rock art inscription site in the country, and is the fourth place in the Kingdom to be inscribed on the UNESCO List of World Heritage Sites.\n\n" +
          "This ancient location, with its spectacular dunes and sandy landscape, is being offered to adventurous travelers as a gateway to the desert.\n\n" +
          "The King Salman Royal Natural Reserve, which is the largest in the country and the fourth largest wild reserve in the world, is offering people inside and outside Saudi Arabia an immersive desert experience amid the 130,700 square kilometer space.\n\n" +
          "Rakayb Jubbah, which started on Feb. 24 and continues until March 19, allows visitors aged 18 and above to get a taste of an authentic Bedouin lifestyle.\n\n"),
  BlogPost(
      creator: Guide(userName: "Mowfaq Wali"),
      date: t.subtract(Duration(days: 1)),
      title: "Diriyah, Capital of Arab Culture for 2030",
      likes: 3000,
      // tags: ["diriyah", "history"],
      tags: [],
      imageUrl:
          "https://www.arabnews.com/sites/default/files/styles/n_670_395/public/2021/12/20/2975816-116020172.jpg?itok=geYrGt4O",
      body: "Diriyah in Saudi Arabia, revered as the birthplace of the Kingdom, has been chosen by the Arab League Educational, Cultural and Scientific Organization as the Capital of Arab Culture for 2030.\n\n" +
          "The choice was endorsed by Arab ministers of culture during their annual ALECSO meeting in Dubai on Dec. 19 and 20, after the organization’s standing committee for culture approved a vote in favor of Diriyah.\n\n" +
          "Diriyah is undergoing a major restoration and development effort, following a royal order that established the Diriyah Gate Development Authority in 2017, to transform the historic site into one of the most important global cultural-tourism destinations.\n\n" +
          "The Capital of Arab Culture celebrations in Diriyah in 2030 are expected to include a wide range of events, including cultural and artistic workshops, theater and film shows, cultural and heritage festivals, and competitions.\n\n"),
  BlogPost(
      creator: Guide(userName: "Mowfaq Wali"),
      date: t.subtract(Duration(days: 1)),
      title: "AlUla: Wonder of Arabia",
      likes: 3000,
      // tags: ["AlUla", "heritage"],
      tags: [],
      imageUrl:
          "https://www.arabnews.com/sites/default/files/styles/n_670_395/public/2021/11/20/2924481-81312836.jpg?itok=39Npt8eM",
      body: "Diriyah in Saudi Arabia, revered as the birthplace of the Kingdom, has been chosen by the Arab League Educational, Cultural and Scientific Organization as the Capital of Arab Culture for 2030.\n\n" +
          "The choice was endorsed by Arab ministers of culture during their annual ALECSO meeting in Dubai on Dec. 19 and 20, after the organization’s standing committee for culture approved a vote in favor of Diriyah.\n\n" +
          "Diriyah is undergoing a major restoration and development effort, following a royal order that established the Diriyah Gate Development Authority in 2017, to transform the historic site into one of the most important global cultural-tourism destinations.\n\n" +
          "The Capital of Arab Culture celebrations in Diriyah in 2030 are expected to include a wide range of events, including cultural and artistic workshops, theater and film shows, cultural and heritage festivals, and competitions.\n\n"),
  BlogPost(
      creator: Guide(userName: "Mowfaq Wali"),
      date: t.subtract(Duration(days: 1)),
      title: "Welcome to Abha",
      likes: 3000,
      // tags: ["AlUla", "heritage"],
      tags: [],
      imageUrl:
          "https://www.flydubai.com/en/media/Abha_Rijal_Amlaa2_2560x960_tcm8-152106.jpg",
      body: "Diriyah in Saudi Arabia, revered as the birthplace of the Kingdom, has been chosen by the Arab League Educational, Cultural and Scientific Organization as the Capital of Arab Culture for 2030.\n\n" +
          "The choice was endorsed by Arab ministers of culture during their annual ALECSO meeting in Dubai on Dec. 19 and 20, after the organization’s standing committee for culture approved a vote in favor of Diriyah.\n\n" +
          "Diriyah is undergoing a major restoration and development effort, following a royal order that established the Diriyah Gate Development Authority in 2017, to transform the historic site into one of the most important global cultural-tourism destinations.\n\n" +
          "The Capital of Arab Culture celebrations in Diriyah in 2030 are expected to include a wide range of events, including cultural and artistic workshops, theater and film shows, cultural and heritage festivals, and competitions.\n\n")
];
