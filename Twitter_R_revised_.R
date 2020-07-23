#devtools::install_github("jrowen/twitteR", ref = "oauth_httr_1_0")
#devtools::install_version("httr",version="0.6.0",repos="http://cran.us.r-project.org")
library("twitteR")
#install.packages("ROAuth")
library("ROAuth")

cred <- OAuthFactory$new(consumerKey='ZIxPIvj21hhddkMxdjgt3wf94', # Consumer Key (API Key)
                         consumerSecret='BAxTBGvVKZNPiCRADNTNK3VrLO3wrK6OUms3bJXLSpMZ8z5IDI', #Consumer Secret (API Secret)
                         requestURL='https://api.twitter.com/oauth/request_token',
                         accessURL='https://api.twitter.com/oauth/access_token',
                         authURL='https://api.twitter.com/oauth/authorize')
#cred$handshake(cainfo="cacert.pem")
save(cred, file="twitter authentication.Rdata")

load("twitter authentication.Rdata")

#install.packages("base64enc")
library(base64enc)

#install.packages("httpuv")
library(httpuv)

setup_twitter_oauth("ZIxPIvj21hhddkMxdjgt3wf94", # Consumer Key (API Key)
                    "BAxTBGvVKZNPiCRADNTNK3VrLO3wrK6OUms3bJXLSpMZ8z5IDI", #Consumer Secret (API Secret)
                    "396521281-5OZ7cS7Ib90Akgdcx4ysPvZ2hQ8uFzGzXuxfxKHB",  # Access Token
                    "MDbqjOaaoMou3vfjSgEiev6omUkkatz692mQXzH8mVP3V")  #Access Token Secret

#registerTwitterOAuth(cred)

Tweets <- userTimeline('TheRock', n = 1000,includeRts = T)
TweetsDF <- twListToDF(Tweets)
dim(TweetsDF)
View(TweetsDF)

write.csv(TweetsDF, "Tweets.csv",row.names = F)

getwd()
# 
handleTweets <- searchTwitter('DataScience', n = 10000)
# handleTweetsDF <- twListToDF(handleTweets)
# dim(handleTweetsDF)
# View(handleTweetsDF)
# #handleTweetsMessages <- unique(handleTweetsDF$text)
# #handleTweetsMessages <- as.data.frame(handleTweetsMessages)
# #write.csv(handleTweetsDF, "TefalHandleTweets.csv")
# 
library(rtweet)
