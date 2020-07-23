# N-Grams in R
library(tm)
library(ggplot2)
library(wordcloud)
library(RWeka)
getwd()
text <- readLines("modi.txt")
text
corpus <- Corpus(VectorSource(text))
# Text Cleaning
# Convert the text to lower case
mycorpus <- tm_map(corpus, content_transformer(tolower))
# Remove numbers
mycorpus <- tm_map(corpus, removeNumbers)
# Remove english common stopwords
mycorpus <- tm_map(corpus, removeWords, stopwords("english"))
# Remove punctuations
stopwords("english")
mycorpus <- tm_map(corpus, removePunctuation)
# Eliminate extra white spaces
mycorpus <- tm_map(corpus, stripWhitespace)

# Bigrams 
minfreq_bigram<-2
token_delim <- " \\t\\r\\n.!?,;\"()"
bitoken <- NGramTokenizer(mycorpus, Weka_control(min=2,max=2, delimiters = token_delim))
two_word <- data.frame(table(bitoken))
two_word
sort_two <- two_word[order(two_word$Freq,decreasing=TRUE),]
sort_two
wordcloud(sort_two$bitoken,sort_two$Freq,random.order=FALSE,scale = c(2,0.35),min.freq = minfreq_bigram,colors = brewer.pal(8,"Dark2"),max.words=150)

# Trigrams 
minfreq_trigram <- 5
token_delim <- " \\t\\r\\n.!?,;\"()"
tritoken <- NGramTokenizer(mycorpus, Weka_control(min=3,max=3, delimiters = token_delim))
three_word <- data.frame(table(tritoken))
sort_three <- three_word[order(three_word$Freq,decreasing=TRUE),]
sort_three
wordcloud(sort_three$tritoken, sort_three$Freq, random.order=FALSE,min.freq = minfreq_trigram,scale = c(2,0.35),colors = brewer.pal(8,"Dark2"),max.words=150)


