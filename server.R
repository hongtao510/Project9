#server.R

# load function to calculate correlation
source("calculate_cor.R")

shinyServer(function(input, output) {
    # the first plot is only generated when "Plot" button is hit
    observe({
        input$drawplot
        if (input$drawplot==0) return ()
        output$plot1 <- renderPlot({
        plot(market_correlations(input$sector, input$period, input$window)[,3], 
           main = paste("Rolling", input$period, "correlation ", input$sector, "/SPY", sep = " "))
    })
    })
})
