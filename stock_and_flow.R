# Install packages ----

library(shiny)
library(tidyverse)

# Build app ----

ui <- fluidPage(
    titlePanel("Hospital discharge stock and flow calculator tool version 1.0"),
    sidebarPanel(
        selectInput(inputId = 'test', label = 'Select ***', choices = c(0,1,2))
        ),
    mainPanel(
        tabsetPanel(
            tabPanel('Calculator',
                     h2("Inputs:"),
                     numericInput(inputId = 'pre_DRD_los_in', 
                                  label = 'Select average pre-DRD length of stay:', 
                                  value = NA, 
                                  min = 0, 
                                  max = 20, 
                                  step = 0.5),
                     numericInput(inputId = 'post_DRD_los_in', 
                                  label = 'Select average post-DRD length of delay (all patients):', 
                                  value = NA, 
                                  min = 0, 
                                  max = 20, 
                                  step = 0.5),
                     numericInput(inputId = 'bed_occ_in', 
                                  label = 'Select bed occupancy (%):', 
                                  value = NA, 
                                  min = 50, 
                                  max = 100, 
                                  step = 1),
                     numericInput(inputId = 'ga_beds_in', 
                                  label = 'Select G&A beds:', 
                                  value = NA, 
                                  min = 50, 
                                  max = 2000, 
                                  step = 10),
                     numericInput(inputId = 'nctr_per_bed_in', 
                                  label = 'Select NCTR per bed:', 
                                  value = NA, 
                                  min = 0, 
                                  max = 1, 
                                  step = 0.01),
                     numericInput(inputId = 'total_admissions_in', 
                                  label = 'Select total admissions:', 
                                  value = NA, 
                                  min = 0, 
                                  max = 1000, 
                                  step = 5),
                     h2("Ouputs:"),
                     strong(textOutput(outputId = 'patient_stock_out')),
                     strong(textOutput(outputId = 'ctr_stock_out')),
                     strong(textOutput(outputId = 'nctr_stock_out')),
                     strong(textOutput(outputId = 'total_admissions_out')),
                     strong(textOutput(outputId = 'avg_los_out')),
                     strong(textOutput(outputId = 'nctr_per_bed_out')),
                     strong(textOutput(outputId = 'pre_DRD_los_out')),
                     strong(textOutput(outputId = 'post_DRD_los_out')),
            ),
            tabPanel('Length of delay calculator',
                )
            )
        )
    )

server <- function(input, output, session){
    
    #calculator A
    nctr_per_bed_val <- reactive({ifelse(is.na(input$nctr_per_bed_in),
                                     nctr_stock_val() / input$ga_beds_in,
                                     input$nctr_per_bed_in)})
    #calculator B
    pre_DRD_los_val <- reactive({ifelse(is.na(input$pre_DRD_los_in),
                                        avg_los_val() - input$post_DRD_los_in,
                                        input$pre_DRD_los_in)})
    #calculator C
    post_DRD_los_val <- reactive({ifelse(is.na(input$post_DRD_los_in),
                                         nctr_stock_val() / total_admissions_val(),
                                         input$post_DRD_los_in)})
        
    patient_stock_val <- reactive({
        (input$bed_occ_in/100) * input$ga_beds_in
    })
    
    avg_los_val <- reactive({
        input$pre_DRD_los_in + input$post_DRD_los_in
    })
    
    total_admissions_val <- reactive({
        patient_stock_val() / avg_los_val()
    })
    
    ctr_stock_val <- reactive({
        total_admissions_val() * input$pre_DRD_los_in
    })
    
    nctr_stock_val <- reactive({
        patient_stock_val() - ctr_stock_val()
    })
    
    output$patient_stock_out <- renderText({
        paste0("Total admitted patient stock: ", round(patient_stock_val(), 1))
    })
    
    output$avg_los_out <- renderText({
        paste0("Total average length of stay: ", round(avg_los_val(), 1))
    })
    
    output$total_admissions_out <- renderText({
        paste0("Total admissions (Patients per day): ", round(total_admissions_val(), 1))
    })
    
    output$ctr_stock_out <- renderText({
        paste0("CTR stock: ", round(ctr_stock_val(), 0))
    })
    
    output$nctr_stock_out <- renderText({
        paste0("NCTR stock: ", round(nctr_stock_val(), 0))
    })
    
    output$nctr_per_bed_out <- renderText({
        paste0("NCTR per bed: ", round(nctr_per_bed_val(), 2))
    })
    
    output$pre_DRD_los_out <- renderText({
        paste0("Average pre-DRD length of stay: ", round(pre_DRD_los_val(), 1))
    })
    
    output$post_DRD_los_out <- renderText({
        paste0("Average post-DRD length of stay: ", round(post_DRD_los_val(), 1))
    })
}


shinyApp(ui = ui,
         server = server)
