library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    headerPanel("Dice game"),
    sidebarPanel(
      selectInput("myguess", "My guess:",
                  list("1" = 1,
                       "2" = 2,
                       "3" = 3,
                       "4" = 4,
                       "5" = 5,
                       "6" = 6),
                  "1"),
      
      selectInput("roll", "Actual roll:",
                  list("1" = 1,
                       "2" = 2,
                       "3" = 3,
                       "4" = 4,
                       "5" = 5,
                       "6" = 6),
                  "1"),
      
      actionButton("goButton", "Click here if you're sure"),
      #   submitButton("Let's go!"),
      wellPanel(
        p(strong("Show me the money!")),
        checkboxInput(inputId = "plots_tick", label = "aka click here", value = F)
      )
    ),
    mainPanel(
      conditionalPanel(condition = "input.plots_tick",
                       br(),
                       h3(textOutput(outputId = "caption"))),
      conditionalPanel(condition = "input.plots_tick",
                       br(),
                       h3(textOutput(outputId = "outk"))),
      conditionalPanel(condition = "input.plots_tick",
                       br(),
                       div(plotOutput(outputId = "guesshist"))),
      conditionalPanel(condition = "input.plots_tick",
                       br(),
                       div(plotOutput(outputId = "rollhist")))
    )

)
#end ui

shinyServer(function(input, output) {
  guessesRolls <- reactiveValues(
    allguesses = c(),
    allrolls = c()   
  )
  
  formulaText <- reactive({
    paste("You guessed ", input$myguess, ", and you rolled a ", input$roll, sep="")
  })
  
  formulaText2 <- reactive({
    paste("You are guesser number ", input$goButton+1, sep="")
  })
  
  
  observe({
    input$myguess
    isolate({
      guessesRolls$allguesses <- c(guessesRolls$allguesses, as.numeric(input$myguess))
      return(guessesRolls$allguesses)  
    })
  })
  
  rollInput <- reactive({
    input$roll
    isolate({
      guessesRolls$allrolls <<- c(guessesRolls$allrolls, as.numeric(input$roll))
      return(guessesRolls$allrolls)
    })
  })
  
  output$caption <- renderText({
    formulaText()
  })
  output$outk <- renderText({
    formulaText2()
  })
  
  output$guesshist <- renderPlot({
    hist(as.numeric(guessesRolls$allguesses), main="Everyone's guesses so far", xlab="",col=4,    
         breaks=c(seq(0.5, 6.5, by=1)),axes=F,ylab="Frequency", cex.main=2, cex.lab=1.25)
    axis(side=1, at=c(1:6), cex.axis=2)
    axis(side=2)
    
  })
  
  output$rollhist <- renderPlot({
    input$roll
    hist(as.numeric(rollInput()), main="Everyone's rolls so far", xlab="", cex.main=2,col=3,
         breaks=c(seq(0.5, 6.5, by=1)),axes=F,ylab="Frequency", cex.main=2, cex.lab=1.25)
    axis(side=1, at=c(1:6), cex.axis=2)
    axis(side=2)
  })
})