#------------------------------LIBRARY-----------------------------------------

## Data
library(googlesheets4)

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

## Connect to googlesheet

# Set authentication token to be stored in a folder called `.secrets`
options(gargle_oauth_cache = ".secrets")

# Authenticate manually
gs4_auth()

# If successful, the previous step stores a token file.
# Check that a file has been created with:
list.files(".secrets/")

# Check that the non-interactive authentication works by first deauthorizing:
gs4_deauth()

# Authenticate using token. If no browser opens, the authentication works.
gs4_auth(cache = ".secrets", email = "victor@algorit.ma")

## Read Data Skill Expertise

df <- read_sheet("https://docs.google.com/spreadsheets/d/1KyM2g_9T5Un6u14OZCO4ufHfz8sMz70cauxqKAQviog/edit#gid=2004238697",
                  sheet = "All")

## Read Data Capstone Expertise

df2 <- read_sheet("https://docs.google.com/spreadsheets/d/1KyM2g_9T5Un6u14OZCO4ufHfz8sMz70cauxqKAQviog/edit#gid=2004238697", 
                   sheet = "Capstone")

## Data Pre-Process Skill Expertise

df <- df %>% 
  mutate_if(is.character, as.factor) %>% 
  mutate(Active = as.factor(Active)) %>% 
  mutate_all(list(~na_if(.,""))) %>% 
  filter(Active == 1) %>% 
  select(Nama, Bahasa,`Expertise In Algortima Specialization`,everything())

## Data Pre-Process Capstone Expertise

df2 <- df2 %>% 
  mutate_if(is.character, as.factor) %>% 
  mutate(Active = as.factor(Active)) %>% 
    filter(Active == 1) 

#------------------------------PICKER INPUT-------------------------------------

## Tools Choice For Picker Input

all_tools <- unique(df$Bahasa)
main_tools <- c("Python", "R", "SQL")

## Name Choice For Picker Input

team_choice <- read_sheet("https://docs.google.com/spreadsheets/d/1KyM2g_9T5Un6u14OZCO4ufHfz8sMz70cauxqKAQviog/edit#gid=2004238697", 
                          sheet = "ListTeam")

team_choice <- as.list(team_choice)

veteran_choice <- read_sheet("https://docs.google.com/spreadsheets/d/1KyM2g_9T5Un6u14OZCO4ufHfz8sMz70cauxqKAQviog/edit#gid=2004238697", 
                             sheet = "ListVeteran")

veteran_choice <- as.list(veteran_choice)

name_choice <-  c(team_choice, veteran_choice)

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

























