########### CONDITIONAL STATEMENTS #############
# Conditional statements are if-else statements.
# There's a good chance that you've used the =IF function in Excel. It's similar
# in R, but easier to read because you can use multiple lines and indentations.
# The general structure is if (conditions are true){perform these actions}else{perform these actions}
# However, using multiple lines is better form. RStudio automatically inserts
# indentation on  new lines to help keep track of things.

# Simple Conditional Statements using ifelse----
# Using ifelse to return one value. Like =IF in Excel
?ifelse    # It's vectorized, so it performs the test on every item in the vector
x <- 5
y <- 10
ifelse(x>y,'it is greater', 'it is not greater')

# ifelse is a vectorized function, so it will perform the operation for every
# item in the vector
x <- c(5,15)
y <- c(10,12)
ifelse(x>y,'x is greater','x is not greater')

# Simple Conditional Statement using separate if and else components----
# This is useful if you want to perform many other operations once a condition is met

if(x == y){
  print('x equals y')
  xComparison <- 'x is greater'
}else{
  print('x is not equal to y')
  xComparison <- 'x is not greater'
}

# You can use else and if to create a conditional statement with multiple branches----
if(x == y){
  print('x and y are equal')
}else if(x < y){
  print('x is less than y')
}else if(x > y){
  print('x is greater than y')
}else{
  print("there's a problem")
}
# Once it finds that a condition is true, then it stops and does not evaluate
# the remaining branches.



############ BUSINESS DATA APPLICATIONS ###############
df <- read.csv('jan17Items.csv', stringsAsFactors = F)

# Compound Conditional Statements----
# You can use compound conditional statements by using & for and, and | for or.
# Tell us if Ron is not a column name and if Cost is a column name

# Once it enters a branch of the if statement, it will not evaluate the other branches
if(!'Ron' %in% names(df)){
  print('Ron is not a column name')
}else if('Cost' %in% names(df)){
  print('Cost is a column name')
}else{
  print('Ron and Cost are not column names')
}

# We could use two conditional statements, but it's simpler to use a compound conditional statement
if(!'Ron' %in% names(df) & 'Cost' %in% names(df)){
  print('Ron is not a column name, but Cost is.')
}else{
  print('Ron and Cost are not column names')
}


# Replace NAs with median value----
summary(df$Price)
medPrice <- median(df$Price, na.rm = T)
df$Price <- ifelse(is.na(df$Price)
                        , medPrice
                        , df$Price)
summary(df$Price)



