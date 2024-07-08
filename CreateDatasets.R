####################################################################
# This script accompanies the Introduction to R workshop presented #
# at the Summer Student Rounds at Rotman Research Institute on     #
# July 5, 2024.                                                    #
# This script is written by Mrinmayi Kulkarni.                     #
####################################################################

# Set seed so results replicate
set.seed(1)

NumTrialsPerCond <- 50
ConcreteNouns <- c(
  "Apple", "Car", "House", "Tree", "Dog", 
  "Computer", "Chair", "Book", "Table", "River", 
  "Mountain", "Phone", "Beach", "Garden", "Bridge", 
  "Train", "School", "Window", "Camera", "Road", 
  "Boat", "Lamp", "Hospital", "Shoe", "Park"
)
AbstractNouns <- c(
  "Love", "Freedom", "Happiness", "Courage", "Wisdom", 
  "Success", "Honesty", "Compassion", "Integrity", "Knowledge", 
  "Peace", "Justice", "Patience", "Ambition", "Creativity", 
  "Friendship", "Hope", "Loyalty", "Respect", "Trust", 
  "Determination", "Faith", "Generosity", "Humility", "Gratitude"
)

Participants <- sprintf("sub-0%02s", 1:20)
DataPath <- "~/Google Drive/My Drive/Mrinmayi/Personal/Talks/202407_RRIIntroToRWorkshop/IntroToR/"

TestData <- lapply(Participants,
                   function(x) {
                     
                     NumAbstractCorrect = round(runif(n = 1, 
                                                      min = NumTrialsPerCond-7, 
                                                      max = NumTrialsPerCond), 
                                                digits = 0)
                     NumConcreteCorrect = round(runif(n = 1, 
                                                      min = NumTrialsPerCond-15, 
                                                      max = NumTrialsPerCond-8),
                                                digits = 0)
                     
                     DataSet <- data.frame(Participant = x,
                                           Trial = sample(1:(NumTrialsPerCond*2)),
                                           Stimulus = c(sample(AbstractNouns),
                                                        sample(ConcreteNouns)),
                                           Condition = c(rep("Abstract", NumTrialsPerCond),
                                                         rep("Concrete", NumTrialsPerCond)),
                                           TrialType = sample(c(rep("Old", 25),
                                                                rep("New", 25))),
                                           Accuracy = c(rep(1, NumAbstractCorrect), 
                                                        rep(0, NumTrialsPerCond-NumAbstractCorrect),
                                                        rep(1, NumConcreteCorrect), 
                                                        rep(0, NumTrialsPerCond-NumConcreteCorrect)),
                                           RT = c(rnorm(NumTrialsPerCond, 560, 200),
                                                  rnorm(NumTrialsPerCond, 490, 200))
                     )
                     
                     DataSet <- DataSet[order(DataSet$Trial),]
                   })

TestData <- do.call(rbind, TestData)

write.csv(TestData, 
          paste0(DataPath, "TestData.csv"),
          row.names = FALSE)

lapply(Participants, function(x){
  write.csv(TestData[TestData$Participant == x,],
            paste0(DataPath, x, "_TestData.csv"))
})
