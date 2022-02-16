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

## Read Data Skill Expertise

df <- read.csv("data/Algoritma Team Expertise - Copy of All 1.csv")

## Read Data Capstone Expertise

df2 <- read.csv("data/Algoritma Team Expertise - Capstone.csv")

## Data Pre-Process Skill Expertise

df <- df %>% 
  mutate_if(is.character, as.factor) %>% 
  mutate(Active = as.factor(Active)) %>% 
  filter(Active == 1) %>% 
  select(Nama, Bahasa,Expertise.In.Algortima.Specialization,everything())

## Data Pre-Process Capstone Expertise

df2 <- df2 %>% 
  mutate_if(is.character, as.factor) %>% 
  mutate(Active = as.factor(Active)) %>% 
    filter(Active == 1) 


























