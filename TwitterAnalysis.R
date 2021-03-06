mydir <- "Directory of the repository"

setwd(mydir)

install.packages("twitteR")
install.packages("wordcloud")
install.packages("tm")
install.packages("RColorbrewer")

library("twitteR")
library("wordcloud")
library("tm")
library("RColorBrewer")

source("tiwtterAuthentication.R")

#n=1500 is the number of tweets I want to call.
twitter_feed <- searchTwitter('Whatever word you are searching for', n=1500);
##saving the text
twitter_feed_texts <- sapply(twitter_feed, function(x) x$getText())
df <- do.call("rbind", lapply(twitter_feed, as.data.frame));
twitter_feed_texts_Corpus <- Corpus(VectorSource(df$text));
twitter_feed_texts_Corpus = Corpus(VectorSource(text()));
## if you are using a mac add "mc.cores=1" at the end of each line to prevent errors.
twitter_feed_texts_Corpus = tm_map(twitter_feed_texts_Corpus, content_transformer(function(x) iconv(x, to='UTF-8-MAC', sub='byte')),
                                   mc.cores=1);
twitter_feed_texts_Corpus =tm_map(twitter_feed_texts_Corpus, content_transformer(tolower), mc.cores=1);
twitter_feed_texts_Corpus = tm_map(twitter_feed_texts_Corpus, removePunctuation, mc.cores=1);
twitter_feed_texts_Corpus = tm_map(twitter_feed_texts_Corpus, removeNumbers, mc.cores=1);
twitter_feed_texts_Corpus = tm_map(twitter_feed_texts_Corpus, function(x)removeWords(x,stopwords()), mc.cores=1);
twitter_feed_texts_Corpus <- tm_map(twitter_feed_texts_Corpus, removeWords, c("however","basic","https","retweet","dear", "email", mc.cores=1)); 
##Adding color
pal2 <- brewer.pal(8,"Dark2");
## Word cloud
wordcloud(twitter_feed_texts_Corpus, scale=c(2,0.2), random.order=T, colors=pal2);
dictCorpus = twitter_feed_texts_Corpus;
twitter_feed_texts_Corpus = tm_map(twitter_feed_texts_Corpus, stemDocument);
twitter_feed_texts_Corpus = tm_map(twitter_feed_texts_Corpus, stemCompletion, dictionary=dictCorpus);
myDtm = DocumentTermMatrix(twitter_feed_texts_Corpus, control = list(minWordLength = 5))
