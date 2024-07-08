####################################################################
# This script accompanies the Introduction to R workshop presented #
# at the Summer Student Rounds at Rotman Research Institute on     #
# July 5, 2024.                                                    #
# This script is written by Mrinmayi Kulkarni.                     #
####################################################################

########### Section 2: Variables + Data Types + Functions ##########

###### Try some stuff with numeric variables
# Create two variables with values 2 and 4
x <- 2 # <- is an assignment operator. It is the same as =
y <- 4
# What type is variable x?
class(x)
# Add them up
x + y
# Multiply them
x * y
# Take the square root of y
sqrt(y) #sqrt() is a built in function
# Commands can be nested
# For instance, this:
z = x + y
sqrt(z)
# is equivalent to this:
sqrt(x + y)

###### Try some stuff with character variables
a <- "Hello"
b <- "World"
# What type is variable a?
class(a)
# Concatenate the two strings
paste(a, b) # Default separator is a space
paste(a, b, sep = "_") # Separators can be changed

###### Try some stuff with logical variables
# Is 1 less than 2?
c <- 1 < 2
# Is 1 greater than 2?
d <- 1 > 2
# Is the value in variable a equal to the value in variable b?
e <- a == b
# What type is variable c?
class(c)

# EXERCISE: Calculate the area of a circle based on the radius and
# print out "The area of a circle with radius XXX is XXXX"
# HINT: The formula for calculating the area of a circle is pi * r-squared
# HINT: R has a built-in variable called "pi" that stores the value of pi

##################### Section 3: Data Wrangling ####################
###### Vectors
# Create a vector
numvec <- c(10, 11, 12, 13)
charvec <- c("a", "b", "c", "d")
# What type are variables numvec and charvec?

# Select the first element of the vector
numvec[1]
# Select first two elements
numvec[c(1, 2)]
# Get the length of the vector
length(numvec)
# Append to the vector
numvec <- c(numvec, 14)
# EXERCISE: What happens when you try to add a character element to numvec?

###### Matrices
# Define a matrix
mat <- matrix(11:25, nrow = 3, ncol = 5)
# What type is variable mat?
class(mat)
# What is the length of the matrix?
length(mat) # A matrix is just a special vector!
# What are the dimensions of this matrix?
dim(mat)
mat[1, 2]
mat[4] # A matrix is just a special vector!

###### Lists
# Define a list
mylist <- list(11, 12, "a", "b", TRUE)
# What type is the variable mylist?
class(mylist)
# Select the first element of the list
mylist[1]
# What type is the first element?
class(mylist[1])
# How about this?
class(mylist[[1]])
# More complicated lists!
nestedlist <- list("numericvector" = numvec,
                   "charactervector" = charvec,
                   a,
                   x)
# Access list elements using the name or the index
nestedlist$numericvector
nestedlist[1]

###### Data frames
df <- data.frame("Numbers" = 11:25,
                 "Letters" = letters[1:15])
# Work with some real (fake) data!
# Define a variable with the path to the folder
#DataPath_Mac <- "~/Downloads/IntroToR-main/"
#DataPath <- "C:\Users\[USER_NAME]\Downloads\"
# Read in Test phase data
TestData <- read.csv(paste0(DataPath, "TestData.csv"))
# Look at the data
View(TestData)

# Extract the value in the first column, under the column called "Trial"
# This is the second column
TestData[1, 2]
# This is the same as:
TestData[1, "Trial"]

# Select all columns from the first row
TestData[1, ]
# Select the first 10 rows and all columns
TestData[1:10, ]
# Select all rows from the first column
TestData[, 1]
# This is the same as:
TestData[, "Participant"]
# Which is the same as:
TestData$Participant

# Select rows from TestData corresponding to sub-001's data
Participant1Data <- TestData[TestData$Participant == "sub-001", ]


# Load a library to help with data wrangling
library(dplyr)
AccuracyData <- TestData %>% 
  select(Accuracy)
Participant1Data <- Data %>% 
  filter(Participant == "sub-001")

###### Summarise data
# Get average accuracy and RT per participant
SummaryData <- TestData %>% 
  group_by(Participant) %>% 
  summarise(MeanRT = mean(RT),
            SD = sd(RT),
            NumberCorrect = sum(Accuracy),
            TotalTrials = length(Participant),
            PercentAccuracy = (NumberCorrect/TotalTrials)*100)

# EXERCISE: Get average accuracy and RT per participant, separately
# for concrete and abstract trials.

###### Plot data
library(ggpubr)
RTPlot <- ggbarplot(data = SummaryData,
                    x = "Condition",
                    y = "MeanRT",
                    add = "mean_se")
# EXERCISE: Plot average accuracy in the two conditions

###################### Section 4: Control Flow #####################

# if/else statement to check if a number is even or odd
NumToCheck <- 3
if(NumToCheck%%2 == 0){
  print(paste(NumToCheck, "is an even number."))
}else if(NumToCheck%%2 == 1){
  print(paste(NumToCheck, "is an odd number."))
}

# EXERCISE: Define a numeric vector. Then write an if/else statement 
# to check whether a new variable is of type numeric. If it is, append
# that variable to the vector. If it is not numeric, print a warning,
# but leave the vector unchanged

# loop through participant IDs and read in each participant's test 
# phase data
Participants <- sprintf("sub-0%02s", 1:20)
for(participant in Participants){
  # Read in this participant's data
  PartData <- read.csv(paste0(DataPath, participant, "_TestData.csv"))
}

# EXERCISE: Loop through an array of 10 numbers. For each number, check
# whether it is odd or even, and print out whether each one is odd or even


