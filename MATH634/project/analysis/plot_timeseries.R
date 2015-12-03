require(ggplot2)
require(grid)

tweets <- read.csv('./data/tweets.txt', sep='|')

tweets$hour <- factor(as.POSIXct(tweets$hour, format='%Y-%m-%d %H:%M:%S%z'))


tweets.title <- 'Number of Tweets Containing "#thewalkingdead" \nTweeted During Weekly 48 Hour Cycles'
tweets.x <- 'Time (EST)'
tweets.y <- 'Number of Tweets'

tweets.plot <- ggplot(tweets, aes(factor(hour), tweets, group=1)) + geom_line() + scale_x_discrete(breaks=c('2015-11-08 21:00:00', '2015-11-09 20:00:00', '2015-11-15 21:00:00', '2015-11-16 20:00:00', '2015-11-22 21:00:00', '2015-11-23 20:00:00')) + #scale_x_datetime(breaks='') +
    labs(x=tweets.x, y=tweets.y, title=tweets.title) +
    theme(axis.text.x=element_text(angle = 30, hjust=1),
          axis.title.x=element_text(vjust=-1.5),
          axis.title.y=element_text(vjust=1.5),
          title=element_text(vjust=1.5),
          plot.margin=unit(c(1,1,1,1), "cm"))

ggsave(path="plots", filename="tweets_plot.pdf", plot=tweets.plot, width=5.5, height=5.5, res=300)
