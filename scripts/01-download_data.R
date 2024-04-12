#### Preamble ####
# Purpose: Download the text of the book from Project Gutenberg.
# Author: Daisy Huo
# Date: 7 April 2024
# Contact: daisy.huo@mail.utoronto.ca
# License: MIT
# Pre-requisites: N/A

#### Workspace setup ####
library(tidyverse)
library(gutenbergr)
library(dataverse)
library(arrow)

#### Download data ####
# Refer to code from: https://tellingstorieswithdata.com/13-ijaglm.html#letters-used-in-jane-eyre
gutenberg_id_of_firstfolio <- 2270

first_folio <-
  gutenberg_download(
    gutenberg_id = gutenberg_id_of_firstfolio,
    mirror = "https://gutenberg.pglaf.org/"
  )

first_folio

### Save data ###
write_csv(first_folio, "first_folio.csv")