########### FUNCTIONS AND USING THE BUILT-IN HELP ############
# Functions are like functions and macros in Excel: a set of instructions that can be run by 
# calling the function's name, and even the click of a button. 
# Sometimes you're required to enter parameters.

# To run a function in R, you type out the name of the function along with parentheses
# Within the parentheses, you are often required to enter parameters.
# Sometimes the parameters have a default value, which you can manually change.
# If you don't label the parameters, then you need to enter them in the right order.
# If you label the parameters, then you can enter them in any order

# Let's start with functions that you've already seen as an example----
log(10)               # 10 is the first parameter. The second parameter is the base.

# The default base is the mathematical constant, e. 
log(10, 10)           # Entering 10 as the second parameter changes the base from the default value of e to 10.
log(10, 2)            # I can use any number as the number to evaluate or as the base.

# If I label the parameters, I can put them in any order.
log(base = 2, x = 10) # This is the same as log(10, 2). 

# Getting help with functions----
# It's much more important to know where you can find help than to try and memorize everything.
# Fortunately, R and RStudio have many built in help tools:
# Hover over help
# Tab completion
# Question mark
# Website

# You may have noticed hover-over help by now. If you click with a function name
# you will see a box pop up that shows the parameter names and default values.
# Try it out by clicking somewhere in the log portion below. Notice the default
# value for base is exp(1), which is the mathematical constant e.
log(10)
log
# You may have also noticed the tab completion by now. Try typing out log and then
# pausing. Notice that a menu will pop up with a list of functions or objects
# that RStudio thinks you may want to use. You can then scroll down through the
# suggestions and get a brief overview of the help. RStudio also indicates that
# you can get more help by pressing F1, at least on my machine. Once you highlight
# the function that you want to use, you can press the tab key to insert it.
log10()

# Question mark: The full documentation for a function can be found by clicking
# on F1 in the tab completion, or you can use the question mark, and then enter
# the function name. For instance, try running the ?log below, or entering it
# into the console. In the bottom-right-hand pane, under the Help tab, you'll
# see lots of documentation for the function. You should see a description,
# the variants of the function, the parameters or arguments and what they mean,
# some other details, and at the bottom some examples. I often quickly jump 
# either to the Arguments or Examples section.
?log

# You can also find help on the rdocumentation.org website. You can enter a
# function name, and see functions with that name, as well as packages (which
# we'll talk about in another lesson), and collaborators.

# Some other useful functions----
# Below are some other useful functions beyond mathematical operators.

# Clear all variables from the global environment
rm(list = ls())       # It's equivalent to using the broom icon in the Environment pane.

# Change the working directory.
setwd()               # This is equivalent to using the ... icon in the Files pane.

# Read in a .csv file of data.
read.csv()           # This is equivalent to clicking the Import Dataset Icon in the Environment pane.


# Why did I just show you functions that are easily available using RStudio?
# To automate data analysis, you want to document all of the instructions from
# the beginning to the end so that you can simply run the file, and it will
# produce the results without requiring any other intervention.

