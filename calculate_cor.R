# function used to calculate between markets

library(quantmod)
library(dplyr)

market_correlations <- function(sector, period = "weekly", window = 10) {
    # Make a data frame of the sector and SP500 ETF.
    etf_ticker_sector <- data_frame(c(sector, "SPY"))
    colnames(etf_ticker_sector) <- "tickers"

    # Use getSymbols and Ad to get adjusted prices.
    symbols <- getSymbols(etf_ticker_sector$tickers, auto.assign = TRUE, warnings = FALSE)
    etf_prices <- do.call(merge, lapply(symbols, function(x) Ad(get(x))))

    # We want log returns by the period chosen by the user. 
    etf_returns <- do.call(merge, lapply(etf_prices, 
                                         function(x) periodReturn(x, period = period, type = 'log')))

    # Create one xts object we can pass to rollapply.
    merged_xts <- merge(etf_returns[, 1], etf_returns[, 2])
    merged_xts$rolling_cor <- rollapply(merged_xts, window, 
                                             function(x) cor(x[, 1], x[, 2], use = "pairwise.complete.obs"), 
                                             by.column = FALSE)
    # We care about the name because it will be displayed in the plot.
    names(merged_xts) <- c(paste(sector, "Returns", sep = ""), "SPY Returns", paste(sector, "/SPY Correlation", sep = ""))
    assign("sector_correlations", merged_xts, .GlobalEnv)
}

