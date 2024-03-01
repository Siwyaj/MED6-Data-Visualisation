#https://r4ds.hadley.nz/data-visualize
#1 Data visualization
#
library(tidyverse)
library(palmerpenguins)
library(ggthemes)
#1.2 First steps

#1.2.1 The penguins data frame
glimpse(penguins)

#1.2.2 Ultimate goal
#visualization displaying the relationship between flipper lengths and body masses

#1.2.3 Creating a ggplot
#Use the function ggplot() to start the data which we will layer our visualization
#the first argument of ggplot() is the data we need to plot, we write data = penguins
#the mapping argument is aes() and is set mapping = aes()
#the argument of aes() is what should first be plotted on the x-axis and then the y-axis
#in this case we will map x to flipper length and y to body mass
plot_canvas<-ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
)
#We now get an empty canvas where our data should go
#The data is not shown as it has no defined geometry,
#We will add the geom_point() attribute to the plot
#other geometries are available:geom_bar(), geom_boxplot()
plot_scatter<-plot_canvas + geom_point()
plot_scatter

#1.2.4 Adding aesthetics and layers
#we would like to see if there might be something else to visualize in the data
#fx is the species related to the flipper length and body mass
#to visualize this we will add "color = species" as an attribute to the aes() function
plot_point_species_colored<-ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color  = species)
) + geom_point()
plot_point_species_colored


#we would like to add a smooth curve relationship between body mass and flipper length
#as this is a new geometrical layer we will add it to the plot
plot_point_species_colored_shaped_lines<-plot_point_species_colored + geom_smooth(method = "lm")
plot_point_species_colored_shaped_lines

#The lines shows for each of the different spieces of penguins
#we want one line for all penguins
#when a new geom is added, if given no mapping arguemtens, it will take the ones of the ggplot mapping
#when we add a new geom, we can give it new mapping arguments
#as we want the colour to be a mapping of the points, we can seperate it in the points geom
#Doing this makes it so the smooth geom will not take the species into account
plot_point_species_colored_shaped_line<-ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) + geom_point(aes(color  = species)) + geom_smooth(method = "lm")
plot_point_species_colored_shaped_line

#We can now fix the text in the plot by adding a labs() funtion to the plot
plot_point_species_colored_shaped_line_labled<-ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(aes(color = species, shape = species)) +
  geom_smooth(method = "lm") +
  labs(
    title = "Body mass and flipper length",
    subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
    x = "Flipper length (mm)", y = "Body mass (g)",
    color = "Species", shape = "Species"
  ) 
plot_point_species_colored_shaped_line_labled

#We can then make it colour-blind friendly
plot_point_species_colored_shaped_line_labled_cb_friendly<-plot_point_species_colored_shaped_line_labled+scale_color_colorblind()
plot_point_species_colored_shaped_line_labled_cb_friendly

#Exercises
#1. How many rows are in penguins? How many columns?
#done by printing ncol(penguins) and nrow(penguins)
nrow(penguins)
ncol(penguins)

#2. What does the bill_depth_mm variable in the penguins data frame describe? Read the help for ?penguins to find out.
#We can find the info of a dataset (i might open a readme) by typing ?data(?penguins)
?penguins
#From here we can see under "bill_depth_mm" it says "a number denoting bill depth (millimeters)"

#3. Make a scatterplot of bill_depth_mm vs. bill_length_mm. 
#That is, make a scatterplot with bill_depth_mm on the y-axis and bill_length_mm on the x-axis. 
#Describe the relationship between these two variables.

#first we make the plot like previous with ggplot, we just exchange the x and y variable with the ones from the excersice 
#remeber to give the data a geometry
exercise3_scatter<-ggplot(
  data = penguins,
  mapping = aes(x = bill_depth_mm, y = bill_length_mm)
) + geom_point()
exercise3_scatter
#from this plot no correlation is seen
exercise3_scatter_species_colored<-ggplot(
  data = penguins,
  mapping = aes(x = bill_depth_mm, y = bill_length_mm, color  = species)
) + geom_point()
exercise3_scatter_species_colored
#a better correlation can be seen when looking at the individual spieces
#with regression
exercise3_scatter_species_colored_regression<-exercise2_scatter_species_colored+ geom_smooth(method = "lm")
exercise3_scatter_species_colored_regression

#4. What happens if you make a scatterplot of species vs. bill_depth_mm? What might be a better choice of geom?
exercise4_scatter<-ggplot(
  data = penguins,
  mapping = aes(x = species, y = bill_depth_mm)
) + geom_point()
exercise4_scatter
#a petter geom might be a bar(geom_bar(stat="identity"), the stat="identity", tells it to ignore y-value)
exercise4_bar<-ggplot(
  data = penguins,
  mapping = aes(x = species, y = bill_depth_mm)
) + geom_bar(stat="identity")
exercise4_bar
#this however adds all the leghts together
#a better choice might be geom_boxplot()
exercise4_box<-ggplot(
  data = penguins,
  mapping = aes(x = species, y = bill_depth_mm)
)+geom_boxplot()
exercise4_box
#5. Why does the following give an error and how would you fix it?
ggplot(data = penguins) + 
  geom_point()
# geom does not know what to plot on each axis, to fix we either map x= and y= in the ggplot() or geom_point() function using mapping = aes()
ggplot(data = penguins) + 
  geom_point(aes(x=body_mass_g, y=bill_depth_mm))

#6.What does the na.rm argument do in geom_point()? 
#What is the default value of the argument? 
#Create a scatterplot where you successfully use this argument set to TRUE.
ggplot(data = penguins) + 
  geom_point(aes(x=body_mass_g, y=bill_depth_mm), na.rm=TRUE)
#It removes not avaible data

#7. Add the following caption to the plot you made in the previous exercise: “Data come from the palmerpenguins package.” 
#Hint: Take a look at the documentation for labs(). https://ggplot2.tidyverse.org/reference/labs.html
ggplot(data = penguins) + 
  geom_point(aes(x=body_mass_g, y=bill_depth_mm), na.rm=TRUE)+
  labs(title = "Data come from the palmerpenguins package.")

#8. Recreate the following visualization. 
#What aesthetic should bill_depth_mm be mapped to? 
#And should it be mapped at the global level or at the geom level?

ggplot(data = penguins, mapping = aes(x=flipper_length_mm, y=body_mass_g, color = bill_depth_mm), na.rm=TRUE) + 
  geom_point()+
  geom_smooth()
  
#1.3 ggplot2 calls
#at this point we now that ggplot()'s first two argument are the data and the mapping, so we will no longer write data= and mapping=.
#instead we will just write what they are equal to
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) + 
  geom_point()

#we will be leaerning about the pipe, |>.
penguins |> 
  ggplot(aes(x = flipper_length_mm, y = body_mass_g)) + 
  geom_point()
#it adds the left argument "penguins" as the first argument in the right function

#1.4 Visualizing distributions
#1.4.1 A categorical variable
#A variable is categorical if it can only take one of a small set of values.
ggplot(penguins, aes(x = species)) +
  geom_bar()
#this plot is ordered after when the data is presented in the dataset
#instead, we would like to order the data
ggplot(penguins, aes(x = fct_infreq(species))) +
  geom_bar()
#1.4.2 A numerical variable
#A variable is numerical (or quantitative) if it can take on a wide range of numerical values, and it is sensible to add, subtract, or take averages with those values. 
#Numerical variables can be continuous or discrete.
#One commonly used visualization for distributions of continuous variables is a histogram.
#change the binwidth for different sample difference size
ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram(binwidth = 200)
ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram(binwidth = 20)
ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram(binwidth = 2000)

#a smooth version of this is called a density plot
ggplot(penguins, aes(x = body_mass_g)) +
  geom_density()

#1.4.3 Exercises
#1. Make a bar plot of species of penguins, where you assign species to the y aesthetic. How is this plot different?
ggplot(penguins, aes(y = fct_infreq(species))) +
  geom_bar()
#it rotated 

#2. How are the following two plots different? 
#Which aesthetic, color or fill, is more useful for changing the color of bars?
ggplot(penguins, aes(x = species)) +
  geom_bar(color = "red")

ggplot(penguins, aes(x = species)) +
  geom_bar(fill = "red")
#fill is better

#3. What does the bins argument in geom_histogram() do? 
#change the size of the interval we count, see histogram above

#4. Make a histogram of the carat variable in the diamonds dataset that is available when you load the tidyverse package. 
#Experiment with different binwidths. 
#What binwidth reveals the most interesting patterns?

library(tidyverse)
?diamonds
ggplot(diamonds,aes(x=carat))+
  geom_histogram(binwidth = 0.2)
ggplot(diamonds,aes(x=carat))+
  geom_density()

#1.5 Visualizing relationships
#1.5.1 A numerical and a categorical variable
#To visualize the relationship between a numerical and a categorical variable we can use side-by-side box plots.
ggplot(penguins, aes(x = species, y = body_mass_g)) +
  geom_boxplot()
#Alternatively, we can make density plots with geom_density().
ggplot(penguins, aes(x = body_mass_g, color = species)) +
  geom_density(linewidth = 0.75)
#and you can fill it if neaded
ggplot(penguins, aes(x = body_mass_g, color = species, fill = species)) +
  geom_density(alpha = 0.5)

#1.5.2 Two categorical variables

ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar()

ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar(position = "fill")

#map three different plots
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = species, shape = species)) +
  facet_wrap(~island)
