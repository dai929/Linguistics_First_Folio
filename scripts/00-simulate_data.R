#### Preamble ####
# Purpose: Simulate a dataset of how the number of vowels could be distributed following the Poisson distribution.
# Author: Daisy Huo
# Date: 7 April 2024
# Contact: daisy.huo@mail.utoronto.ca
# License: MIT
# Pre-requisites: N/A

#### Workspace setup ####
library(tidyverse)

#### Simulate data ####
# Refer to code from: https://tellingstorieswithdata.com/13-ijaglm.html#letters-used-in-jane-eyre
count_of_vowel_simulation <-
  tibble(
    play = c(rep("The Tempest", 10),
                rep("The Two Gentlemen of Verona", 10),
                rep("The Merry Wives of Windsor", 10),
                rep("Measure for Measure", 10),
                rep("The Comedy of Errours", 10),
                rep("Much adoo about Nothing", 10),
                rep("Loves Labour lost", 10),
                rep("Midsommer Nights Dreame", 10),
                rep("The Merchant of Venice", 10),
                rep("As you Like it", 10),
                rep("The Taming of the Shrew", 10),
                rep("All is well, that Ends well", 10),
                rep("Twelfe-Night, or what you will", 10),
                rep("The Winters Tale", 10),
                rep("The Life and Death of King John", 10),
                rep("The Life & death of Richard the second", 10),
                rep("The First part of King Henry the fourth", 10),
                rep("The Second part of K. Henry the fourth", 10),
                rep("The Life of King Henry the Fift", 10),
                rep("The First part of King Henry the Sixt", 10),
                rep("The Second part of King Hen. the Sixt", 10),
                rep("The Third part of King Henry the Sixt", 10),
                rep("The Life and Death of Richard the Third", 10),
                rep("The Life of King Henry the Eight", 10),
                rep("The Tragedy of Coriolanus", 10),
                rep("Titus Andronicus", 10),
                rep("Romeo and Juliet", 10),
                rep("Timon of Athens", 10),
                rep("The Life and death of Julius Caesar", 10),
                rep("The Tragedy of Macbeth", 10),
                rep("The Tragedy of Hamlet", 10),
                rep("King Lear", 10),
                rep("Othello, the Moore of Venice", 10),
                rep("Anthony and Cleopater", 10),
                rep("Cymbeline King of Britaine", 10)),
    line = rep(1:10, 35),
    number_words_in_line = runif(min = 0, max = 15, n = 350) |> round(0),
    number_vowel = rpois(n = 350, lambda = 10)
  )

count_of_vowel_simulation

count_of_vowel_simulation |>
  ggplot(aes(y = number_vowel, x = number_words_in_line)) +
  geom_point() +
  labs(
    x = "Number of words in line",
    y = "Number of vowels in the first ten lines"
  ) +
  theme_classic() +
  scale_fill_brewer(palette = "Set1")

### Tests ###
count_of_vowel_simulation$play |>
  unique() |>
  length() == 35

count_of_vowel_simulation$line |>
  class() == "integer"

count_of_vowel_simulation$line |>
  unique() |>
  length() == 10

count_of_vowel_simulation$number_words_in_line |>
  min() >= 0

count_of_vowel_simulation$number_words_in_line |>
  max() <= 15

count_of_vowel_simulation$number_vowel |>
  class() == "integer"