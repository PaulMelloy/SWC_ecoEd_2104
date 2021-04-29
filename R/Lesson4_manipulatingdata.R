# -----------------------------------------------------------
# Lesson 4
# Manipulating, analysing and exporting data with tidyverse
#

surveys <- read_csv("data_raw/portal_data_joined.csv")

# help file on `select`
?select

# select three columns from surveys data
select(surveys, plot_id, species_id, weight)

# select all columns except 2 columns
select(surveys, -record_id, -species_id)

# Lets remove some rows
filter(surveys, year == 1995)

# using a pipe operator %>% to simplify our code
surveys %>% 
   filter(year == 1995) %>%
   select(species_id, sex, weight) %>%
   filter(weight >= 50) %>%
   filter(sex == "F") 

# function `mutate`

surveys %>%
   mutate(weight_kg = weight / 1000) %>%
   select(weight_kg)

# remove na values
surveys %>%
   filter(!is.na(weight)) %>%
   mutate(weight_kg = weight / 1000) %>%
   select(weight_kg)

# calculate two new columns kg and lb
surveys %>%
   filter(!is.na(weight)) %>%
   mutate(weight_kg = weight / 1000,
          weight_lb = weight * 2.2) %>%
   select(weight_kg, weight_lb)


# summarise() function
# we can use the function group_by() to break-up the data
#  and summarise by categories
surveys %>%
   group_by(sex) %>%
   summarise(mean_weight = mean(weight, na.rm = TRUE))



# Replacing values in a vector
 gsub(pattern = "Cracticus tibicen", 
      replacement = "new_name",
      x = ala_data)
 
 gsub(pattern = "M", 
      replacement = "Male",
      x = surveys$sex)
 