require("forecast")

tweets.df <- read.csv('./data/tweets.txt', sep='|')

X_t <- ts(tweets.df$tweets)

Y_t <- log(X_t) - mean(log(X_t))

model <- arima(Y_t, order=c(0,1,2), seasonal=list(order=c(1,1,0), period=48))

p <- predict(model, 48)

L90 <- exp(p$pred + mean(log(X_t)) - 1.645*p$se)
U90 <- exp(p$pred + mean(log(X_t)) + 1.645*p$se)

Forecast <- exp(p$pred + mean(log(X_t)) + model$sigma2/2)

Period = c((length(X_t)+1):(length(X_t)+48))
df = data.frame(Period,L90,Forecast,U90)
write.table(df[1:24,], file="forecast_1.csv", sep=",", row.names=FALSE, quote=FALSE)
write.table(df[25:48,], file="forecast_2.csv", sep=",", row.names=FALSE, quote=FALSE)

pdf("forecast.pdf", width=7, height=6)
plot(c(1:144), X_t[1:144], xlim=c(1,144+48), ylim=c(1,250000),type="o",
     ylab="Number of Tweets", xlab="Observation", col="black",
     main="Next Cycle Forecasts and 90% Confidence Intervals")
points(Forecast, pch=16, col="blue")
lines(L90, col="red")
lines(U90, col="red")
dev.off()
