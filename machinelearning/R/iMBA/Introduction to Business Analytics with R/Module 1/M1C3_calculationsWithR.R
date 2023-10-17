########## CALCULATIONS WITH R ##########
# Show how to create a new RScript.
# Show how you can run code in the console.
# Indicate that you can also perform those calculations in the editor and save the code for later.
# To run a line of code in the editor, click the Run button.
# Basic Calcuations----
2+4           # Addition
5-6           # Subtraction
5*10          # Multiplication
40/3          # Division
3^2           # You can raise a number to a power in two ways. Like this...
3**2          # or like this
5%%2          # This is the modulo operator. It returns the remainder of 5 divided by 2
5%/%2         # This is the integer division operator and returns the integer of 5 divided by 2
log(10)       # The default of log is to perform the natural logarithm
log(10, 10)   # You can use a different base by entering a comma followed by the desired base.

# You can run many rows of code at once by highlighting them all and clicking the run button.

# Rather than click the Run button, you can also use the shortcut key.



# Creating and Performing Operations with Numeric Variables----
# One of the great things about Excel is that you can refer to a cell reference, rather than
# hard-code a number. This makes it possible to update the outcome of calculations
# by just changing the numbers in the cells. You can even assign a name to a cell.

# This same idea can be done in R by assigning values to variables.
# You can assign values to variables using <- or =
# It's good form to use <- because = is used in functions (more on that later).
# A shortcut is to press Alt + -, which will add a space before and after <-.
x <- 5        # Assign x the value of 5
y <- 8        # Assign y the value of 8
x*y           # x multiplied by y will return the same thing as 5 multiplied by 8
z <- x*y      # assign z the result of x multiplied by y
rm(z)         # Removes a variable from memory

# Creating and Performing Operations with Numeric Vectors----
threeNumbers <- c(1,2,3)          # Creates a vector of three numbers
length(threeNumbers)              # Tells you how many items are in the vector
sum(threeNumbers)                 # Adds up the three numbers
mean(threeNumbers)                # Average, or mean, of the three numbers
min(threeNumbers)                 # Minimum value in the vector
max(threeNumbers)                 # Maximum value in the vector

# Performing Operations on All Elements of a Vector----
# A really powerful feature of R is that many operations are vectorized. This means that with very few
# words, an operation will be performed on all elements of the vector at once.
threeNumbers+4                    # You can perform the same calculation on all numbers at once
threeNumbers <- threeNumbers+4    # To store the updated value of the three numbers, you have to reassign it
threeMoreNumbers <- c(4,5,6)      # Create another vector of three different numbers
threeNumbers+threeMoreNumbers     # You can add the three sets of numbers together
threeNumbers*threeMoreNumbers     # You can multiply the three sets of numbers together. (Not matrix multiplication.)
threeNumbers*c(4,5,6,7)           # This won't work because the two vectors have to be the same length.
