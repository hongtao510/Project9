# ui.R
library(shiny)

shinyUI(fluidPage(
    fluidRow(
        column(10,
            wellPanel(style = "background:lightgrey; color:white", 
                HTML('<div><h2>
                      <span style="color: #0067AB">Market Correlation</span></h2>
                      </div>')
            ),
            fluidRow(
                column(3,
                    wellPanel(style = "background:#0067AB; color:white; border:#0067AB", 
                        selectInput("sector", "Step 1: Select a Sector ETF",
                                      c( 
                                        "Emerging Markets Index" = "EEM",
                                        "Japan Market" = "EWJ",
                                        "China Market" = "FXI",
                                        "Brazil Market" = "EWZ"
                                        )
                                      ),
                        selectInput("period", "Step 2: Select a Time Period", c("daily", "weekly", "monthly")),
                        numericInput("window", "Step 3: Select a Rolling Window", 10, min = 5, max = 50, step = 5),
                        actionButton("drawplot", tags$b(h5("Plot")))
                              )
                ),
                column(8,
                    wellPanel(style = "background:white; color:black; border:white",
                        tabsetPanel( 
                            tabPanel(tags$b(h5("Guidance")), 
                                     HTML('<br>
                                           <b style="font-size: 30px">Three steps are required to generate a correlation plot:</b>
                                           <br><br>
                                           <ul style="font-size: 20px">
                                               <li>Step 1: Select an ETF from the dropdown menu</li>
                                               <li>Step 2: Select a time period</li>
                                               <li>Step 3: Select a rolling window</li>
                                               <li>Step 4: Click the `Plot` button and wait a few seconds</li>
                                               <li>Step 5: Go to `Correlation Plot` tab</li>
                                               <li>Step 6: Switch to different markets or time frames</li>
                                            </ul>
                                            <br><br>
                                            <b style="font-size: 30px">Full name of ETFs</b>:
                                            <ul>
                                                <ul style="font-size: 20px">
                                                <li>EEM: MSCI Emerging Markets Index</li>
                                                <li>EWJ: iShares MSCI Japan ETF</li>
                                                <li>FXI: iShares FTSE/Xinhua China 25 Index ETF</li>
                                                <li>EWZ: iShares MSCI Brazil ETF</li>
                                            </ul>
                                          '
                                         )),
                            tabPanel(
                                    tags$b(h5("Correlation Plot")), 
                                    plotOutput("plot1")
                                    ) 
                                    ) 
                            )
                       )
               )
        )
    )
))








