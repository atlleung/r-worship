#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
# library(tidyverse)
library(httr)
library(jsonlite)



# Define UI for application that draws a histogram
ui <- fluidPage(

   # Application title
   titlePanel("GCGC Worship Tracker"),

   # Sidebar with a slider input for number of bins
   sidebarLayout(
      sidebarPanel(
          h4(strong("Timer Controller")),
          actionButton("btn_prev","Previous", width = '49%'),
          actionButton("btn_next","Next", width = '49%')
      ),

      # Show a plot of the generated distribution
      mainPanel(
        wellPanel(
          h3("Service Information"),
          textInput("txt_preacher", "Preacher"),
          textInput("txt_worshipleader", "Worship Leader"),
          actionButton("btn_new", "New Service", width = '100%', style = "background-color: lightblue")

        ),
        wellPanel(fluidRow(column(12, align = "center",
                                  h4(textOutput("serviceinfo"))))),
        wellPanel(
          h3("Service Events"),
          actionButton("btn_start", "Start Service", width = '100%', style = "background-color: #3cb371"),
          h4(" "),
          wellPanel(
            textInput("txt_title", "Song Title"),
            textInput("txt_BPM", "BPM"),
            textInput("txt_comment", "Comments"),
            actionButton("btn_newsong", "New Song", width = '100%', style = "background-color: gold")
          ),
          actionButton("btn_prayer", "Prayer",width = '49%', style = "background-color: deepskyblue"),
          actionButton("btn_scripture", "Scripture",width = '49%', style = "background-color: SandyBrown"),
          h4(" "),
          actionButton("btn_sharing", "Sharing",width = '49%', style = "background-color: SandyBrown"),
          actionButton("btn_sermon", "Sermon",width = '49%', style = "background-color: deepskyblue"),
          h4(" "),
          actionButton("btn_offering", "Offering",width = '49%', style = "background-color: deepskyblue"),
          actionButton("btn_communion", "Communion",width = '49%', style = "background-color: SandyBrown"),
          h4(" "),
          actionButton("btn_dox", "Doxology",width = '49%', style = "background-color: SandyBrown"),
          actionButton("btn_announcement", "Announcements",width = '49%', style = "background-color: deepskyblue"),
          h4(" "),
          actionButton("btn_end", "End Service", width = '100%', style = "background-color: indianRed")
          )

        )
      )
   )


# Define server logic required to draw a histogram
server <- function(input, output, session) {
  url <- fromJSON("endpoints.json", flatten=TRUE)$url
  id <- NULL
  # response = GET(paste0(url, "task=prev"))
  # rsp = fromJSON(rawToChar(response$content))
  # outputText <- "Current Service Information"

  observeEvent(input$btn_prev,{
    response = GET(paste0(url, "task=prev"))
    id <<- showNotification(
      "Previous Event",
      duration = 3,
      type = "message")
    # outputText <<- paste0(outputText, "\n prev")
    # output$serviceinfo <- renderText(outputText)
  })

  observeEvent(input$btn_next,{
    response = GET(paste0(url, "task=next"))
    id <<- showNotification(
      "Next Event",
      duration = 3,
      type = "message")
    # outputText <<- paste0(outputText, "\n next")
    # output$serviceinfo <- renderText(outputText)
  })


  observeEvent(input$btn_new,{
    req_url = paste0(url,
                     "task=r-new&preacher=",input$txt_preacher,
                     "&worshipleader=",input$txt_worshipleader)
    response = GET(gsub(" ", "%20", req_url))
    rsp = fromJSON(rawToChar(response$content))
    print(rsp$message)
    id <<- showNotification(
      rsp$message,
      duration = 5,
      type = rsp$type
    )
    output$serviceinfo <- renderText("Service Ready")
  }
  )

  observeEvent(input$btn_start,{
    response = GET(paste0(url, "task=start"))
    rsp = fromJSON(rawToChar(response$content))
    print(rsp$message)
    id <<- showNotification(
      rsp$message,
      duration = 5,
      type = rsp$type
    )
    output$serviceinfo <- renderText("Service Started")
  })
  observeEvent(input$btn_newsong,{
    req_url = paste0(url,
                     "task=r-song&name=", input$txt_title,
                     "&BPM=",input$BPM,
                     "&comments=", input$comments)
    response = GET(gsub(" ", "%20", req_url))
    rsp = fromJSON(rawToChar(response$content))
    print(rsp$message)
    id <<- showNotification(
      rsp$message,
      duration = 5,
      type = rsp$type
    )
    if (rsp$type == "message") {
      updateTextInput(session, "txt_title", value = "")
      updateTextInput(session, "txt_BPM", value = "")
      updateTextInput(session, "txt_comment", value = "")
      output$serviceinfo <- renderText(input$txt_title)
    }

  })
  observeEvent(input$btn_prayer,{
    response = GET(paste0(url, "task=prayer"))
    rsp = fromJSON(rawToChar(response$content))
    print(rsp$message)
    id <<- showNotification(
      rsp$message,
      duration = 5,
      type = rsp$type
    )
    output$serviceinfo <- renderText("Prayer")
  })
  observeEvent(input$btn_scripture,{
    response = GET(paste0(url, "task=scripture"))
    rsp = fromJSON(rawToChar(response$content))
    print(rsp$message)
    id <<- showNotification(
      rsp$message,
      duration = 5,
      type = rsp$type
    )
    output$serviceinfo <- renderText("Scripture")
  })
  observeEvent(input$btn_sharing,{
    response = GET(paste0(url, "task=sharing"))
    rsp = fromJSON(rawToChar(response$content))
    print(rsp$message)
    id <<- showNotification(
      rsp$message,
      duration = 5,
      type = rsp$type
    )
    output$serviceinfo <- renderText("Sharing")
  })
  observeEvent(input$btn_sermon,{
    response = GET(paste0(url, "task=sermon"))
    rsp = fromJSON(rawToChar(response$content))
    print(rsp$message)
    id <<- showNotification(
      rsp$message,
      duration = 5,
      type = rsp$type
    )
    output$serviceinfo <- renderText("Sermon")
  })
  observeEvent(input$btn_offering,{
    response = GET(paste0(url, "task=offering"))
    rsp = fromJSON(rawToChar(response$content))
    print(rsp$message)
    id <<- showNotification(
      rsp$message,
      duration = 5,
      type = rsp$type
    )
    output$serviceinfo <- renderText("Offering")
  })
  observeEvent(input$btn_communion,{
    response = GET(paste0(url, "task=communion"))
    rsp = fromJSON(rawToChar(response$content))
    print(rsp$message)
    id <<- showNotification(
      rsp$message,
      duration = 5,
      type = rsp$type
    )
    output$serviceinfo <- renderText("Communion")
  })
  observeEvent(input$btn_dox,{
    response = GET(paste0(url, "task=dox"))
    rsp = fromJSON(rawToChar(response$content))
    print(rsp$message)
    id <<- showNotification(
      rsp$message,
      duration = 5,
      type = rsp$type
    )
    output$serviceinfo <- renderText("Doxology")
  })
  observeEvent(input$btn_announcement,{
    response = GET(paste0(url, "task=announcement"))
    rsp = fromJSON(rawToChar(response$content))
    print(rsp$message)
    id <<- showNotification(
      rsp$message,
      duration = 5,
      type = rsp$type
    )
    output$serviceinfo <- renderText("Announcements")
  })
  observeEvent(input$btn_end,{
    response = GET(paste0(url, "task=end"))
    rsp = fromJSON(rawToChar(response$content))
    print(rsp$message)
    id <<- showNotification(
      rsp$message,
      duration = 5,
      type = rsp$type
    )
    if(rsp$type == "message"){
      updateTextInput(session, "txt_preacher", value = "")
      updateTextInput(session, "txt_worshipleader", value = "")
      output$serviceinfo <- renderText("Service Ended")
    }

  })
}

# Run the application
shinyApp(ui = ui, server = server)
