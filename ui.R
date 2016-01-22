source("global.R")

# Define UI for application that draws a histogram
shinyUI(fluidPage(
        title="Mexican maize landraces genetic diversity explorer",
            div(img(src="conabio.png"), style="text-align: center;"),
            h1("Mexican maize lanraces genetic diversity explorer", align = "center"),
        
            p("Below are shown a principal component analysis and a distance tree built using 36,931 SNPs of the Illumina",
              "MaizeSNP50 chip on 161 accesions of the", 
              tags$a(href="http://www.biodiversidad.gob.mx/genes/proyectoMaices.html", "Global Maize Proyect.")),
            
            p("Methodological and sampling details are published (open access) in",
              "Artega", em("et al."), "(2015) Genomic variation in recently collected maize landraces from Mexico,", 
              em("Genomics Data,"), "7: 38–45. http://dx.doi.org/10.1016/j.gdata.2015.11.002. Please cite this paper along with this webpage to refer to this app.",
              "Original data can be downloaded from this",  tags$a(href="http://datadryad.org/resource/doi:10.5061/dryad.4t20n", "repository.")),
            
            p("You can explore the distribution of genetic variation according to the biological or physical characteristics", 
              "shown in the left panel of options."),
        
            p("For further information of each of the landraces visit our", 
              tags$a(href="http://www.biodiversidad.gob.mx/usos/maices/razas2012.html", "wepage on the Mexican maize landraces.")),
      
            p("Funding was provided by the Dirección General del Sector Primario y Recursos Naturales Renovables (DGSPRNR)", 
              "of the Secretaría de Medio Ambiente y Recursos Naturales (SEMARNAT) through a grant to the Comisión Nacional", 
              "para el Uso y Conocimiento de la Biodiversidad (CONABIO). Seed samples were provided by the Instituto Nacional",
              "de Investigaciones Forestales, Agrícolas y Pecuarias (INIFAP)."),
    
            p("Questions? Found a bug? Please contact Alicia Mastretta-Yanes at amastretta@conabio.gob.mx"),

       fluidRow(
        column(2,
               h3("Options", align = "center"),
               # Color by
               selectInput(inputId= "ColorBy", label="Colorear por:", 
                           choices= c("Raza", "Longitud", "Latitud", 
                                      "Altitud" , "Categoría de altitud" , 
                                      "Grupo ecológico", "Grupo taxonómico",  
                                      "Biogeografía de México", "División Florística" , 
                                      "Biogeografía del maíz" )),
               
               # Restrict to
               sliderInput(inputId= "Altitud", label="Restrict to altitude:", min=0, max=3000, value=c(0,3000)),
               
               sliderInput(inputId= "Latitud", label="Restrict to latitude:", 
                           min=round(min(fullmat$Latitud), 2), max=round(max(fullmat$Latitud),2),
                           round=TRUE,  step=0.1,
                           value=c(min(fullmat$Latitud), max(fullmat$Latitud))),
               
               sliderInput(inputId= "Longitud", label="Restrict to longitude:", 
                           min=round(min(fullmat$Longitud), 2), max=round(max(fullmat$Longitud),2),
                           round=TRUE,  step=0.1,
                           value=c(min(fullmat$Longitud), max(fullmat$Longitud))),
               
               
               # Select landraces / estado
               
               
               checkboxGroupInput(inputId="Razas", 
                                  label="Show landraces:", 
                                  choices=levels(x$Raza)[1:46], selected=levels(x$Raza)[1:46]), # x is fullmat$Ra
               
               checkboxGroupInput(inputId="Estados", 
                                  label="Show samples from the States:", 
                                  choices=levels(fullmat$Estado), selected=levels(fullmat$Estado))              
               
               ),
        
        column(7,
               h3("Plots", align = "center"),
               # Plot PCA
               h4("Principal Component Analysis", align = "center"),
               plotOutput(outputId="pca", width = "100%", height = "400px"), 
               
               # Plot tree
               h4("Tree of genetic distances", align = "center"),
               plotOutput(outputId="tree", width = "100%", height = "400px"),
               
               # Plot map
               h4("Geographic distribution", align = "center"),
               plotOutput(outputId="mapa", width = "100%", height = "400px")
               
               ),
        
        column(3, 
               h3("Legend", align = "center"),
               imageOutput(outputId="Legend")
               )
        
       )
        
  )
)




