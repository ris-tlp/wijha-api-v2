import 'package:flutter/material.dart';
import 'package:wijha/models/Forums/ForumPost.dart';
import 'package:wijha/models/Forums/Subforum.dart';
import 'package:wijha/models/Forums/Tag.dart';
import 'package:wijha/models/Tours/Category.dart';
import 'package:wijha/models/Users/Guide.dart';
import 'package:wijha/widgets/constants.dart';

class TempPosts {
  List<ForumPost> jeddahList = [
    ForumPost(
        creator: Guide(userName: 'Khalifa Alhomely'),
        date: DateTime.now(),
        content:
            "I'm going to visit jeddah this may. Can anyone advise me on the best way to do this trip? Do anyone experience of using Wijha. They offer interesting tours to Jeddah. Thanks :)",
        title: "Jeddah Tours",
        likes: 17,
        tags: [
          Tag(title: 'Tours', imageUrl: adventureIcon),
          Tag(title: 'Jeddah', imageUrl: historicalIcon),
          Tag(title: 'Discussion', imageUrl: natureIcon)
        ],
        comments: [
          {
            'name': 'Mohammed Khalid',
            'pic': 'https://picsum.photos/id/1020/300/30',
            'message':
                'Hey there. Yes, I have used them they were very helpful and responsive. Wijha will help you. You can just download their mobile app to find all sorts of tours :)'
          },
          {
            'name': 'Khalid Ali',
            'pic': 'https://picsum.photos/id/1021/300/30',
            'message':
                'As the previous comment suggested. Wijha are a great options for tours in Riyadh in the Kingdom.'
          },
        ],
        subforum: Subforum(content: "", title: "", imageUrl: "", posts: [])),
    ForumPost(
        creator: Guide(userName: 'Mowfaq Wali'),
        date: DateTime.now(),
        content:
            "Hi, I'm looking hotels in a good location in Jeddah,Means near attractions or walking distances. Not something far away isolated. Thanks. Shoukran",
        title: "Jeddah Hotels",
        likes: 11,
        tags: [Tag(title: 'Hotels', imageUrl: museumIcon)],
        comments: [
          {
            'name': 'Ali Raza',
            'pic': 'https://picsum.photos/id/1016/300/30',
            'message':
                'Four Seasons Hotel Jeddah at Kingdom Centre is a great option But is a bit expensive, A cheaper option is Holiday Inn Jeddah - Olaya'
          },
          {
            'name': 'Aziz Khalid',
            'pic': 'https://picsum.photos/id/1018/300/30',
            'message':
                'Hotel Al Khozama and InterContinental Jeddah are all great choices and they are close to many attractions'
          },
        ],
        subforum: Subforum(content: "", title: "", imageUrl: "", posts: [])),
    ForumPost(
        creator: Guide(userName: 'Abdulrahman Siddiqui'),
        date: DateTime.now(),
        content:
            'Hey there, will visit Jeddah in may.! We are staying in Al Hamra area.! So is it good area to stay & metro is easy access to visit other side of city? Which are the best breakfast restaurants nearby to try out? Anything more anyone can suggest?',
        title: "Any tips on Jeddah?",
        likes: 8,
        tags: [
          Tag(title: 'Jeddah', imageUrl: historicalIcon),
        ],
        comments: [
          {
            'name': 'Ahmed Nasser',
            'pic': 'https://picsum.photos/id/10/300/30',
            'message':
                'Al Hamra is a large area and mostly residential/office. It is close to many attractions and has plenty of malls, and restaurants and is well connected. One of best breakfast restaurants nearby is Al Amanah'
          },
        ],
        subforum: Subforum(content: "", title: "", imageUrl: "", posts: [])),
  ];
  List<ForumPost> postList = [
    ForumPost(
        creator: Guide(userName: 'Khalifa Alhomely'),
        date: DateTime.now(),
        content:
            "I'm going to visit Riyadh mid April. Can anyone advise me on the best way to do this trip? Do anyone experience of using Wijha. They offer interesting tours to Riyadh. Thanks :)",
        title: "Riyadh Tours",
        likes: 17,
        tags: [
          Tag(title: 'Tours', imageUrl: adventureIcon),
          Tag(title: 'Riyadh', imageUrl: historicalIcon),
          Tag(title: 'Discussion', imageUrl: natureIcon)
        ],
        comments: [
          {
            'name': 'Mohammed Khalid',
            'pic': 'https://picsum.photos/id/1020/300/30',
            'message':
                'Hey there. Yes, I have used them they were very helpful and responsive. Wijha will help you. You can just download their mobile app to find all sorts of tours :)'
          },
          {
            'name': 'Khalid Ali',
            'pic': 'https://picsum.photos/id/1021/300/30',
            'message':
                'As the previous comment suggested. Wijha are a great options for tours in Riyadh in the Kingdom.'
          },
        ],
        subforum: Subforum(content: "", title: "", imageUrl: "", posts: [])),
    ForumPost(
        creator: Guide(userName: 'Mowfaq Wali'),
        date: DateTime.now(),
        content:
            "Hi, I'm looking hotels in a good location in Riyadh,Means near attractions or walking distances. Not something far away isolated. Thanks. Shoukran",
        title: "Riyadh Hotels",
        likes: 11,
        tags: [Tag(title: 'Hotels', imageUrl: museumIcon)],
        comments: [
          {
            'name': 'Ali Raza',
            'pic': 'https://picsum.photos/id/1016/300/30',
            'message':
                'Four Seasons Hotel Riyadh at Kingdom Centre is a great option But is a bit expensive, A cheaper option is Holiday Inn Riyadh - Olaya'
          },
          {
            'name': 'Aziz Khalid',
            'pic': 'https://picsum.photos/id/1018/300/30',
            'message':
                'Hotel Al Khozama, Hotel Al Khozama and InterContinental Riyadh are all great choices and they are close to many attractions'
          },
        ],
        subforum: Subforum(content: "", title: "", imageUrl: "", posts: [])),
    ForumPost(
        creator: Guide(userName: 'Abdulrahman Siddiqui'),
        date: DateTime.now(),
        content:
            'Hey there, will visit Riyadh in may.! We are staying in Al Hamra area.! So is it good area to stay & metro is easy access to visit other side of city? Which are the best breakfast restaurants nearby to try out? Anything more anyone can suggest?',
        title: "Any tips on Riyadh?",
        likes: 8,
        tags: [
          Tag(title: 'Riyadh', imageUrl: historicalIcon),
        ],
        comments: [
          {
            'name': 'Ahmed Nasser',
            'pic': 'https://picsum.photos/id/10/300/30',
            'message':
                'Al Hamra is a large area and mostly residential/office. It is close to many attractions and has plenty of malls, and restaurants and is well connected. One of best breakfast restaurants nearby is Sherpa'
          },
        ],
        subforum: Subforum(content: "", title: "", imageUrl: "", posts: [])),
    ForumPost(
        creator: Guide(userName: 'Yousef Taj'),
        date: DateTime.now(),
        content:
            'HI, I will be only staying for 3 days in Riyadh and i will have to buy a lot of gifts mainly Abayas for women. So, where can i find good Abayas for reasonable prices? I would really appreciate your help and thanks in advance',
        title: "Shopping in Riyadh",
        likes: 7,
        tags: [Tag(title: 'Shopping', imageUrl: shoppingIcon)],
        comments: [
          {
            'name': 'Rafee heraki',
            'pic': 'https://picsum.photos/id/1003/300/30',
            'message':
                'Check Mega mall ( AL SIRAFI mall) there are alot of Abayas and gifts shops, then check AL SHATI market (go at night because of the weather)'
          },
        ],
        subforum: Subforum(content: "", title: "", imageUrl: "", posts: [])),
    ForumPost(
        creator: Guide(userName: 'Omar Khan'),
        date: DateTime.now(),
        content:
            "Hi - I'm trying to register but it isn't allowing me to. Do I have to wait until I get to Riyadh,SA before it will allow me to register?",
        title: "Tawakkalna App",
        likes: 5,
        tags: [Tag(title: 'Discussion', imageUrl: natureIcon)],
        comments: [
          {
            'name': 'Saud Ahmed',
            'pic': 'https://picsum.photos/id/101/300/30',
            'message': 'Yes it will work in Saudi arabia only'
          },
        ],
        subforum: Subforum(content: "", title: "", imageUrl: "", posts: [])),
  ]; // To
}
