# PedalBoard

> Always have your favorite pedalboard configurations at your reach!

![header](image)

## Overview
PedalBoard is my way to help guitarrist manage their pedalboards, and save the knobs positioning for each song they play. As I began to play guitar in a band, I started to experience some problems trying to remember the exact configurations for the pedals I used in every song. With the band's setlist growing each rehearse, and me acquiring new pedals it quickly became obvious that I wasn't able to get the configurations 100% during a performance (in which there is no time to keep playing with the knobs until the sound is right).

First, I tried taking photos of the whole board with my phone, but in the first show I looked at them I understood they were not objective enough. As I was looking at the photo there were too much information that kept distracting me from seeing the pedals configurations as fast as possible. So, I decided to develop a small app to keep track of it for me, and put that app on my portifolio.

The work I've done here is not complicated nor technologicaly challenging, but solved my problem and hopefully somebodyelses. The app is in MVVM archtecture using Firebase as Authentication and Database service. The benefit of MVVM is to keep all views separeted and independent of the logical structure of the ViewModels while also keeping the ViewModels slim and easy to replace the DataProviders they use if I wanted to quit using Firebase.

## Features
- Save all effects pedals configurations and combinations that you use to play your favourite songs;
- Order the saved songs in a setlist to help you quickly access the next tune of your playlist when playing live;
- Share your config with other guitarrists so they can give you feedback on what you could do different (COMING SOON);
- Search how to get to that sick tone that your favourite tune has and learn with other's setups about pedal configurations and pedalboard tips! (COMING SOON);

## Requirements
First you need is Xcode running Swift 4 and an internet connection. Then you need to setup an account at https://firebase.google.com/ and follow "first steps" to configure your new project with an iOS app inside, get your app's key and switch it with mine in AppDelegate.swift. This project uses the auth and realtime databases APIs so you will have to configure that as well.

## Download
Simply do a 
`git clone https://github.com/matheusberger/PedalBoard` in your desired directory or download the whole project as a zip file from the same url.

## Credits
A special thanks to my friends Mateus Bolsoni (https://www.behance.net/mbolsoni) for making the most awesome interface design I've ever seen and Daniel Maranhão (https://github.com/dbm2) for programming the whole backend server (in Node.js) and database with MongoDB.

## Contributing
Feel free to use any code in this repo as a research material and copy if you want, I tried to keep every aspect of the app modular enough to be reused in other context. You can reach me at /matheusberger on github or matheuscberger@gmail.com if you wish to send any suggestions about this project (or not :D).
If you wish to directly contribute with code all you need to do is make a new branch with your changes along with a file telling what you've done and submit a pull request.