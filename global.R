#------------------------------LIBRARY-----------------------------------------

## Shiny
library(shiny)
library(shinydashboard)
library(shinythemes)
library(shinyWidgets)
library(dashboardthemes)
library(DT)
library(bslib)
library(shinycssloaders)
library(shinyBS)
library(shinyjs)
library(rintrojs)

## Data Wrangling 
library(dplyr)
library(tidyr)
library(stringr)
library(janitor)

## Visualization
library(networkD3)
library(htmlwidgets)

#------------------------------DATA PREPARATION---------------------------------

## Read Data

df <- read.csv("data/Algoritma Team Expertise - Copy of All.csv")

## Data Pre-Process

df <- df %>% 
  mutate_if(is.character, as.factor) %>% 
  mutate(Active = as.factor(Active)) %>% 
  filter(Active == 1) %>% 
  select(Nama, Bahasa,Expertise_In_Algortima_Specialization,everything())
