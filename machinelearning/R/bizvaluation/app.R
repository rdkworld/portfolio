library(shiny)
library(EnvStats)
library(RColorBrewer)

# Define UI for application that draws a histogram #
ui <- fluidPage(
  
  # Application title
  #titlePanel("Valuing Square"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      #tags$h3("Growth"),
      #sliderInput("g","Revenue Growth Next Year:",min = -0.3 ,max=1.0, value = 0.45, step=0.05),
      sliderInput("growth_next_year","Revenue Growth Next Year in %:",min = -30 ,max=100, value = 40, step=5),
      sliderInput("growth_years_2_5","Compounded Revenue Growth Years 2 to 5 in %:",min = -30 ,max=100, value = 25, step=5),
      sliderInput("growth_stable","Stable Revenue Growth in Perpetuity in %:",min = -0.5 ,max=3, value = 1.74, step=0.5),
      #tags$h3("Profitablity & Efficiency"),
      sliderInput("op_margin_next_year","Operating Margin(Pre-tax) Next Year in %:",min = -30 ,max=100, value = -15, step=5),
      sliderInput("target_op_margin","Target Stable Operating Margin(Pre-tax) in %:",min = -30 ,max=100, value = 15, step=5),
      sliderInput("capital_to_sales","Est $ Capital investment to generate $100 revenue?",min = 1 ,max=100, value = 85, step=1),
      sliderInput("cost_of_capital","Cost of Capital in %:",min = 0.1 ,max=15, value = 5.6, step=0.1),
      #sliderInput("s","No of Simulations",min = 1 ,max=100, value = 2, step=1),
      #sliderInput("bins","Number of bins:",min = 1,max = 50,value = 30),
      #sliderInput("r","Risk Free Rate:",min = -1.0,max=3.0, value = c(0.4,2.5), step=0.1)
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      #tags$h2("Your Square story"),
      tags$h3("Base Case Valuation of Coursera"),
      #"Here is your Base Case Valuation for your assumptions..",
      htmlOutput("Summary1"),
      plotOutput("barchart2", width = "100%"),
      #plotOutput("barchart3"),
      #plotOutput("barchart1"),
      #plotOutput("distPlot"),
      htmlOutput("table1"),
      verbatimTextOutput("table2"),
      plotOutput("box1", width = "100%"),
      plotOutput("fourpanel", width = "100%"),
      #dataTableOutput("table"),
      #verbatimTextOutput("valuationDF2"),
      #verbatimTextOutput("valuationDF1"),
      #plotOutput("box"),
      verbatimTextOutput("resultTitle"),
      verbatimTextOutput("result"),
      #verbatimTextOutput("valuationDF"),
      #verbatimTextOutput("stat"),
      #verbatimTextOutput("df"),
      #verbatimTextOutput("t_df"),
      #erbatimTextOutput("final"),
      #"The End"
    )
  )
)

#Triangular Function
qtria <- function(p, a, b, c) {
  if (!all(a <= c && c <= b && a < b)) next
  
  ifelse(p > 0 & p < 1,
         ifelse(p <= ptri(c, a, b, c),
                a+sqrt((a^2-a*b-(a-b)*c)*p),
                  b-sqrt(b^2-a*b+(a-b)*c+(a*b-b^2-(a-b)*c)*p)),
         NA)
}

rtria <- function(n, a, b, c) {
  if (!all(a <= c && c <= b && a < b)) next
  
  qtri(runif(n, min = 0, max = 1), a, b, c)
}


# Define server logic required to draw a histogram
server <- function(input, output) {
  

  #r <- reactive({runif(1000,input$r[1],input$r[2])})
  #r <- reactive({input$r[1]})
  #PV <-reactive({100000/(1+r())})
  #PV <-reactive({100000/(1+r())})
  
  #reactiveVector <- reactiveValues(num = c())

  ### Start
  
  #inputs
  revenues <-  293.51 #9497.58
  operating_income <- -66.58 #-18.82
  interest_expense <- 0.012 #74.10
  book_equity <- -221.82 #2681.57
  book_debt <- 26.23 #3493.40
  cash <- 79.88 #3158.06
  no_shares_outstanding <- 127.5 #471.81
  current_stock_price <- 45 #217.64
  marginal_tax_rate <- 0.25
  invested_capital <- -275 #3017
  
  #sims
  #r_sims <- reactive({input$s})
  sims1 <- 50
  sims <- sims1 + 1
  
  
  #value_drivers
  #growth_next_year <- 0.45
  #op_margin_next_year <- 0.00
  #growth_years_2_5 <- 0.15
  #target_op_margin <- 0.25
  year_of_conv <- 10
  #sales_to_capital <- 3.15
  
  #rates
  risk_free <- 0.0174
  wacc <- 0.0553
  
  r_cost_of_capital <- reactive({
    m_r_cost_of_capital <- matrix(round(rnorm(sims1,input$cost_of_capital/100,0.05),4),sims1,1)
    m_r_cost_of_capital <- rbind(m_r_cost_of_capital,c(input$cost_of_capital/100))
  })
  
  #browser()
  #Reactive
  r_growth_next_year <- reactive({input$growth_next_year/100})
   # observe({
   #  input$growth_next_year
   #   isolate({
   #     #prev <- c()
   #     prev <- reactiveValues(p=c())
   #     prev1 <- c()
   #     prev2 <- c()
   #     prev3 <- c()
   #   })
   # })

  
  #r_growth_next_year <- reactive({
  #  m_r_growth_next_year <- matrix(runif(sims,input$growth_next_year[1],input$growth_next_year[2]),sims,1)
  #  })
  #m_r_growth_next_year <- matrix(runif(5,10,100),5,1)
  
  # r_growth_years_2_5 <- reactive({runif(500,input$growth_years_2_5[1],input$growth_years_2_5[2])})
  #r_growth_years_2_5 <- reactive({input$growth_years_2_5})
  r_growth_years_2_5 <- reactive({
    m_r_growth_years_2_5 <- matrix(round(runif(sims1,input$growth_years_2_5*0.25/100,input$growth_years_2_5*1.7/100),2),sims1,1)
    m_r_growth_years_2_5 <- rbind(m_r_growth_years_2_5,c(input$growth_years_2_5/100))
  })    
  r_growth_stable <- reactive({input$growth_stable/100})
  #r_growth_stable <- reactive({runif(500,input$growth_stable[1],input$growth_stable[2])})
  
  r_op_margin_next_year <- reactive({input$op_margin_next_year/100})    
  #r_op_margin_next_year <- reactive({runif(500,input$op_margin_next_year[1],input$op_margin_next_year[2])})
  
  #r_target_op_margin <- reactive({input$target_op_margin})    
  #r_target_op_margin <- reactive({runif(500,input$target_op_margin[1],input$target_op_margin[2])})
  r_target_op_margin <- reactive({
    m_r_target_op_margin <- matrix(round(rtri(sims1,input$target_op_margin*0.25/100,input$target_op_margin*1.75/100,input$target_op_margin/100),2),sims1,1)
    m_r_target_op_margin <- rbind(m_r_target_op_margin,c(input$target_op_margin/100))
  })  
  
  #r_capital_to_sales <- reactive({input$capital_to_sales})
  #r_capital_to_sales <- reactive({runif(500,input$capital_to_sales[1],input$capital_to_sales[2])})
  r_capital_to_sales <- reactive({
    m_r_capital_to_sales <- matrix(round(rnorm(sims1,input$capital_to_sales,0.5),2),sims1,1)
    m_r_capital_to_sales <- rbind(m_r_capital_to_sales,c(input$capital_to_sales))
    
  })
  
  r_sales_to_capital <- reactive({
    m_sales_to_capital <- round(100/r_capital_to_sales(),4)
  })
  
  #browser()
  #v_r_value_share <- c()
  #rr_value_share_nr <- c()
  #browser()
  #counter <- c()
  #a.list <- list()
  
  #prev <- c()
  #prev <- reactiveValues(p=c())
  prev <- c()
  prev1 <- c()
  prev2 <- c()
  prev3 <- c()
  
  for (x in 1:sims) {
    
    #browser()

    year <- c(1,2,3,4,5,6,7,8,9,10,10)
    r_growth <- reactive ({
      growth_red <- round((r_growth_years_2_5()[x,1]-risk_free)/5,4)
      growth <- c(r_growth_next_year(), rep(r_growth_years_2_5()[x,1],4), r_growth_years_2_5()[x,1]-growth_red*1,r_growth_years_2_5()[x,1]-growth_red*2,r_growth_years_2_5()[x,1]-growth_red*3,r_growth_years_2_5()[x,1]-growth_red*4,r_growth_years_2_5()[x,1]-growth_red*5,r_growth_stable())
    })
    
    r_revenue <- reactive ({
      revenue <- round(revenues * cumprod(1+r_growth()),2)
    })
    #revenue <- round(revenues * cumprod(1+r_growth()),2)
    
    r_op_margin <- reactive ({
      margin_red <- ((r_target_op_margin()[x,1]-r_op_margin_next_year())/year_of_conv)
      op_margin <- c(r_op_margin_next_year(), r_target_op_margin()[x,1]-margin_red*(year_of_conv-2),r_target_op_margin()[x,1]-margin_red*(year_of_conv-3),r_target_op_margin()[x,1]-margin_red*(year_of_conv-4),r_target_op_margin()[x,1]-margin_red*(year_of_conv-5),r_target_op_margin()[x,1]-margin_red*(year_of_conv-6),r_target_op_margin()[x,1]-margin_red*(year_of_conv-7),r_target_op_margin()[x,1]-margin_red*(year_of_conv-8),r_target_op_margin()[x,1]-margin_red*(year_of_conv-9),r_target_op_margin()[x,1]-margin_red*(year_of_conv-10),r_target_op_margin()[x,1])
    })
    
    r_ebit <- reactive ({
      ebit <- round(r_revenue() * r_op_margin(),2)
    })
    
    tax <- rep(marginal_tax_rate,11)
    
    r_op_income <- reactive({
      op_income <- round(r_ebit() * (1-tax),2)        
    })
    
    r_wacc <- reactive ({
      wacc_red <- round((r_cost_of_capital()[x,1]-(risk_free+0.0475))/5,4)
      wacc_t <- c(rep(r_cost_of_capital()[x,1],5), r_cost_of_capital()[x,1]-wacc_red*1,r_cost_of_capital()[x,1]-wacc_red*2,r_cost_of_capital()[x,1]-wacc_red*3,r_cost_of_capital()[x,1]-wacc_red*4,r_cost_of_capital()[x,1]-wacc_red*5,risk_free+0.0475)
    })
    
    r_cum_dis_factor <- reactive ({
      cum_dis_factor <- round(cumprod(1/(1+r_wacc())),4)
    })
    
    r_reinvestment <- reactive ({
      margin_red <- ((r_target_op_margin()[x,1]-r_op_margin_next_year())/year_of_conv)
      reinvestment <- c( (r_revenue()[1]-revenues)/r_sales_to_capital()[x,1],(r_revenue()[2]-r_revenue()[1])/r_sales_to_capital()[x,1],(r_revenue()[3]-r_revenue()[2])/r_sales_to_capital()[x,1], (r_revenue()[4]-r_revenue()[3])/r_sales_to_capital()[x,1],(r_revenue()[5]-r_revenue()[4])/r_sales_to_capital()[x,1],
                         (r_revenue()[6]-r_revenue()[5])/r_sales_to_capital()[x,1],(r_revenue()[7]-r_revenue()[6])/r_sales_to_capital()[x,1],(r_revenue()[8]-r_revenue()[7])/r_sales_to_capital()[x,1],(r_revenue()[9]-r_revenue()[8])/r_sales_to_capital()[x,1],(r_revenue()[10]-r_revenue()[9])/r_sales_to_capital()[x,1],
                         (r_growth()[11]/r_wacc()[10])*r_op_income()[11] )
    })
    
    r_fcff <- reactive ({
      fcff <- round(r_op_income() - r_reinvestment(),2)  
    })
    
    r_capital <- reactive ({
      capital <-  round(invested_capital + cumsum(r_reinvestment()),2)  
    })
    
    r_roic <- reactive ({
      
      roic <- round(r_op_income()/r_capital(),4)
      
      roic[1] <- 0
      roic[2] <- 0
      roic[3] <- 0
      roic[4] <- 0
      roic[5] <- 0
      
      roic

      # for (i in 1:11) {
      #   if(r_op_income() <= 0) {
      #     roic[i] <- 0      
      #   }
      # }
    #roic[11] <- 0
    })

    
    r_roic11 <- reactive ({
      roic11 <- r_wacc()[10]
    })
    r_present_value <- reactive ({
      present_value <- round(r_fcff() * r_cum_dis_factor(),2) 
      #present_value[11] <- 0
    })
    #browser()
    r_terminal_value <- reactive ({
      terminal_value <- round(r_fcff()[11]/(r_wacc()[11]-r_growth()[11]),2)  
    })
    
    r_present_value11 <- reactive ({
      present_value11 <- round(r_terminal_value() * r_cum_dis_factor()[10],2)
    })
    
    r_sum_pv <- reactive ({
      sum_pv <- sum(r_present_value()) + r_present_value11() - r_present_value()[11]      
    })
    
    v_r_sum_pv <- reactive({
      prev2[x] <<- r_sum_pv()
      prev2
      
    })
    
    isolate({
      v_r_sum_pv()
    })
    
    r_value_equity <- reactive ({
      value_equity <- r_sum_pv() - book_debt + cash      
    })
    
    v_r_value_equity <- reactive({
      if (x == 1) {
        prev <- c()
        prev1 <- c()
        prev2 <- c()
        prev3 <- c()
      }
      prev1[x] <<- r_value_equity()
      prev1
      
    })
    
    isolate({
      v_r_value_equity()
    })
    
    
    r_value_share <- reactive ({
      value_share <- round(r_value_equity() / no_shares_outstanding,2)      
    })   
    
    #v_r_value_share <- reactive({
    #  v_value_share <- r_value_share() * 1
    #  })
    #browser()
    
    #memory <- reactiveValues(dat=NULL)
    #xvals = v_r_value_share
    #yvals = x
    
    # v_r_value_share <- reactive({
    #   isolate(dat <- memory$dat)
    #   if(is.null(dat)){
    #     memory$dat <- data.frame(v_r_value_share = r_value_share())
    #   } else {
    #     memory$dat <- data.frame( c(dat,r_value_share()) )       
    #   }
    #   return(memory$dat)
    #   
    # })
    
    #v_r_value_share <- reactive ({
    #  return(rr_value_share_nr)      
    #}) 
    #browser()
    #observe({
    #  v_r_value_share()
    #  rr_value_share_nr <- c(rr_value_share_nr,r_value_share())
    #})
    
    #v_r_value_share <- reactive ({
    #  vector <- c(v_r_value_share(), r_value_share())
    #  return(vector)
    #})
    #browser()
    
    #v_r_value_share <- reactive ({
    #  #a.new <- runif(10,100,200)
    #  a.new <- r_value_share()
    #  a.list <- c(a.list, a.new)
    #  a.list
    
    #v_r_value_share <- a.list 
    #v_r_value_share
    #})
    
    #counter <- reactiveValues(countervalue=0)
    #counter$countervalue <- paste0("counter$",countervalue,r_value_share())
    #counter <- c(counter, r_value_share())
    #counter <- reactive({ c(counter,r_value_share()) })
    #counter <- reactiveValues(countervalue = 0)
    #  reactive({
    #    counter$countervalue = c(counter$countervalue,r_value_share())
    #  })
    
    # #browser()
    #if (x == 1) {
    #  v_r_value_share <- reactive({r_value_share()})
    #}

    #if (x > 1) {
    #  v_r_value_share <- reactive({c(v_r_value_share, r_value_share())})
    #}
    #browser()
    
    v_r_value_share <- reactive({
      #test <<- c(prev, r_value_share())
      #prev <<- test
      #prev[x] <<- r_value_share()
      #prev
      prev$p[x] <<- r_value_share()
      prev$p
      
    })
    
    isolate({
      v_r_value_share()
    })
    #dummy <- reactive({v_r_value_share()})
    #browser()
    #v_r_value_share <- reactive({
    #  m <- r_value_share()
      #x
      #isolate({
      #  reactiveVector$num <- c(reactiveVector$num, as.numeric(m))
      #  return(reactiveVector$num) 
      #})
      #m[x] <- r_value_share()
      #n <- c(n, r_value_share())
      
    #})
    
    #v_r_value_share <- reactive ({
    #  isolate ({
    #  reactiveVector$num <- c(reactiveVector$num, as.numeric(r_value_share()))
    #  return(reactiveVector$num) 
    #  })
    # })
    
    #v_r_value_share <- reactive ({
    # observe({
    #   input$s
    #   isolate({
    #     reactiveVector$num <- c(reactiveVector$num, as.numeric(r_value_share()))
    #     return(reactiveVector$num) 
    #   })
    # 
    # })
    #browser()
    r_price_as_value <- reactive ({
      price_as_value = current_stock_price/r_value_share()      
    })
    
    v_r_price_as_value <- reactive({
      prev3[x] <<- r_price_as_value()
      prev3
      
    })
    
    isolate({
      v_r_price_as_value()
    })
    
    #valuationDF <- reactive({
    #  data.frame(RiskFreeRate=r(), PresentValue=PV())
    #})
    #output$box<-renderPlot({
    #  hist(PV(),main="Histogram of Present Value ", xlab="PV")
    #})
    
    
    #output$valuationDF <-renderPrint({head(valuationDF())})
    
    #output$valuationDF1 <-renderPrint({valuationDF1()})  
    output$valuationDF2 <-renderPrint({valuationDF2()}) 
    
    # valuationDF1 <- reactive({
    #   data.frame(Growth=r_growth(), Revenues=r_revenue(), "OpMargins"=r_op_margin(),EBIT=r_ebit(),Tax=tax,OpIncome = r_op_income(), WACC = r_wacc(), CDF=r_cum_dis_factor(), Reinvesment = r_reinvestment(), FCFF=r_fcff(), CapitalInv= r_capital(), ROIC = r_roic(), PV = r_present_value(), TV = r_terminal_value())
    # })
    #valuationDF2 <- reactive({
    #  data.frame("Sum of Present Value"=r_sum_pv(), "Value of Equity"=r_value_equity(), "Value Per Share"=r_value_share(),"Price as % of Value" = r_price_as_value())
    #})
    #output$final <- renderText(rbind(r_sum_pv(),r_value_equity(),r_value_share(),r_price_as_value()))
    
    output$Summary1 <- renderUI({ 
      str1 <- paste("Value of Equity",HTML('&nbsp;'),HTML('&nbsp;'),HTML('&nbsp;'),HTML('&nbsp;'),HTML('&nbsp;'),HTML('&nbsp;'),HTML('&nbsp;'),HTML('&nbsp;'),HTML('&nbsp;'),HTML('&thinsp;'),": <strong>$",round(r_value_equity()/1000,1)," Billion","</strong>","<br/>")
      str2 <- paste("Estimated Value Per Share",": <strong>$", round(r_value_share(),2),"</strong>")
      HTML(paste("<h5>",str1,str2,"</h5>", sep = '<br/>'))
    })
    
  } #End of For Loop
  #browser()   
  
  M2 <- c("Now","Year 1","Year 2","Year 3")
  output$barchart2 <- renderPlot ({
    par(mfrow=c(1,2))
    C2 <- c(round(r_value_share(),2), round(r_value_share()*((1+r_wacc()[1])^1),2), round(r_value_share()*((1+r_wacc()[2])^2),2), round(r_value_share()*((1+r_wacc()[3])^3),2))
    y <- barplot(C2,names.arg=M2,xlab="Fair Estimate in $",ylab="Timeline",col="#428bca",font.lab=2,space=c(1,1,1,1),main="Fair Value Estimate for Next 3 Years", horiz=TRUE, border = "white", xlim=range(pretty(c(0, C2+1)))) #xlim=c(0,500),
    #title("Fair Value Estimate for Next 3 Years", line = 0.5)
    #x <- C2
    text(C2, y, pos=4, labels=as.character(paste("$",C2,sep=""))) 
    abline(v=r_value_share(),col='#d32d41', lty=5, lwd=3)
    text(r_value_share(),4.5,"Base Case") #4.93
    
    #Moved to here
    hist(as.numeric(v_r_value_share()),breaks=20,main="Monte Carlo Simulation of Value Per Share", xlab="Value Per Share in $", ylab = "Probability", col='#d32d41',font.lab=2, border = "white",freq = FALSE) #, 
    abline(v=r_value_share(),col='#428bca', lty=5, lwd=3)
    text(r_value_share(),2,"Base Case")
    #hist(vv_r_value_share(),breaks=20,main="Histogram of Value Per Share ", xlab="Value Per Share")
  })
  #browser()
  #output$barchart3 <- renderPlot ({
    #par(mfrow=c(1,2))
    #moved from here
  #})
  
  #output$barchart1 <- renderPlot ({
  #})
  #browser()
  output$table1 <- renderUI({ 
    str1 <- paste("Percentile of Value Per Share after ", sims1, " simulations")
    HTML(paste("<b>",str1,"</b>", sep = '<br/>'))
    #quantile(v_r_value_share(),2, probs= seq(0.1, 1.0, by=0.1))
  })
  
  output$table2 <- renderPrint({ 
    #"Percentile"
    quantile(v_r_value_share(),2, probs= seq(0.1, 1.0, by=0.1))
    #z <- quantile(v_r_value_share(),2, probs= seq(0.1, 1.0, by=0.1))
    #data.frame(id = names(z), values = unname(z), stringsAsFactors = FALSE)
  })
  
  output$box1<-renderPlot({
    #moved from here
    #v_r_value_share()
    par(mfrow=c(1,2))
    M <- c("2021","2022","2023","2024","2025","2026","2027","2028","2029","2030","2031")
    x <- barplot(r_revenue(),names.arg=M,xlab="Year",ylab="Revenue",font.lab=2,col="#428bca", border = "white",main="Estimated Revenue in $ & Operating Margin in %", ylim=range(pretty(c(0, r_revenue()*1.15)))  ) #ylim = c(0,35000),
    text(x, r_revenue(), pos = 3, labels=as.character(paste(round(r_revenue()/1000,1),"B",sep="")), cex=0.8) 
    #title("Estimated Revenue in $ & Operating Margin in %", line = 2)
    par(new = TRUE)
    plot(r_op_margin()*100,type = "l", axes=FALSE, xlab="",ylab="", col = "#d32d41", lwd=2,ylim=range(pretty(c(0, r_op_margin()*100+5))) ) #ylim=c(0,40)
    axis(side = 4, at = pretty(range(r_op_margin()*100)))
    mtext(expression(bold("Operating Margin %")), side = 4, line = 0)
    
    M <- c("2021","2022","2023","2024","2025","2026","2027","2028","2029","2030","2031")
    data1 <- t(data.frame(r_fcff(),r_reinvestment())) #11 elements
    colnames(data1) <- c("2021","2022","2023","2024","2025","2026","2027","2028","2029","2030","2031")
    rownames(data1) <- c("FCFF","Reinvestments")
    barplot(height=as.matrix(data1),xlab="Year",font.lab=2,ylab="FCFF & Reinvestment in $",col=c("#d32d41","#428bca"), main="FCFF/Reinvestments in $ & ROIC/WACC in %", beside=TRUE, border = "white",ylim=range(pretty(c(-r_fcff()*1.15, r_fcff()*1.15))))
    #legend("topleft",rownames(data1),cex=1.0,bty="n", fill=c("blue","yellow"))
    #, legend=rownames(data1)
    par(new = TRUE)
    plot(r_roic()*100,type = "l", axes=FALSE, xlab="",ylab="", col = "black", lwd=1)
    lines(r_wacc()*100,col = "red", lwd=1)
    axis(side = 4, at = pretty(range(r_roic()*100)))
    mtext(expression(bold("ROIC & WACC %")), side = 4, line = 0)
    legend("topleft",c("FCFF","Reinvestments","ROIC","WACC"),bty="n", fill=c("#d32d41","#428bca","black","red"), cex=0.8) #horiz = TRUE, 
    
  })
  
  output$fourpanel <- renderPlot({
    par(mfrow=c(2,2))
    #hist(r_growth_next_year(),main="Distribution of Growth Next Year", xlab="Revenue Growth Next Year", breaks=20, col="blue")
    #plot(density(r_growth_next_year()),main="Distribution of Growth Next Year")
    #polygon(density(r_growth_next_year()),col="blue")
    
    
    plot(density(r_growth_years_2_5()),main="Distribution of Growth Years 2-5",xlab="Variability in Growth Years 2-5")
    polygon(density(r_growth_years_2_5()),col="#e3ebf6", border = "white")
    
    plot(density(r_target_op_margin()),main="Distribution of Target Operating Margin",xlab="Variability in Target Operating Margin")
    polygon(density(r_target_op_margin()),col="#fedfdd", border = "white")
    
    #hist(r_growth_years_2_5(),main="Distribution of Growth Next Year", xlab="Revenue Growth Next Year", breaks=20, col="red")
    
    plot(density(r_capital_to_sales()),main="Distribution of Capital to Sales")
    polygon(density(r_capital_to_sales()),col="#e3ebf6", border = "white",xlab="Variability in Capital to Sales")
    
    #hist(r_growth_years_2_5(),main="Distribution of Growth Next Year", xlab="Revenue Growth Next Year", breaks=20, col="green")
    
    plot(density(r_cost_of_capital()),main="Distribution of Cost of Capital")
    polygon(density(r_cost_of_capital()),col="#fedfdd", border = "white",xlab="Variability in Cost of Capital")
    
    #hist(r_growth_years_2_5(),main="Distribution of Growth Next Year", xlab="Revenue Growth Next Year", breaks=20, col="purple")
  })
  #browser()

  
}

# Run the application 
shinyApp(ui = ui, server = server)


# library(Quandl)
# Quandl("FRED/WGS10YR")
# new <- c()
# for(i in 1:11) {
#   if(i==1) {
#     new <- c(r_growth_next_year())
#   } else if (i %in% 2:5) {
#     new <- c(new,r_growth_years_2_5())
#   } else if (i %in% 6:10){
#     new <- c(new, r_growth_years_2_5()-((r_growth_years_2_5()-risk_free/5)*(i-5)))
#   } else {
#     new <- c(new, risk_free)
#   }
# }
#g <- reactive({input$g})
#browser()
#v <- reactiveValues(value = 0)
#newEntry <- observeEvent(input$growth_next_year, { 

#observeEvent(input$growth_next_year, {
#browser()


# growth <- c()
#   for(i in 1:11) {
#     if(i==1) {
#       growth <- c(growth, r_growth_next_year())
#       #v_value <- paste(growth,r_growth_next_year())
#     } else if (i %in% 2:5) {
#       growth <- c(growth,growth_years_2_5)
#     } else if (i %in% 6:10){
#       growth <- c(growth, growth_years_2_5-((growth_years_2_5-risk_free)/5)*(i-5))
#     } else {
#       growth <- c(growth, risk_free)
#     }
#   }
#   
#})
#growth[1] <- g_next_year()

#v$value <- paste0(g_next_year)
#newObj <- paste0(g_next_year)

#year <- reactive({c(1,2,3,4,5,6,7,8,9,10,10)})
#growth <- reactive({rep(input$g, 12)})
#r_growth_next_year <- reactive({input$growth_next_year})
#r_growth_next_year <- input$growth_next_year

#browser()
#vals <- reactiveValues()
#observe({
#  vals$growth_next_year <- input$growth_next_year
#})
#values$a <- input$growth_next_year
#browser()
#dummy <- reactive({ 

# op_margin <- c()
# for(i in 1:11) {
#   if(i==1) {
#     op_margin <- round(c(op_margin,op_margin_next_year),4)
#   } else if (i %in% 2:year_of_conv) {
#     op_margin <- round(c(op_margin,target_op_margin-((target_op_margin-op_margin_next_year)/year_of_conv)*(year_of_conv-i)),4)
#   } else if (i %in% year_of_conv+1:10){
#     op_margin <- round(c(op_margin, target_op_margin),4)
#   } else {
#     op_margin <- round(c(op_margin, target_op_margin),4)
#   }
# }

# ri <- c()
# for(i in 1:11) {
#   if(i %in% 1:5) {
#     ri <- round(c(ri,wacc),5)
#   } else if (i %in% 6:10) {
#     ri <- round(c(ri,wacc-((wacc-(risk_free+0.0475))/5)*(i-5)),5)
#   } else {
#     ri <- round(c(ri, risk_free+0.0475),5)
#   }
# }

#cum_dis_factor <- round(cumprod((1/(1+r))),4)  
#cum_dis_factor[11] <- ''

# reinvestment <- c()
# for(i in 1:11) {
#   if(i==1) {
#     reinvestment <- round(c(reinvestment,(r_revenue()[i]-revenues)/sales_to_capital),2)
#   } else if (i %in% 2:10) {
#     reinvestment <- round(c(reinvestment,(r_revenue()[i]-r_revenue()[i-1])/sales_to_capital),2)
#   } else {
#     reinvestment <- round(c(reinvestment,(r_growth()[11]/r_wacc()[10])*r_op_income()[11]),2)
#   }
# }

#capital[11] <- ''


#growth <- reactive({c(g(),rep(growth_years_2_5,10))})
#revenue <- reactive({seq(0, 0, length.out = 11)})
#revenue[1] <- 100 1
#revenue <- reactive({revenue[1]*cumprod(growth())})

#growth <- reactive(c(NA,rep(g(),11)))
#dcfdata <- data.frame(growth)
#dcfdata <- rbind(growth)
#output$df <- renderPrint({head(growth)})
### End     

#GrowthNextYear=r_growth_next_year, class=class(r_growth_next_year)

#df <- reactive({
#  data.frame(Year=year(), Growth=growth(), Revenue = revenue())
#})

#t_df <- reactive({
#  as.data.frame(t(as.matrix(df())))
#})

#output$distPlot <- renderPlot({
# generate bins based on input$bins from ui.R
#   x    <- faithful[, 2]
#   bins <- seq(min(x), max(x), length.out = input$bins + 1)

#  hist(x, breaks = bins, col = 'darkgray', border = 'white')
#})

#output$df <-renderPrint({df()})
#output$t_df <-renderPrint({t_df()})
#output$stat <-renderPrint({summary(valuationDF())})

#output$result1 <- renderText(rbind(year,r_growth(),r_revenue(),r_op_margin(), ebit, tax, r_op_income(), r_wacc(), r_cum_dis_factor(), r_reinvestment(), fcff, capital, roic, r_present_value(), sep="\n")) 
#output$resultTitle <- renderText(rbind("Year Growth % Revenue Operating Margin EBIT Tax, Operating Income WACC Cum Dis Factor Reinvesment FCFF Capital ROIC PV",sep="\n"))
#output$result <- renderText(rbind(year,r_growth(),r_revenue(),r_op_margin(), ebit, tax, r_op_income(), r_wacc(), r_cum_dis_factor(), r_reinvestment(), fcff, capital, roic, r_present_value(), sep="\n"))


