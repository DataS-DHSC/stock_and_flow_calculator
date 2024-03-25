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
    output$patient_stock <-  renderText({
        patient_stock_val <- (input$bed_occ/100) * input$ga_beds
        paste0("Total admitted patient stock: ",
               patient_stock_val)
    })
    output$avg_los <-  renderText({
        avg_los_val <- input$pre_DRD_los + input$post_DRD_los
        paste0("Total average length of stay: ",
               avg_los_val)
    })
    output$total_admissions <-  renderText({
        total_admissions_val <- patient_stock_val / avg_los_val
        paste0("Total admissions (Patients per day): ",
               total_admissions_val)
    })
    output$ctr_stock <-  renderText({
        ctr_stock_val <- total_admissions_val * input$pre_DRD_los
        paste0("CTR stock: ",
               ctr_stock_val)
    })
    output$nctr_stock <-  renderText({
        nctr_stock_val <- patient_stock_val - ctr_stock_val
        paste0("NCTR stock: ",
               nctr_stock_val)
    })
    output$nctr_per_bed <-  renderText({
        nctr_per_bed_val <- nctr_stock_val / input$ga_beds
        paste0("NCTR per bed: ",
               nctr_per_bed_val)
    })
}


shinyApp(ui = ui,
         server = server)
