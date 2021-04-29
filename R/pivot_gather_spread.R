# ___________________________________________________________
# Manipulating, analyzing and exporting data with tidyverse

# _______________________________
# Learning Objectives
#
#  Describe the purpose of the dplyr and tidyr packages.
#  Select certain columns in a data frame with the dplyr function select.
#  Extract certain rows in a data frame according to logical (boolean) 
#    conditions with the dplyr function filter .
#  Link the output of one dplyr function to the input of another function 
#    with the ‘pipe’ operator %>%.
#  Add new columns to a data frame that are functions of existing columns 
#    with mutate.
#  Use the split-apply-combine concept for data analysis.
#  Use summarize, group_by, and count to split a data frame into groups 
#    of observations, apply summary statistics for each group, and then 
#    combine the results.
#  Describe the concept of a wide and a long table format and for which 
#    purpose those formats are useful.
#  Describe what key-value pairs are.
#  Reshape a data frame from long to wide format and back with the spread 
#    and gather commands from the tidyr package.
#  Export a data frame to a .csv file.

# Load tidyverse library if you have not already
# A good place to start for learning more about R packages and tidyverse are 
#  these links below:
#
# https://r-universe.dev/organizations/
# https://www.tidyverse.org/
# https://tidyr.tidyverse.org/
# https://dplyr.tidyverse.org/

# lets load our installed umbrella package
library(tidyverse)





# Reshaping with gather and spread

## Function vignettes
# gather()
# https://tidyr.tidyverse.org/reference/gather.html

# spread()
# https://tidyr.tidyverse.org/reference/spread.html


# Gather and spread function have been superceded by the functions:
#  pivot_longer() - gather()
#  pivot_wider() - spread()

# You can find details to how to use the `pivot_` functions by calling
#  the vignette with the `vignette()`
vignette("pivot")


# Lets filter the data set to remove `NA` values in `weight`
# group the data by `plot_id` and `genus`
# summarise the mean of `weight`
# save to a new object `surveys_gw`
surveys_gw <- surveys %>%
   filter(!is.na(weight)) %>%
   group_by(plot_id, genus) %>%
   summarize(mean_weight = mean(weight))


#----spread-------
# spread the `mean_weight` values into a new column referenced by the 
#  key - `genus`
surveys_spread <- surveys_gw %>%
   spread(key = genus, 
          value = mean_weight)

# inspect the output
head(surveys_spread)

surveys_gw %>%
   filter(plot_id <= 3) %>%
   arrange(genus)

# ---pivot-----
# pivot_wider
surveys_wider <- 
   surveys_gw %>%
   pivot_wider(names_from = genus,
               values_from = mean_weight)

# Inspect output
str(surveys_wider)
head(surveys_wider)

surveys_gw %>%
   filter(plot_id <= 3) %>%
   arrange(genus)




# -------------------
# ---spread-fill-----
# spread
surveys_gw %>%
   spread(key = genus, 
          value = mean_weight, 
          fill = 0) %>%
   head()

# --- pivot-fill -----
surveys_gw %>%
   pivot_wider(names_from = genus, 
               values_from = mean_weight, 
               values_fill = 0) %>%
   head()




# -----------------------------
# ---- gather ---
surveys_gather <- 
   surveys_spread %>%
   gather(key = "genus", 
          value = "mean_weight", 
          -plot_id)


# ---- pivot_wider ----
survey_longer <-
   surveys_wider %>%
   pivot_longer(cols = -plot_id,
                names_to = "genus",
                values_to = "mean_weight")
### OR

survey_longer <-
   surveys_wider %>%
   pivot_longer(cols = Baiomys:Spermophilus,
                names_to = "genus",
                values_to = "mean_weight")
