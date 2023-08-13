LA_pm2_5_ts <- ts(pm2.5_LA$PM2.5.AQI.Value, start = c(1999,3,1), frequency = 365.25)

LA_pm2_5_df <- as.data.frame(LA_pm2_5_ts)
LA_pm2_5_df$Date <- mdy(pm2.5_LA$Date)
colnames(LA_pm2_5_df) <- c("PM2.5.AQI.Value", "Date")

LA_pm2_5_xts <- as.xts(LA_pm2_5_df, order.by=LA_pm2_5_df$Date)
LA_pm2_5_xts <- LA_pm2_5_xts[,-2]
LA_pm2_5_weekly <- apply.weekly(LA_pm2_5_xts, mean)

LA_pm2_5_weekly_ts <- ts(LA_pm2_5_weekly["19990103/20230805"], start = c(1999,1),frequency = 52.18)
plot(LA_pm2_5_weekly_ts)

# Create the training dataset: from start to 2020
train <- window(LA_pm2_5_weekly_ts, start = c(1999, 1), end = c(2019, 52))  # assuming 52 weeks in 2020

# Create the test dataset: from the start of 2020 onwards
test <- window(LA_pm2_5_weekly_ts, start = c(2020, 1))

plot(train, main = "Training Data")
plot(test, main = "Testing Data")
