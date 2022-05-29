import pandas as pd
from flask import Flask, render_template,Request,Response,request,jsonify
from sklearn.metrics.pairwise import cosine_similarity
from sklearn.feature_extraction.text import CountVectorizer
import pandas as pd
from flask_cors import CORS, cross_origin
import requests
import json
from tmdbv3api import TMDb
import pickle as pkl

import numpy as np
import random
import bs4
import re
import operator
import pandas as pd
import matplotlib.pyplot as plt
plt.style.use('fivethirtyeight')
import seaborn as sns
import warnings
warnings.filterwarnings('ignore')
import base64
import io
from matplotlib.pyplot import imread
import codecs
from IPython.display import HTML
tmdb=TMDb()
tmdb.api_key='8b5da40bcd2b5fa4afe55c468001ad8a'
from  tmdbv3api import Movie
tmdb_movie=Movie()
df2=pd.read_csv("Main_data.csv")
knn1=pd.read_csv("knn_data.csv")

from sklearn.feature_extraction.text import CountVectorizer,TfidfVectorizer
from sklearn.metrics.pairwise import linear_kernel
vectorizer=pkl.load(open('vectorizerer.pkl', 'rb'))
clt=pkl.load(open('nlp_model.pkl', 'rb'))

url = [
    "http://api.themoviedb.org/3/discover/movie?api_key=360a9b5e0dea438bac3f653b0e73af47&primary_release_year=2015&adult=false",
    "http://api.themoviedb.org/3/discover/movie?api_key=360a9b5e0dea438bac3f653b0e73af47&primary_release_year=2014&adult=false",
    "https://api.themoviedb.org/3/movie/popular?api_key=8b5da40bcd2b5fa4afe55c468001ad8a&language=en-US&page=1&adult=false",
    "https://api.themoviedb.org/3/movie/popular?api_key=8b5da40bcd2b5fa4afe55c468001ad8a&language=en-US&page=2&adult=false",
    "https://api.themoviedb.org/3/movie/popular?api_key=8b5da40bcd2b5fa4afe55c468001ad8a&language=en-US&page=3&adult=false",
    "https://api.themoviedb.org/3/discover/movie?api_key=360a9b5e0dea438bac3f653b0e73af47&with_genres=18&adult=false",
    "http://api.themoviedb.org/3/discover/movie?api_key=360a9b5e0dea438bac3f653b0e73af47&primary_release_year=2020&adult=false",
    "http://api.themoviedb.org/3/discover/movie?api_key=360a9b5e0dea438bac3f653b0e73af47&primary_release_year=2019&adult=false",
    "http://api.themoviedb.org/3/discover/movie?api_key=360a9b5e0dea438bac3f653b0e73af47&primary_release_year=2017&adult=false",
    "http://api.themoviedb.org/3/discover/movie?api_key=360a9b5e0dea438bac3f653b0e73af47&primary_release_year=2016&adult=false",
    "https://api.themoviedb.org/3/discover/movie?api_key=360a9b5e0dea438bac3f653b0e73af47&with_genres=27",
    "https://api.themoviedb.org/3/discover/movie?api_key=360a9b5e0dea438bac3f653b0e73af47&with_genres=16"
  ]
def get_news():
    response = requests.get("https://www.imdb.com/news/top/?ref_=hm_nw_sm")
    soup = bs4.BeautifulSoup(response.text, 'html.parser')
    data = [re.sub('[\n()]', "", d.text) for d in soup.find_all('div', class_='news-article__content')]
    image = [m['src'] for m in soup.find_all("img", class_="news-article__image")]
    t_data = []
    for i in range(len(data)):
        t_data.append([image[i], data[i][1:len(data[i])-1]])
    return t_data


def getdirector(x):
    data = []
    result = tmdb_movie.search(x)
    movie_id = result[0].id
    response = requests.get(
        "https://api.themoviedb.org/3/movie/{}/credits?api_key=8b5da40bcd2b5fa4afe55c468001ad8a".format(
            movie_id))
    data_json = response.json()
    data.append(data_json)
    crew=data[0]['crew']

    director=[]
    for c in crew:
        if c['job']=='Director':
            director.append(c['name'])
            break
    return director
def get_swipe():
    data=[]
    val=random.choice(url)
    for i in range(5):
        lis=[]
        response = requests.get(
            val+"&page="+str(i+1))
        data_json = response.json()
        lis.append(data_json["results"])
        for i in lis[0]:
            data.append(i)
    return data

def getreview(x):
    data=[]
    result=tmdb_movie.search(x)
    movie_id=result[0].id
    response=requests.get("https://api.themoviedb.org/3/movie/{}/reviews?api_key=8b5da40bcd2b5fa4afe55c468001ad8a&language=en-US&page=1".format(movie_id))
    data_json=response.json()
    data.append(data_json)
    return data
def getrating(title):
    movie_review = []
    data=getreview(title)
    for i in data[0]['results']:
        pred=clt.predict(vectorizer.transform([i['content']]))
        if pred[0]=='positive':
            movie_review.append({
                "review":i['content'],
                "rating":"Good"
            })
        else:
            movie_review.append({
                "review": i['content'],
                "rating": "Bad"
            })
    return movie_review
def get_data(x):
    data=[]
    result=tmdb_movie.search(x)
    movie_id=result[0].id
    response=requests.get("https://api.themoviedb.org/3/movie/{}?api_key=8b5da40bcd2b5fa4afe55c468001ad8a".format(movie_id))
    response2=requests.get("https://api.themoviedb.org/3/movie/{}/credits?api_key=8b5da40bcd2b5fa4afe55c468001ad8a".format(movie_id))
    response3=requests.get("https://api.themoviedb.org/3/movie/{}/keywords?api_key=8b5da40bcd2b5fa4afe55c468001ad8a".format(movie_id))
    data_json=response.json()
    data_json2=response2.json()
    data_json3=response3.json()
    data.append(data_json)
    data.append(data_json2)
    data.append(data_json3)
    return data
def getcomb(movie_data):
    cast_data=movie_data[1]['cast']
    cast=[]
    for data in cast_data:
        cast.append(data['name'])
    crew=movie_data[1]['crew']
    director=[]
    for c in crew:
        if c['job']=='Director':
            director.append(c['name'])
            break
    genres=[]
    for x in movie_data[0]['genres']:
        genres.append(x['name'])
    keywords=[]
    for k in movie_data[2]['keywords']:
        keywords.append(k['name'])
    d=str(cast)+str(keywords)+str(genres)+director[0]+str(movie_data[0]['overview'])
    return d
    
def get_recommendations(title):
    movie_data=get_data(title)
    total_data=getcomb(movie_data)
    df2=pd.read_csv("Main_data.csv")
    df2['comb']=df2['cast']+df2['director']+df2['genres']+df2['keywords']+df2['overview']
    myseries=pd.Series(data=[total_data,title],index=['comb','title_x'])
    flag=0
    for i in df2['title_x']:
        if i==title:
            flag=1
    if flag==0:
        df2=df2.append(myseries,ignore_index=True)
    df2=df2.replace(np.nan,'')
    tfidf = TfidfVectorizer(stop_words='english')
    count_matrix = tfidf.fit_transform(df2['comb'])
    cosine_sim = cosine_similarity(count_matrix, count_matrix)
    indices = pd.Series(df2.index, index=df2['title_x'])
    idx=indices[title]
    sim_scores = list(enumerate(cosine_sim[idx]))
    sim_scores = sorted(sim_scores, key=lambda x: x[1], reverse=True)
    sim_scores = sim_scores[1:10]
    movie_indices = [i[0] for i in sim_scores]
    return df2['title_x'].iloc[movie_indices]


def get_data2(x):
    data=[]
    result=tmdb_movie.search(x)
    movie_id=result[0].id
    trailer=requests.get("https://api.themoviedb.org/3/movie/{}/videos?api_key=8b5da40bcd2b5fa4afe55c468001ad8a&language=en-US".format(movie_id))
    response=requests.get("https://api.themoviedb.org/3/movie/{}?api_key=8b5da40bcd2b5fa4afe55c468001ad8a".format(movie_id))
    data_json = response.json()
    trailer=trailer.json()
    data.append(data_json)
    data.append(trailer)
    return data
# FLASK
app = Flask(__name__)
cors = CORS(app)
@app.route('/')
def index():
   return render_template("index.html")
@app.route('/getname',methods=["GET"])
def getnames():
   data=[]
   for i in df2["title_x"]:
       data.append(i)
   return jsonify(data)
@app.route('/getmovie/<movie_name>',methods=["GET"])
def getmovie(movie_name):
   data=get_data2(movie_name)
   return jsonify(data)

@app.route('/getreview/<movie_name>', methods=["GET"])
def getreviews(movie_name):
    data=getrating(movie_name)
    return jsonify(data)
@app.route('/getdirector/<movie_name>', methods=["GET"])
def getdirectorname(movie_name):
    data=getdirector(movie_name)
    return jsonify(data)
@app.route('/getswipe', methods=["GET"])
def getswipe():
    data=get_swipe()
    return jsonify(data)
@app.route('/getnews', methods=["GET"])
def getnewsdata():
    data=get_news()
    return jsonify(data)
@app.route('/send/<movie_name>', methods=["GET"])
def get(movie_name):
    if request.method=="GET":
        val = get_recommendations(movie_name)
        if val is None:
            return jsonify({"message":"movie not found in database"})
        val = list(val)
        result=[]
        try:
            for i in val:
                res=get_data2(i)
                result.append(res[0])
        except requests.ConnectionError:
            return jsonify({"movie not found in database"})
        return jsonify(result)

if __name__ == '__main__':
    app.run(debug=True,port=5000)
