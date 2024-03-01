library(tidyverse)
library(scales)
library(ggrepel)
library(patchwork)
#11 Communication
#11.1 Introduction

#11.2Label
#The easiest place to start when turning an exploratory graphic into an expository graphic is with good labels. 
#You add labels with the labs() function.
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  labs(
    x = "Engine displacement (L)",
    y = "Highway fuel economy (mpg)",
    color = "Car type",
    title = "Fuel efficiency generally decreases with engine size",
    subtitle = "Two seaters (sports cars) are an exception because of their light weight",
    caption = "Data from fueleconomy.gov"
  )


#To write math as labels use the quote() function and find it's syntax in ?plotmath
?plotmath
df <- tibble(
  x = 1:10,
  y = cumsum(x^2)
)

ggplot(df, aes(x, y)) +
  geom_point() +
  labs(
    x = quote(x[i]),
    y = quote(sum(x[i] ^ 2, i == 1, n))
  )

#11.2.1 Exercises

#2. Recreate fuel economy data to picture
?mpg
mpg
ggplot(mpg, aes(x=cty, y=hwy))+
  geom_point(aes(colour = drv, shape = drv))+
  labs(
    x= "City MPG",
    y= "Highway MPG",
    color = "Type of drive train",
    shape = "Type of drive train",
    title = "Cars Milage in the city compared to on the higway",
    subtitle = "super cool subtitle",
    caption = "Data from mpg library"
  )

label_info <- mpg |>
  group_by(drv) |>
  arrange(desc(displ)) |>
  slice_head(n = 1) |>
  mutate(
    drive_type = case_when(
      drv == "f" ~ "front-wheel drive",
      drv == "r" ~ "rear-wheel drive",
      drv == "4" ~ "4-wheel drive"
    )
  ) |>
  select(displ, hwy, drv, drive_type)

label_info
#> # A tibble: 3 × 4
#> # Groups:   drv [3]
#>   displ   hwy drv   drive_type       
#>   <dbl> <int> <chr> <chr>            
#> 1   6.5    17 4     4-wheel drive    
#> 2   5.3    25 f     front-wheel drive
#> 3   7      24 r     rear-wheel drive
ggplot(mpg, aes(x = displ, y = hwy, color = drv)) +
  geom_point(alpha = 0.3) +
  geom_smooth(se = FALSE) +
  geom_text(
    data = label_info, 
    aes(x = displ, y = hwy, label = drive_type),
    fontface = "bold", size = 5, hjust = "right", vjust = "bottom"
  ) +
  theme(legend.position = "none")
#> `geom_smooth()` using method = 'loess' and formula = 'y ~ x'
             