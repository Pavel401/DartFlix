<br/>

## Submission for Microsoft engage '2022

![image001](https://user-images.githubusercontent.com/79754424/167501435-3fea72dd-0e81-4bc3-bb7a-1ca85a715d49.jpg)

<br/>
<p align="center">
  <img width="700" align="center" src="https://res.cloudinary.com/dc0tfxkph/image/upload/v1653675342/Untitled_800_250px.png" alt="demo"/>
</p>

# `DartFlix` - The Movie Recommender built using Flutter & Dart

[![Custom Flask API](https://img.shields.io/badge/Flask-API-2ea44f)](https://enage22.herokuapp.com/)
[![Flutter - Framework](https://img.shields.io/badge/Flutter-Framework-7220C9)](https://flutter.dev/)
[![Flask - API](https://img.shields.io/badge/Flask-API-7220C9)](https://flask.palletsprojects.com/en/2.1.x/)
[![Python -  ](https://img.shields.io/badge/Python-_-7220C9)](https://www.python.org/)
[![Heroku -  Deploy](https://img.shields.io/badge/Heroku-_Deploy-7220C9)](https://dashboard.heroku.com/apps)
[![Kaggle -  Dataset](https://img.shields.io/badge/Kaggle-_Dataset-7220C9)](https://www.kaggle.com/datasets/tmdb/tmdb-movie-metadata?select=tmdb_5000_movies.csv)
<br /><br />

- `DartFlix` is a Content-Based-Movie-Recommender which gives recommendations based on KNN.

- A Content-Based Recommender works by the data that we take from the user, either explicitly (rating) or implicitly (clicking on a link). By the data we create a user profile, which is then used to suggest to the user, as the user provides more input or take more actions on the recommendation, the engine becomes more accurate.

- Content Based Recommender System recommends movies similar to the movie user likes and analyses the sentiments on the reviews given by the user for that movie.

- The details of the movies(title, genre, runtime, rating, poster, etc) are fetched using an API created in this project using Flask and Machine learning, https://enage22.herokuapp.com/getmovie/<MovieName> and https://www.themoviedb.org/documentation/api, and using the IMDB id of the movie in the API, I did web scraping to get the reviews given by the user in the IMDB site using `beautifulsoup4` and performed sentiment analysis on those reviews.


- There is a Movie search feature which will show all the recommended movies from the movies name.
  
- `DartFlix` uses users movie taste to show recommended movies in the homepage. 
  
- It also stores the users previously watched movies.
 
- There is a Movie review tab which shows all reviews and  performed sentiment analysis on those reviews.
  
  
 
> Take a look at the presentation [Here](https://drive.google.com/file/d/1iRYu371qu8338wkqMpL65NdTyt4VCVAL/view?usp=sharing
)<br>
 > My [Software write up during the Microsoft Engage Program](https://drive.google.com/file/d/11sCm9MFrsnFHygHmQC7XK-LU7sgBU44D/view?usp=sharing)

 
 ## Features :
   
 - When the user opens the app for the first time ,it shows a Introduction screen which gives a basic idea about the app.
- Now the Genres selection and language selection page will open to the user.Based on this parameters user's homescreen will be setup.
  
- In the homescreen `DartFlix` shows all the previously watched movies, so that user can start watching from where user stopped watching.It's basically stores user's watching history in local db.

 
 -  In the homescreen `DartFlix` shows all the recommended  movies based on users previous watching history.

- it provides search movie feature which fetche movies from the database and displays inside the app.
-  It will provide the movie title, movie poster, overviews, rating, genre, release date, runtime, status.
- It also provides top cast name and their other movies.
- `DartFlix` also provides user reviews in terms of comments and sentiments that is very important for deciding any particular searched movie is good or bad.
- Now the main feature that is recommending the movie similar to that of the searched movie comes below of reviews.
- If we click any of the recommended movie poster it takes us to the page of that clicked movie .
## Installation

Install DartFlix apk

```bash
 I have already compiled the apk and attached the download link.
```
![Download APK  - from Here](https://img.shields.io/badge/Download_APK_-from_Here-7220C9)

## Run Locally
Flutter SDK

```bash
  Make sure you have Flutter installed.
```
Clone the project

```bash
  git clone https://github.com/Pavel401/DartFlix
```

Go to the project directory

```bash
 Open the project folder
```

Install dependencies

```bash
  open `pubspec.yaml` and install the dependencies
```
Connect your android phone or AVD

```bash
 Make sure your device is connected
```
Debug the app

```bash
 flutter run 
```


## Architecture :
<p align="center">
  <img width="700" align="center" src="https://res.cloudinary.com/dc0tfxkph/image/upload/v1653685709/Blank_diagram_1.png" alt="demo"/>
</p>

## Cosine Similarity used here :
  Cosine similarity is a metric used to measure how similar the documents are irrespective of their size. Mathematically, it measures the cosine of the angle between two vectors projected in a multi-dimensional space. The cosine similarity is advantageous because even if the two similar documents are far apart by the Euclidean distance (due to the size of the document), chances are they may still be oriented closer together. The smaller the angle, higher the cosine similarity.
  
  ![Uzoma Medium Gif](https://github.com/Gourav1695/Filmy-The_Movie_Recommender/blob/main/screenshot/cosine_similarity.png)
## Machine learning model used:

I have incorporated machine learning models like a bag of words, tf - idf vectorization, similarity analysis, and review analysis based on multinomial naïve bays algorithm. Which is a Bayesian learning approach popular in Natural Language Processing (NLP).

 ## Similarity Score : 

   How does it decide which item is most similar to the item user likes? Here come the similarity scores.
   
   It is a numerical value rangesthat  between zero to one which helps to determine how much two items are similar to each other on a scale of zero to one. This similarity score is obtained measuring the similarity between the text details of both of the items. So, similarity score is the measure of similarity between given text details of two items. This can be done by cosine-similarity.
  
 
- And once again we can see that all details for that clicked movie comes as that of previous searched movie .
-  It provides a cool suggest movie feature with nice swipable card.

## Note : 

Datasets of credits.csv and movies_metadata.csv download from [here](https://www.kaggle.com/rounakbanik/the-movies-dataset)
download these two datasets and put it in the recommendation api folder.
  
