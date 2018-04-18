
library(shiny)

shinyUI(
  fluidPage(

     # Application title
     titlePanel("GCGC Worship Tracker"),

     # Sidebar with a slider input for number of bins
     sidebarLayout(
        sidebarPanel(
          wellPanel(textInput("txt_verify", "Verification"),
                    actionButton("btn_verify", "Verify",width = '100%', style = "background-color: lightblue"),
                    fluidRow(column(12, align = "center",
                                    h4(textOutput("verifyinfo"))))
                    ),
          wellPanel(
              h4(strong("Timer Controller")),
              actionButton("btn_prev","Previous", width = '49%'),
              actionButton("btn_next","Next", width = '49%')
            )
            
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
)
