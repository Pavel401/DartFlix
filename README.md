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
  
  
 
> Take a look at the presentation [Here](https://drive.google.com/file/d/11au8ETgKUJ8KxVM09LsH4VLWeWHHJx0K/view?usp=sharing
)<br>
 > My [Software write up during the Microsoft Engage Program](https://drive.google.com/file/d/11au8ETgKUJ8KxVM09LsH4VLWeWHHJx0K/view?usp=sharing)

 
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
 I have already compiled the apk and attached the download link.Just install it and you are good to go.
```
[![Download Apk - Click Here](https://img.shields.io/badge/Download_Apk-Click_Here-2ea44f)](https://drive.google.com/uc?id=1_-jhXwut3gYcALAgsyl4f6Wkj-QMV_gE&export=download)

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
  
## Output Screenshots
Recommendations Page            |  Sentiment Analysis Page
:-------------------------:|:-------------------------:
![tia5569436775523766645](https://user-images.githubusercontent.com/47685150/170873184-6e1dd495-e8c9-445a-b4a0-239af18fdeee.png)|![tia8858542068622280607](https://user-images.githubusercontent.com/47685150/170873198-282dcac1-d866-4fcf-8cc6-70a810498104.png)
  
Movie Overview Page            |   Cast List Page
:-------------------------:|:-------------------------:
![tia5569436775523766645 (1)](https://user-images.githubusercontent.com/47685150/170873801-1c72fce5-7a40-4aae-892a-b286c028ab98.png)|![tia6276718872008158942](https://user-images.githubusercontent.com/47685150/170873849-f16b8e54-2264-4082-b624-9458eafb21e7.png)

 More Movies of a Cast            |   Top Movies
:-------------------------:|:-------------------------:
![tia2767914410413613655](https://user-images.githubusercontent.com/47685150/170873917-e294d51b-dfb2-46d3-ab16-5e5b05f57da6.png)|![Screenshot_20220529-185934](https://user-images.githubusercontent.com/47685150/170873997-5e20bbc0-3aac-48d5-ad0b-02e36b0a78c0.jpg)

 Genre Wise Search Page            |   Search Result Page
:-------------------------:|:-------------------------:
![tia4793552705933106791](https://user-images.githubusercontent.com/47685150/170874098-49c90c64-a527-4ce8-b1f1-4122d880dabf.png)|![tia8104170913011518750](https://user-images.githubusercontent.com/47685150/170874128-4fc11c9e-aa10-4569-ba0b-c084e0f536ca.png)
  
 Swipable UI            |   Confirmation Dialog
:-------------------------:|:-------------------------:
![tia6145994717417066643](https://user-images.githubusercontent.com/47685150/170874277-b3cf85c7-dea2-4762-bc18-d9d23b92bead.png)|![tia8111643190604640115](https://user-images.githubusercontent.com/47685150/170874442-5e5bcf26-4d82-4359-b262-53e93bfd4c69.png)
  
 HomePage            |   Collaborative Recommendations
:-------------------------:|:-------------------------:
![tia993728855442297670](https://user-images.githubusercontent.com/47685150/170874735-d8a5cd8d-2794-481d-93ba-fe27c40403d2.png)|![tia93710582430609766](https://user-images.githubusercontent.com/47685150/170874706-fa3e4b9c-8470-49df-b156-4d5f8c5d4837.png)

 Profile Page            |   About & Contact Page
:-------------------------:|:-------------------------:
![tia5300446429116516377](https://user-images.githubusercontent.com/47685150/170874824-2e2dcd52-f0f6-4cde-91bf-a8871d28d19d.png)|![tia76456325585923122](https://user-images.githubusercontent.com/47685150/170874835-f1f1bc37-8576-437c-b99b-fd1a34afd7d4.png)





## Machine learning model used:

I have incorporated machine learning models like a bag of words, tf - idf vectorization, similarity analysis, and review analysis based on multinomial naïve bays algorithm. Which is a Bayesian learning approach popular in Natural Language Processing (NLP).
  ## Architecture :

![Blank diagram (1)](https://user-images.githubusercontent.com/47685150/170880263-1500966b-b94b-4043-a4c8-82ed1411cf93.png)


 ## Similarity Score : 

   How does it decide which item is most similar to the item user likes? Here come the similarity scores.
   
   It is a numerical value rangesthat  between zero to one which helps to determine how much two items are similar to each other on a scale of zero to one. This similarity score is obtained measuring the similarity between the text details of both of the items. So, similarity score is the measure of similarity between given text details of two items. This can be done by cosine-similarity.
  ![cosine_similarity](https://user-images.githubusercontent.com/47685150/170878468-6f9f87a7-393b-48ab-a4fb-e1dd5b47bcb3.png)

 
- And once again we can see that all details for that clicked movie comes as that of previous searched movie .
-  It provides a cool suggest movie feature with nice swipable card.

  ## Naive Bayes : 

  Naive Bayes is a fairly simple group of probabilistic algorithms that, for sentiment analysis classification, assigns a probability that a given word or phrase should be considered positive or negative.
Essentially, this is how Bayes’ theorem works. The probability of A, if B is true, is equal to the probability of B, if A is true, times the probability of A being true, divided by the probability of B being true: 
  ![1_e90_bvVf9Agxfk4DxWu7og](https://user-images.githubusercontent.com/47685150/170878386-6e408c51-d9f3-480d-8ada-4f065f90fbb1.jpeg)
  But that’s a lot of math! Basically, Naive Bayes calculates words against each other. So, with machine learning models trained for word polarity, we can calculate the likelihood that a word, phrase, or text is positive or negative.

When techniques like lemmatization, stopword removal, and TF-IDF are implemented, Naive Bayes becomes more and more predictively accurate.
  
## Note : 

Datasets of credits.csv and movies_metadata.csv download from [here](https://www.kaggle.com/rounakbanik/the-movies-dataset)
download these two datasets and put it in the recommendation api folder.
  



## API Reference
  
  API project can be found here https://github.com/Pavel401/Enage-Recommendation-API

#### Get MOVIE DETAILS

```http
  GET /getmovie/moviename
  (ex - https://enage22.herokuapp.com/getmovie/Avatar)
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `moviename` | `string` | **Required**. Movie name (ex-Avatar) |

  Takes movie name and returns movie details as  json.
 
#### Get Recommendations

```http
  GET /send/moviename
  (ex- https://enage22.herokuapp.com/send/Avatar)
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `moviename`      | `string` | **Required**. Moviename (ex-Avatar)|



Takes movie name and returns movie Recommendations based on cosine values.

