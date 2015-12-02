tweets.df <- read.csv('./data/tweets.txt', sep='|')

tweets <- ts(tweets.df$tweets)

plot.ts(tweets)


plot.ts(log(tweets))


plot.ts(diff(log(tweets)))


acf(diff(log(tweets)), lag.max=48*3 + 24)
pacf(diff(log(tweets)), lag.max=48*3 + 24)


plot.ts(diff(diff(log(tweets)), lag=48))

tweets.removed_season <- diff(diff(log(tweets)), lag=48)


acf(diff(diff(log(tweets)), lag=48), lag.max=48*3)
pacf(diff(diff(log(tweets)), lag=48), lag.max=48*3)
