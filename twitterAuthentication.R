# Twitter Authentication
setwd(mydir)

library.packages("twitteR")

# Authentication for your account found at https://apps.twitter.com/
consumer_key <- ""
consumer_secret <- ""
access_token <- ""
access_secret <- ""

options(httr_oauth_cache=TRUE)
setup_twitter_oauth(consumer_key = consumer_key,
                    consumer_secret = consumer_secret,
                    access_token = access_token,
                    access_secret = access_secret)
