############ READING DATA INTO R AND WRITING DATA OUT OF R #############
# Typically, you'll want to read external data into R. Storing data in a comma-
# separated values file (.csv) is one of the most common ways for storing data.

# Download the data----
# First, make sure to download the jan17Items.csv file. This file contains
# point-of-sale data for January, 2017, for a fictitious company, Larry's Commissary.
# Each row is an item of an order. There are 8,899 rows of data and 26 variables.
# If you're working on your own computer, then move the file to a location that
# makese sense for you. A good choice would be the same location of this .R file.

# For RStudio Cloud users----
# After creating a new project, and giving it a name, then click on the Upload 
# button in the Files pane. Navigate to where you’ve stored the data and then click 
# Open and then OK. After it finishes uploading, you should see the jan17Items.csv file
# among the other files.

# Read in the data using the RStudio tool----
# In the Environment pane, click on the Import Dataset. Navigate to where you
# saved the data, and double click on the file. A wizard pops up to help you import 
# the dataset. The left panel gives you options for importing the data. The Input 
# File window shows a preview of the raw data file. The Data Frame window shows 
# a preview of how the data will look in R.

# Change the Name to dfWizard, and then leave almost all of the other default options 
# the same. The only exception is to uncheck the Strings as factors box. 
# We’ll talk more about that in another lesson. Finally, click the Import button.
# Notice that the console shows the code that it used to import the file.
# Also notice that the Global Environment pane should show dfWizard as an object,
# along with the 8899 obs. of 26 variables.


# Read in the jan17Items.csv data using the R language----
# You could copy and paste the code into the script editor to try it out.
# A good idea is to organize your files into meaningful folders. For now, it makes
# sense to put the data file in the same folder as this .R file. Then, you can
# use the Files pane to navigate to the location of the jan17Items.csv file.
# Next, use the More button and select the Set As Working Directory Option.
# This makes it so that you don't have to enter the full path of the file.
# It also sets it to the default location where any data will be written.
# Alternatively, use the setwd() function and enter the folder path, such as
# '/Users/rnguymon/M1'

# Before running the read.csv function, try reading the help to see the details of how it works.
?read.csv                             

# Now, use the R language to read in the data. Notice that I've separated the
# parameters to separate lines so that I can add comments about the parameters
df <- read.csv('jan17Items.csv'        # You can also enter the full path if the file is not in the working directory
                , sep = ','             # Indicates the character that separates values
                , stringsAsFactors = F  # We'll get to this in another lesson.
                )

# Check the Environment window to make sure that df shows up there.

# Read in weather data----
# Download and read in the jan17Weather.csv file using a similar process as you used
# for the Items data. However, this file is a tab delimited file. Notice in the
# code below that the value for sep is \t rather than ,. 
dfw <- read.csv('jan17Weather.csv'
                , sep = '\t'
                , stringsAsFactors = F)

# Write data----
# Writing, or saving, data is simpler than saving data. Saving data as a .csv
# file can be done with the write.csv function. Before using it, take a look
# at the documentation. Notice that the default for the col.names parameter is
# set to TRUE, meaning that it will also include a column with the row number.
?write.csv

# Try writing the weather data
write.csv(dfw
          , 'weather2.csv'      # If you want to save to a location not in your working directly, include the full path.
          , row.names = F)      # If this is isn't set to FALSE, it will include a column with the row names.

