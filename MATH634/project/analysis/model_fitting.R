require("forecast")

tweets.df <- read.csv('./data/tweets.txt', sep='|')

X_t <- ts(tweets.df$tweets)

pdf("log_plot.pdf", width=5, height=5)

Y_t <- log(X_t) - mean(log(X_t))
plot.ts(Y_t)
dev.off()


pdf("seasonal_plot.pdf", width=5, height=5)
plot.ts(diff(Y_t, lag=48))
dev.off()

pdf("seasonal_acf.pdf", width=5, height=5)
acf(diff(Y_t, lag=48), lag.max=48*3, main="(1-B^48)Y_t")
dev.off()

pdf("seasonal_pacf.pdf", width=5, height=5)
pacf(diff(Y_t, lag=48), lag.max=48*3, main="(1-B^48)Y_t")
dev.off()


pdf("trend_plot.pdf", width=5, height=5)
plot.ts(diff(diff(Y_t, lag=48)))
dev.off()

pdf("trend_acf.pdf", width=5, height=5)
acf(diff(diff(Y_t, lag=48)), lag.max=48*3, main="(1-B)(1-B^48)Y_t")
dev.off()

pdf("trend_pacf.pdf", width=5, height=5)
pacf(diff(diff(Y_t, lag=48)), lag.max=48*3, main="(1-B)(1-B^48)Y_t")
dev.off()

model <- arima(Y_t, order=c(0,1,2), seasonal=list(order=c(1,1,0), period=48))

model

(1-pnorm(abs(model$coef)/sqrt(diag(model$var.coef))))*2

model <- arima(Y_t, order=c(0,1,2))

model

(1-pnorm(abs(model$coef)/sqrt(diag(model$var.coef))))*2

pdf("res_acf.pdf", width=5, height=5)
acf(model$residuals, lag.max=48*3)
dev.off()

Box.test(model$residuals, lag=50, type = "Ljung-Box", fitdf=3)