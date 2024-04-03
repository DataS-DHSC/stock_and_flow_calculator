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
            #Calculator A UI ----
            tabPanel('Calculator A',
                     h2("Inputs:"),
                     numericInput(inputId = 'ca_pre_DRD_los_in', 
                                  label = 'Select average pre-DRD length of stay:', 
                                  value = NA, 
                                  min = 0, 
                                  max = 20, 
                                  step = 0.5),
                     numericInput(inputId = 'ca_post_DRD_los_in', 
                                  label = 'Select average post-DRD length of delay (all patients):', 
                                  value = NA, 
                                  min = 0, 
                                  max = 20, 
                                  step = 0.5),
                     numericInput(inputId = 'ca_bed_occ_in', 
                                  label = 'Select bed occupancy (%):', 
                                  value = NA, 
                                  min = 50, 
                                  max = 100, 
                                  step = 1),
                     numericInput(inputId = 'ca_ga_beds_in', 
                                  label = 'Select G&A beds:', 
                                  value = NA, 
                                  min = 50, 
                                  max = 2000, 
                                  step = 10),
                     h2("Ouputs:"),
                     strong(textOutput(outputId = 'ca_patient_stock_out')),
                     strong(textOutput(outputId = 'ca_ctr_stock_out')),
                     strong(textOutput(outputId = 'ca_nctr_stock_out')),
                     strong(textOutput(outputId = 'ca_total_admissions_out')),
                     strong(textOutput(outputId = 'ca_avg_los_out')),
                     strong(textOutput(outputId = 'ca_nctr_per_bed_out')),
            ),
            #Calculator B UI ----
            tabPanel('Calculator B',
                     numericInput(inputId = 'cb_nctr_per_bed_in', 
                                  label = 'Select NCTR per bed:', 
                                  value = NA, 
                                  min = 0, 
                                  max = 1, 
                                  step = 0.01),
                     numericInput(inputId = 'cb_post_DRD_los_in', 
                                  label = 'Select average post-DRD length of delay (all patients):', 
                                  value = NA, 
                                  min = 0, 
                                  max = 20, 
                                  step = 0.5),
                     numericInput(inputId = 'cb_bed_occ_in', 
                                  label = 'Select bed occupancy (%):', 
                                  value = NA, 
                                  min = 50, 
                                  max = 100, 
                                  step = 1),
                     numericInput(inputId = 'cb_ga_beds_in', 
                                  label = 'Select G&A beds:', 
                                  value = NA, 
                                  min = 50, 
                                  max = 2000, 
                                  step = 10),
                     h2("Ouputs:"),
                     strong(textOutput(outputId = 'cb_patient_stock_out')),
                     strong(textOutput(outputId = 'cb_ctr_stock_out')),
                     strong(textOutput(outputId = 'cb_nctr_stock_out')),
                     strong(textOutput(outputId = 'cb_total_admissions_out')),
                     strong(textOutput(outputId = 'cb_pre_DRD_los_out')),
                     strong(textOutput(outputId = 'cb_avg_los_out'))
                ),
            #Calculator C UI ----
            tabPanel('Calculator C',
                     numericInput(inputId = 'cc_nctr_per_bed_in', 
                                  label = 'Select NCTR per bed:', 
                                  value = NA, 
                                  min = 0, 
                                  max = 1, 
                                  step = 0.01),
                     numericInput(inputId = 'cc_pre_DRD_los_in', 
                                  label = 'Select average pre-DRD length of stay:', 
                                  value = NA, 
                                  min = 0, 
                                  max = 20, 
                                  step = 0.5),
                     numericInput(inputId = 'cc_bed_occ_in', 
                                  label = 'Select bed occupancy (%):', 
                                  value = NA, 
                                  min = 50, 
                                  max = 100, 
                                  step = 1),
                     numericInput(inputId = 'cc_ga_beds_in', 
                                  label = 'Select G&A beds:', 
                                  value = NA, 
                                  min = 50, 
                                  max = 2000, 
                                  step = 10),
                     h2("Ouputs:"),
                     strong(textOutput(outputId = 'cc_patient_stock_out')),
                     strong(textOutput(outputId = 'cc_ctr_stock_out')),
                     strong(textOutput(outputId = 'cc_nctr_stock_out')),
                     strong(textOutput(outputId = 'cc_total_admissions_out')),
                     strong(textOutput(outputId = 'cc_post_DRD_los_out')),
                     strong(textOutput(outputId = 'cc_avg_los_out'))
                     
                     ),
            # #Calculator D UI ----
            # tabPanel('Calculator D',
            #          numericInput(inputId = 'cd_post_DRD_los_in', 
            #                       label = 'Select average post-DRD length of delay (all patients):', 
            #                       value = NA, 
            #                       min = 0, 
            #                       max = 20, 
            #                       step = 0.5),
            #          numericInput(inputId = 'cd_total_admissions_in', 
            #                       label = 'Select total admissions:', 
            #                       value = NA, 
            #                       min = 0, 
            #                       max = 1000, 
            #                       step = 5)),
            #         numericInput(inputId = 'cd_bed_occ_in', 
            #                      label = 'Select bed occupancy (%):', 
            #                      value = NA, 
            #                      min = 50, 
            #                      max = 100, 
            #                      step = 1),
            #         numericInput(inputId = 'cd_ga_beds_in', 
            #                      label = 'Select G&A beds:', 
            #                      value = NA, 
            #                      min = 50, 
            #                      max = 2000, 
            #                      step = 10),
            #         h2("Ouputs:"),
            #         strong(textOutput(outputId = 'cd_patient_stock_out')),
            #         strong(textOutput(outputId = 'cd_ctr_stock_out')),
            #         strong(textOutput(outputId = 'cd_nctr_stock_out')),
            #         strong(textOutput(outputId = 'cd_avg_los_out')),
            #         strong(textOutput(outputId = 'cd_pre_DRD_los_out')),
            #         strong(textOutput(outputId = 'cd_nctr_per_bed_out')),
            )
        )
    )

server <- function(input, output, session){
    
    #calculator A ----
    
    ca_patient_stock_val <- reactive({
        (input$ca_bed_occ_in/100) * input$ca_ga_beds_in
    })
    
    ca_ctr_stock_val <- reactive({
        ca_total_admissions_val() * input$ca_pre_DRD_los_in
    })
    
    ca_nctr_stock_val <- reactive({
        ca_patient_stock_val() - ca_ctr_stock_val()
    })
    
    ca_total_admissions_val <- reactive({
        ca_patient_stock_val() / ca_avg_los_val()
    })
    
    ca_avg_los_val <- reactive({
        input$ca_pre_DRD_los_in + input$ca_post_DRD_los_in
    })
    
    ca_nctr_per_bed_val <- reactive({
        ca_nctr_stock_val() / input$ca_ga_beds_in
    })
        
    output$ca_patient_stock_out <- renderText({
        paste0("Total admitted patient stock: ", round(ca_patient_stock_val(), 1))
    })
    
    output$ca_ctr_stock_out <- renderText({
        paste0("CTR stock: ", round(ca_ctr_stock_val(), 0))
    })
    
    output$ca_nctr_stock_out <- renderText({
        paste0("NCTR stock: ", round(ca_nctr_stock_val(), 0))
    })
    
    output$ca_total_admissions_out <- renderText({
        paste0("Total admissions (Patients per day): ", round(ca_total_admissions_val(), 1))
    })
    
    output$ca_avg_los_out <- renderText({
        paste0("Total average length of stay: ", round(ca_avg_los_val(), 1))
    })
    
    output$ca_nctr_per_bed_out <- renderText({
        paste0("NCTR per bed: ", round(ca_nctr_per_bed_val(), 2))
    })
        
    #calculator B ----
    
    cb_patient_stock_val <- reactive({
        (input$cb_bed_occ_in/100) * input$cb_ga_beds_in
    })
    
    cb_ctr_stock_val <- reactive({
        cb_patient_stock_val() - cb_nctr_stock_val()
    })
    
    cb_nctr_stock_val <- reactive({
        input$cb_post_DRD_los_in * input$cb_ga_beds_in
    })
    
    cb_total_admissions_val <- reactive({
        cb_nctr_stock_val() / input$cb_post_DRD_los_in
    })
    
    cb_pre_DRD_los_val <- reactive({
        cb_avg_los_val() - input$cb_post_DRD_los_in   
    })
    
    cb_avg_los_val <- reactive({
        cb_patient_stock_val() / cb_total_admissions_val()
    })
    
    output$cb_patient_stock_out <- renderText({
        paste0("Total admitted patient stock: ", round(cb_patient_stock_val(), 1))
    })
    
    output$cb_ctr_stock_out <- renderText({
        paste0("CTR stock: ", round(cb_ctr_stock_val(), 0))
    })
    
    output$cb_nctr_stock_out <- renderText({
        paste0("NCTR stock: ", round(cb_nctr_stock_val(), 0))
    })
    
    output$cb_total_admissions_out <- renderText({
        paste0("Total admissions (Patients per day): ", round(cb_total_admissions_val(), 1))
    })
    
    output$cb_pre_DRD_los_out <- renderText({
        paste0("Average pre-DRD length of stay: ", round(cb_pre_DRD_los_val(), 1))
    })
    
    output$cb_avg_los_out <- renderText({
        paste0("Total average length of stay: ", round(cb_avg_los_val(), 1))
    })
    
    #calculator C ----
    
    cc_patient_stock_val <- reactive({
        (input$cc_bed_occ_in/100) * input$cc_ga_beds_in
    })
    
    cc_ctr_stock_val <- reactive({
        cc_patient_stock_val() - cc_nctr_stock_val()
    })
    
    cc_nctr_stock_val <- reactive({
        input$cc_nctr_per_bed_in * input$cc_ga_beds_in
    })
    
    cc_total_admissions_val <- reactive({
        cc_ctr_stock_val() / input$cc_pre_DRD_los_in
    })
    
    cc_post_DRD_los_val <- reactive({
        cc_nctr_stock_val() / cc_total_admissions_val()
    })
    
    cc_avg_los_val <- reactive({
        cc_post_DRD_los_val() + input$cc_pre_DRD_los_in
    })
    
    output$cc_patient_stock_out <- renderText({
        paste0("Total admitted patient stock: ", round(cc_patient_stock_val(), 1))
    })
    
    output$cc_ctr_stock_out <- renderText({
        paste0("CTR stock: ", round(cc_ctr_stock_val(), 0))
    })
    
    output$cc_nctr_stock_out <- renderText({
        paste0("NCTR stock: ", round(cc_nctr_stock_val(), 0))
    })
    
    output$cc_total_admissions_out <- renderText({
        paste0("Total admissions (Patients per day): ", round(cc_total_admissions_val(), 1))
    })
    
    output$cc_post_DRD_los_out <- renderText({
        paste0("Average post-DRD length of delay (all patients): ", round(cb_pre_DRD_los_val(), 1))
    })
    
    output$cc_avg_los_out <- renderText({
        paste0("Total average length of stay: ", round(cc_avg_los_val(), 1))
    })
}


shinyApp(ui = ui,
         server = server)
