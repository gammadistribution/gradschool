library(nlme)

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

pdf(file="residuals_acf.pdf")
acf(bills.ts.residuals)
dev.off()

pdf(file="residuals_pacf.pdf")
pacf(bills.ts.residuals)
dev.off()

# Rerun regression with correlation to ARMA(1,1) process
bills.ts.regression_correction <- gls(bills.ts.regression_equation,
                               correlation=corARMA(p=1,q=1), method="ML")

# Not all values are significant
summary(bills.ts.regression_correction)

bills.ts.regression_new_equation <- bills.ts ~ 0 + time(bills.ts) +
    bills.ts.Q1 + bills.ts.Q2 + bills.ts.Q4

bills.ts.regression_correction_2 <- gls(bills.ts.regression_new_equation,
                                        correlation=corARMA(p=1,q=1),
                                        method="ML")

# This is our time series model.
summary(bills.ts.regression_correction_2)

pdf(file="new_residuals_acf.pdf")
acf(residuals(bills.ts.regression_correction_2, type="normalized"))
dev.off()
