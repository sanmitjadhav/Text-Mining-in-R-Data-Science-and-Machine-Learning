library(tm)
library(readr)
require(graphics)
text <- readLines("modi.txt")
text
corpus <- Corpus(VectorSource(text))
# clean up the corpus using tm_map()
corpus_clean <- tm_map(corpus, (tolower))
inspect(corpus_clean)
corpus_clean <- tm_map(corpus_clean, removeNumbers)
stopwords("english")
corpus_clean <- tm_map(corpus_clean, removeWords, stopwords())
inspect(corpus_clean)
corpus_clean <- tm_map(corpus_clean, removePunctuation)
corpus_clean <- tm_map(corpus_clean, stripWhitespace)
inspect(corpus_clean)

# create a document-term sparse matrix
dtm <- TermDocumentMatrix(corpus_clean, 
                          control = list(minWordLength=c(1,Inf)))
findFreqTerms(dtm, lowfreq = 2)
#Barplot
termFrequency <- rowSums(as.matrix(dtm))
t
termFrequency <- subset(termFrequency, termFrequency>=10)
library(ggplot2)
barplot(termFrequency,las=2, col = rainbow(20))
install.packages("wordcloud")
library(wordcloud)
m <- as.matrix(dtm)
m
wordFreq <- sort(rowSums(m), decreasing=TRUE)
wordFreq
wordcloud(words=names(wordFreq), freq=wordFreq, min.freq = 10, random.order = F, col=gray.colors(1))
wordcloud(words=names(wordFreq), freq=wordFreq, min.freq = 20, random.order = F, colors=rainbow(20))

pos=scan(file.choose(), what="character", comment.char=";")	# read-in positive-words.txt
neg=scan(file.choose(), what="character", comment.char=";")
neg# read-in negative-words.txt
pos.words=c(pos,"wow", "kudos", "hurray") 
pos.matches = match(names(wordFreq), pos.words)
pos.matches = !is.na(pos.matches)
freq_pos <- wordFreq[pos.matches]
p_names <- names(freq_pos)
wordcloud(p_names, freq=wordFreq, min.freq = 20, random.order = F, colors=rainbow(20))


neg.matches = match(names(wordFreq), neg)
neg.matches = !is.na(neg.matches)
freq_pos <- wordFreq[neg.matches]
n_names <- names(freq_pos)
wordcloud(n_names, freq=wordFreq, min.freq = 20, random.order = F, colors=rainbow(20))


