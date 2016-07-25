# Make sure to change your twitter authentication 
### Parameters for the archive Twitter Stream File
mydir <- "~/Plynty_TextMining/streamingTwitter/"
setwd(mydir)

# specific keywords to track the use of
keywordsToTrack <- c("Twitter")

# Boolean that determines if you want to look at the USA trends only
# TRUE - only looks for tweets about the currently trending topics in the USA
# FALSE - looks for the prases in the keywordsToTrack above
trackUSTrendsOnly <- FALSE

# the number of seconds that you wish to collect for
secondsToCollect <- 60

# File name of the tweet jason file
# if you already have a json file of the same name then this will apend to the json file
jsonFileName <- "trendsTracking.json"

#####################################
# Do not change anything below this #
#####################################

#installs and librarys as many packages as you want in one sweep
#parameters: string of package(s) name(s)
library.packages <- function(...){
  packages <- unlist(list(...))
  for (x in 1:length(packages)) {
    if(!(as.character(packages[x]) %in% installed.packages())) {
      cat("Couldn't find the package in installed packages.\n")
      cat("Installing ", packages[x],".\n", sep="")
      install.packages(as.character(packages[x]), dependencies = TRUE)
    }
    cat("Librarying ",packages[x],".\n", sep = "")
    try(library(as.character(packages[x]), character.only = TRUE))
  }
}

setwd(mydir)

# only run this line if you have not before
source("streamingHandshake.R")

# loading your twitter authorization
# this will open up a browser to get your information
#load("my_oauth.Rdata")

# determines if you want to track US trends only
if (trackUSTrendsOnly) {
  library.packages("twitteR")
  keywordsToTrack <- getTrends(23424977)$name
}

# Gather the tweets into a json file
# this will append to the .json file if it already exists
filterStream(file.name = jsonFileName, track = keywordsToTrack, language = "en", timeout = secondsToCollect, oauth = my_oauth)

# Build a dataframe from the tweets
tweets.df <- parseTweets(jsonFileName, simplify = TRUE)
