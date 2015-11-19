quarter_variable <- function(ts, position){
    vector <- rep(0, 4)
    vector[position] <- 1

    variable <- rep(vector, length(ts) / 4)

    return(variable)
}

bills <- scan("bills.csv", skip=1)
bills.ts <- ts(bills)

bills.ts.Q1 <- quarter_variable(bills.ts, 1)
bills.ts.Q2 <- quarter_variable(bills.ts, 2)
bills.ts.Q3 <- quarter_variable(bills.ts, 3)
bills.ts.Q4 <- quarter_variable(bills.ts, 4)

bills.ts.regression_equation <- bills.ts ~ 0 + time(bills.ts) +
    bills.ts.Q1 + bills.ts.Q2 + bills.ts.Q3 + bills.ts.Q4
bills.ts.regression <- lm(bills.ts.regression_equation)

# The following tells us that all variables are significant using a
# significance level of alpha = 0.05.
summary(bills.ts.regression)

bills.ts.residuals <- residuals(bills.ts.regression)

bills.ts.regression

pdf(file="residuals_acf.png")
acf(bills.ts.residuals)
dev.off()

pdf(file="residuals_pacf.png")
pacf(bills.ts.residuals)
dev.off()