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
  mutate_all(list(~na_if(.,""))) %>% 
  filter(Active == 1) %>% 
  select(Nama, Bahasa,Expertise.In.Algortima.Specialization,everything())

## Data Pre-Process Capstone Expertise

df2 <- df2 %>% 
  mutate_if(is.character, as.factor) %>% 
  mutate(Active = as.factor(Active)) %>% 
    filter(Active == 1) 

#------------------------------ADDITIONAL---------------------------------

## Tools Choice For Picker Input

all_tools <- unique(df$Bahasa)
main_tools <- c("Python", "R", "SQL")

## Name Choice For Picker Input

name_choice <- list("Team A" = c("Cut","Fafil", "Ina", "Tria", "Yosia", "Victor"),
                    "Team B" = c("Dwi", "Kevin", "Lita", "Nabiilah", "Risman", "Wulan"),
                    "Veteran" = c("Ajeng", "David", "Handoyo", "Tomy"))

## To Select An Entire Group For Picker Input Choices

picker_in <- HTML("
$(function() {
  let observer = new MutationObserver(callback);

  function clickHandler(evt) {
    Shiny.setInputValue('group_select', $(this).children('span').text());
  }

  function callback(mutations) {
    for (let mutation of mutations) {
      if (mutation.type === 'childList') {
        $('.dropdown-header').on('click', clickHandler).css('cursor', 'pointer');
        
      }
    }
  }

  let options = {
    childList: true,
  };

  observer.observe($('.inner')[0], options);
})
")

























