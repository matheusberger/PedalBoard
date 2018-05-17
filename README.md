# PedalBoard

PedalBoard is my way to help guitarrist manage their pedalboards, and save the knobs positioning for each song they play. 
As I began to play guitar in a band, I started to experience some problems trying to remember the exact configurations for the pedals I used in every song. With the band's setlist growing each rehearse, and me acquiring new pedals it quickly became obvious that I wasn't able to get the configurations 100% during a performance (in which there is no time to keep playing with the knobs until the sound is right).

First, I tried taking photos of the whole board with my phone, but in the first show I looked at them I understood they were not objective enough. As I was looking at the photo there were too much information that kept distracting me from seeing the pedals configurations as fast as possible.
So, I decided to develop a small app to keep track of it for me, and put that app on my portifolio.

The work I've done here is not complicated nor technologicaly challenging, but solved my problem and hopefully somebodyelses.
The app is in MVVM archtecture using Firebase as Authentication and Database service. The benefit of MVVM is to keep all views separeted and independent of the logical structure of the ViewModels while also keeping the ViewModels slim and easy to replace the DataProviders they use if I wanted to quit using Firebase.

Feel free to use any code in this repo as a research material and copy if you want, I tried to keep every aspect of the app modular enough to be reused in other context.

A special thanks to my friends Mateus Bolsoni (https://www.behance.net/mbolsoni) for making the most awesome interface design I've ever seen and Daniel Maranhão (https://github.com/dbm2) for programming the whole backend server (in Node.js) and database with MongoDB.

Thanks for your attention, 
Matheus Berger