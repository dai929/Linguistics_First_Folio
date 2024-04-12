#### Preamble ####
# Purpose: Clean the dataset by removing empty and unrelated lines and create counts of the number of vowels in that line, for the first ten lines of each play.
# Author: Daisy Huo
# Date: 7 April 2024
# Contact: daisy.huo@mail.utoronto.ca
# License: MIT
# Pre-requisites: N/A

#### Workspace setup ####
library(tidyverse)
library(arrow)
library(janitor)
library(readr)

#### Read data ####
# Refer to code from: https://tellingstorieswithdata.com/13-ijaglm.html#letters-used-in-jane-eyre
first_folio <- read_csv(
  "inputs/data/first_folio.csv",
  col_types = cols(
    gutenberg_id = col_integer(),
    text = col_character()
  )
)

first_folio

### Clean data ###
first_folio_reduced <-
  first_folio[476:134990,] |>
  filter(!is.na(text)) |> # Remove empty lines
  mutate(play = if_else(str_detect(text, 
                                   "The Tempest|The Two Gentlemen of Verona|The Merry Wiues of Windsor|Measvre, For Measure|The Comedie of Errors|Much adoe about Nothing|Loues Labour's lost|A Midsommer Nights Dreame|The Merchant of Venice|As you Like it|The Taming of the Shrew|All's Well, that Ends Well|Twelfe Night, Or what you will|The Winters Tale|The life and death of King John|The life and death of King Richard the Second|The First Part of Henry the Fourth|The Second Part of Henry the Fourth|The Life of Henry the Fift|The first Part of Henry the Sixt|The second Part of Henry the Sixt|The third Part of Henry the Sixt|The Tragedie of Richard the Third|The Famous History of the Life of King Henry the Eight|The Tragedie of Coriolanus|The Tragedie of Titus Andronicus|The Tragedie of Romeo and Juliet|The Life of Timon of Athens|The Tragedie of Julius Caesar|The Tragedie of Macbeth|The Tragedie of Hamlet|The Tragedie of King Lear|The Tragedie of Othello, the Moore of Venice|The Tragedie of Anthonie, and Cleopatra|The Tragedie of Cymbeline") == TRUE,
                        text,
                        NA_character_)) |> # Find start of play
  fill(play, .direction = "down") |> 
  mutate(play_line = row_number(), 
         .by = play) |> # Add line number to each play
  filter(!is.na(play), 
         play_line %in% c(2:11)) |> # Remove title of each play
  select(text, play) |>
  mutate(count_vowel = str_count(text, "A|E|I|O|U|a|e|i|o|u"),
         word_count = str_count(text, "\\w+")
         # From: https://stackoverflow.com/a/38058033
  ) |>
  filter(!grepl("FINIS. The First Part of Henry the Fourth, with the Life and Death|Epilogue. The Second Part of Henry the Fourth, Containing his|FINIS. The second Part of Henry the Sixt, with the death of the|FINIS. The third Part of Henry the Sixt, with the death of the Duke", first_folio_reduced$play),)

first_folio_reduced |>
  select(play, word_count, count_vowel, text) |>
  head()

### Save data ###
write_csv(
  first_folio_reduced, "first_folio_analysis.csv"
)

### Test data ###
first_folio_reduced$text |>
  class() == "character"

first_folio_reduced$play |>
  unique() |>
  length() == 35

first_folio_reduced$play |>
  class() == "character"

first_folio_reduced$word_count |>
  min() >= 0

first_folio_reduced$word_count |>
  max() <= 15

first_folio_reduced$count_vowel |>
  class() == "integer"
