# example from http://shiny.rstudio.com/gallery/kmeans-example.html

library(shiny)

palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3", "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))

# Define server logic required to generate and plot a random distribution
shinyServer(function(input, output, session) {

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

})
