
library(prophet)
library(zoo)

# EuStockMarkets contains weekday data
# Create proper business dates
start_date <- as.Date("1991-07-01")
end_date <- start_date + nrow(EuStockMarkets) * 7/5 # Approximate end
dates <- seq(start_date, end_date, by="day")

# Keep only business days (Monday to Friday)
dates <- dates[!weekdays(dates) %in% c("Saturday", "Sunday")]
dates <- dates[1:nrow(EuStockMarkets)]

# Convert EuStockMarkets to a data frame
eu_stocks <- as.data.frame(EuStockMarkets)

# Prepare dataframe for Prophet
EuStocksMarkets.df <- data.frame(
    ds = dates,
    y = eu_stocks$FTSE
)

m <- prophet::prophet(EuStocksMarkets.df)
f <- prophet::make_future_dataframe(m, periods=8, freq="week")
p <- predict(m, f)

# Plotting the forecast
plot(m, p)

# Plotting trend and seasonal components
prophet::prophet_plot_components(m, p)

