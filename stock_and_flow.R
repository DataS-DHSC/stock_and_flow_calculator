# Install packages ----

library(shiny)
library(tidyverse)

# Build app ----

ui <- fluidPage(
    titlePanel("Hospital discharge stock and flow calculator tool version 1.0"),
    numericInput(inputId = 'pre_DRD_los', 
                 label = 'Select Average pre-DRD length of stay:', 
                 value = 5, 
                 min = 0, 
                 max = 20, 
                 step = 0.5),
    numericInput(inputId = 'post_DRD_los', 
                 label = 'Select Average post-DRD length of delay (all patients):', 
                 value = 5, 
                 min = 0, 
                 max = 20, 
                 step = 0.5),
    numericInput(inputId = 'bed_occ', 
                 label = 'Select bed occupancy (%):', 
                 value = 90, 
                 min = 50, 
                 max = 100, 
                 step = 1),
    numericInput(inputId = 'ga_beds', 
                 label = 'Select G&A beds:', 
                 value = 100, 
                 min = 50, 
                 max = 2000, 
                 step = 10),
    textOutput(outputId = 'patient_stock'),
    textOutput(outputId = 'ctr_stock'),
    textOutput(outputId = 'nctr_stock'),
    textOutput(outputId = 'total_admissions'),
    textOutput(outputId = 'avg_los'),
    textOutput(outputId = 'nctr_per_bed')
    )

server <- function(input, output, session){
    patient_stock_val <- reactive({
        (input$bed_occ/100) * input$ga_beds
    })
    
    avg_los_val <- reactive({
        input$pre_DRD_los + input$post_DRD_los
    })
    
    total_admissions_val <- reactive({
        patient_stock_val() / avg_los_val()
    })
    
    ctr_stock_val <- reactive({
        total_admissions_val() * input$pre_DRD_los
    })
    
    nctr_stock_val <- reactive({
        patient_stock_val() - ctr_stock_val()
    })
    
    nctr_per_bed <- reactive({
        nctr_stock_val() / input$ga_beds
    })
    
    output$patient_stock <- renderText({
        paste0("Total admitted patient stock: ", round(patient_stock_val(), 1))
    })
    
    output$avg_los <- renderText({
        paste0("Total average length of stay: ", round(avg_los_val(), 1))
    })
    
    output$total_admissions <- renderText({
        paste0("Total admissions (Patients per day): ", round(total_admissions_val(), 1))
    })
    
    output$ctr_stock <- renderText({
        paste0("CTR stock: ", round(ctr_stock_val(), 0))
    })
    
    output$nctr_stock <- renderText({
        paste0("NCTR stock: ", round(nctr_stock_val(), 0))
    })
    
    output$nctr_per_bed <- renderText({
        paste0("NCTR per bed: ", round(nctr_per_bed(), 2))
    })
}


shinyApp(ui = ui,
         server = server)
