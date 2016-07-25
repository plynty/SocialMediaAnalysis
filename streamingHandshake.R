setwd(mydir)

library.packages("streamR", "RCurl", "ROAuth", "RJSONIO", "stringr", "ROAuth")

source("twitterAuthentication.R")

requestURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/access_token"
authURL <- "https://api.twitter.com/oauth/authorize"

my_oauth <- OAuthFactory$new(consumerKey = consumer_key,
                             consumerSecret = consumer_secret,
                             requestURL = requestURL,
                             accessURL = accessURL,
                             authURL = authURL)

my_oauth$handshake(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))

# Don't run this every time
save(my_oauth, file = "my_oauth.Rdata")
