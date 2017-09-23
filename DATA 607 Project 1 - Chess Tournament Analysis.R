# Clear the console
cat("\014")

# Check if the package is installed. If not, install the package
if(!require('stringr')) {
  install.packages('stringr')
  library(stringr)
}

# Check if the package is installed. If not, install the package
if(!require('data.table')) {
  install.packages('data.table')
  library(data.table)
}


# Check if the package is installed. If not, install the package
if(!require('taRifx')) {
  install.packages('taRifx')
  library(taRifx)
}

first_time = 1

fileName <- "https://raw.githubusercontent.com/kalyanparthasarathy/CUNY-MSDS/master/tournamentinfo.txt"

conn <- file(fileName,open="r")

linesFromFile <-readLines(conn)

for (i in 5:length(linesFromFile)){
  if( ( (i-5) %% 3) == 0) {
    # Data resides in two lines so we need to combine both lines into single DF and look for the interested columns
    
    # Parse the first line of text (here the first line is the Name line)
    readLine1 <- linesFromFile[i]
    
    # IMPORTANT - Limitation of sub() function with back referencing of RegEx values
    # Only 9 values can be back referenced so need to do two step split for each line of data
    firstTwoColsLine1 <- unlist(
      sub(
        "(.*)\\|(.*)\\|(.*)\\|(.*)\\|(.*)\\|(.*)\\|(.*)\\|(.*)\\|(.*)\\|$"
        , "\\1"
        , readLine1
      )
    )
    
    remainingColsLine1 <- unlist(
      sub(
        "(.*)\\|(.*)\\|(.*)\\|(.*)\\|(.*)\\|(.*)\\|(.*)\\|(.*)\\|(.*)\\|$"
        , "\\2,\\3,\\4,\\5,\\6,\\7,\\8,\\9"
        , readLine1
      )
    )
    
    firstTwoColsLine1 <- unlist(
      sub(
        "(.*)\\|(.*)$"
        , "\\1,\\2"
        , firstTwoColsLine1
      )
    )
    
    parsedLine1 <- paste(firstTwoColsLine1, ",", remainingColsLine1)
    rawDataDF1 <- data.frame(parsedLine1)
    
    names(rawDataDF1) <- c("Data")
    
    out <- strsplit(as.character(rawDataDF1$Data),',')
    rawDataDF1 <- data.frame(rawDataDF1$Data, do.call(rbind, out))
    rawDataDF1$rawDataDF1.Data <- NULL
    names(rawDataDF1) <- c("C1", "C2", "C3", "C4", "C5", "C6", "C7", "C8", "C9", "C10")
    
    # Parse the first line of text (here the first line is the Name line)
    readLine2 <- linesFromFile[i+1]
    
    # IMPORTANT - Limitation of sub() function with back referencing of RegEx values
    # Only 9 values can be back referenced so need to do two step split for each line of data
    firstTwoColsLine2 <- unlist(
      sub(
        "(.*)\\|(.*)\\|(.*)\\|(.*)\\|(.*)\\|(.*)\\|(.*)\\|(.*)\\|(.*)\\|$"
        , "\\1"
        , readLine2
      )
    )
    
    remainingColsLine2 <- unlist(
      sub(
        "(.*)\\|(.*)\\|(.*)\\|(.*)\\|(.*)\\|(.*)\\|(.*)\\|(.*)\\|(.*)\\|$"
        , "\\2,\\3,\\4,\\5,\\6,\\7,\\8,\\9"
        , readLine2
      )
    )
    
    firstTwoColsLine2 <- unlist(
      sub(
        "(.*)\\|(.*)$"
        , "\\1,\\2"
        , firstTwoColsLine2
      )
    )
    
    parsedLine2 <- paste(firstTwoColsLine2, ",", remainingColsLine2)
    rawDataDF2 <- data.frame(parsedLine2)
    
    names(rawDataDF2) <- c("Data")
    
    out <- strsplit(as.character(rawDataDF2$Data),',')
    rawDataDF2 <- data.frame(rawDataDF2$Data, do.call(rbind, out))
    rawDataDF2$rawDataDF2.Data <- NULL
    names(rawDataDF2) <- c("C11", "C12", "C13", "C14", "C15", "C16", "C17", "C18", "C19", "C20")
    
    if(first_time == 1) {
      first_time = 2
      
      allDataDF1 <- rawDataDF1
      allDataDF2 <- rawDataDF2
    }
    else {
      # Merge each row of data into the allDataDF1 & allDataDF2
      allDataDF1 <- rbind(allDataDF1, rawDataDF1)
      allDataDF2 <- rbind(allDataDF2, rawDataDF2)
    }
  }
}
close(conn)

# Merge both lines of data into sinlge DF
allDataDF <- cbind(allDataDF1, allDataDF2)

# Format the Column 1 - Position - This information is needed to calculate "Avg Pre Chess Rating of Opponents" value
allDataDF$C1 <- sub("[[:space:]]+?([[:digit:]]{1,}).*", "\\1", allDataDF$C1)

# Format the Column 2 - Name
allDataDF$C2 <- tools::toTitleCase(tolower(str_trim(unlist(sub("[[:space:]]+?([[:alpha:]] )+[[:space:]]+", "\\1", allDataDF$C2)))))

# Format the Column 3 - Total Number of Points
allDataDF$C3 <- str_trim(unlist(sub("[[:space:]]+?([[:alpha:]] )+[[:space:]]+", "\\1", allDataDF$C3)))

# Format the Column 4 - Round 1
allDataDF$C4 <- str_trim(unlist(sub("[[:alnum:]][[:space:]]+([[:digit:]]+)", "\\1", allDataDF$C4)))
# If the value has "Alphabet", change to 0, value is missing for this cell
allDataDF$C4 <- sub("[[:alpha:]]+", "0", allDataDF$C4)


# Format the Column 5 - Round 2
allDataDF$C5 <- str_trim(unlist(sub("[[:alnum:]][[:space:]]+([[:digit:]]+)", "\\1", allDataDF$C5)))
# If the value has "Alphabet", change to 0, value is missing for this cell
allDataDF$C5 <- sub("[[:alpha:]]+", "0", allDataDF$C5)

# Format the Column 6 - Round 3
allDataDF$C6 <- str_trim(unlist(sub("[[:alnum:]][[:space:]]+([[:digit:]]+)", "\\1", allDataDF$C6)))
# If the value has "Alphabet", change to 0, value is missing for this cell
allDataDF$C6 <- sub("[[:alpha:]]+", "0", allDataDF$C6)

# Format the Column 7 - Round 4
allDataDF$C7 <- str_trim(unlist(sub("[[:alnum:]][[:space:]]+([[:digit:]]+)", "\\1", allDataDF$C7)))
# If the value has "Alphabet", change to 0, value is missing for this cell
allDataDF$C7 <- sub("[[:alpha:]]+", "0", allDataDF$C7)

# Format the Column 8 - Round 5
allDataDF$C8 <- str_trim(unlist(sub("[[:alnum:]][[:space:]]+([[:digit:]]+)", "\\1", allDataDF$C8)))
# If the value has "Alphabet", change to 0, value is missing for this cell
allDataDF$C8 <- sub("[[:alpha:]]+", "0", allDataDF$C8)

# Format the Column 9 - Round 6
allDataDF$C9 <- str_trim(unlist(sub("[[:alnum:]][[:space:]]+([[:digit:]]+)", "\\1", allDataDF$C9)))
# If the value has "Alphabet", change to 0, value is missing for this cell
allDataDF$C9 <- sub("[[:alpha:]]+", "0", allDataDF$C9)

# Format the Column 10 - Round 7
allDataDF$C10 <- str_trim(unlist(sub("[[:alnum:]][[:space:]]+([[:digit:]]+)", "\\1", allDataDF$C10)))
# If the value has "Alphabet", change to 0, value is missing for this cell
allDataDF$C10 <- sub("[[:alpha:]]+", "0", allDataDF$C10)

# Format the Column 11 - State
allDataDF$C11 <- str_trim(unlist(sub("[[:space:]]+?([[:alpha:]] )+[[:space:]]+", "\\1", allDataDF$C11)))

# Format the Column 12 - Pre-rating
allDataDF$C12 <- str_trim(allDataDF$C12)
allDataDF$C12 <- str_trim(unlist(sub("[[:digit:]]+[[:space:]].[[:space:]]R:[[:space:]]+?([[:alnum:]]+)[[:space:]]{0,1}.*", "\\1", allDataDF$C12)))
allDataDF$C12 <- unlist(sub("([[:digit:]]+)[[:alpha:]][[:digit:]]+", "\\1", allDataDF$C12)) # Remove the values from "P", if anything exists

# Extract only the columns we are interested in
allDataDFNew <- allDataDF[, c(1, 2, 11, 3, 12, 4, 5, 6, 7, 8, 9, 10)]

# Add a new column for the Average Score
allDataDFNew$'Avg Score' <- 0

names(allDataDFNew) <- c("SNo", "Player's Name", "Player's State", "Total Number of Points", "Player's Pre-Rating", "Opp 1", "Opp 2", "Opp 3", "Opp 4", "Opp 5", "Opp 6", "Opp 7", "Average Pre Chess Rating of Opponents")

# Calculate "Average Pre Chess Rating of Opponents"
for (i in 1:nrow(allDataDFNew)) {
  totalRounds <- as.integer(7)
  totalOppScore <- as.integer(0)
  
  # Opponent 1
  if(unlist(as.integer(allDataDFNew$`Opp 1`[i])) == 0) totalRounds = totalRounds - 1 else totalOppScore = totalOppScore + as.integer(unlist(allDataDFNew$`Player's Pre-Rating`[as.integer(allDataDFNew$`Opp 1`[i])]))

  # Opponent 2
  if(unlist(as.integer(allDataDFNew$`Opp 2`[i])) == 0) totalRounds = totalRounds - 1 else totalOppScore = totalOppScore + as.integer(unlist(allDataDFNew$`Player's Pre-Rating`[as.integer(allDataDFNew$`Opp 2`[i])]))

  # Opponent 3
  if(unlist(as.integer(allDataDFNew$`Opp 3`[i])) == 0) totalRounds = totalRounds - 1 else totalOppScore = totalOppScore + as.integer(unlist(allDataDFNew$`Player's Pre-Rating`[as.integer(allDataDFNew$`Opp 3`[i])]))

  # Opponent 4
  if(unlist(as.integer(allDataDFNew$`Opp 4`[i])) == 0) totalRounds = totalRounds - 1 else totalOppScore = totalOppScore + as.integer(unlist(allDataDFNew$`Player's Pre-Rating`[as.integer(allDataDFNew$`Opp 4`[i])]))

  # Opponent 5
  if(unlist(as.integer(allDataDFNew$`Opp 5`[i])) == 0) totalRounds = totalRounds - 1 else totalOppScore = totalOppScore + as.integer(unlist(allDataDFNew$`Player's Pre-Rating`[as.integer(allDataDFNew$`Opp 5`[i])]))

  # Opponent 6
  if(unlist(as.integer(allDataDFNew$`Opp 6`[i])) == 0) totalRounds = totalRounds - 1 else totalOppScore = totalOppScore + as.integer(unlist(allDataDFNew$`Player's Pre-Rating`[as.integer(allDataDFNew$`Opp 6`[i])]))

  # Opponent 7
  if(unlist(as.integer(allDataDFNew$`Opp 7`[i])) == 0) totalRounds = totalRounds - 1 else totalOppScore = totalOppScore + as.integer(unlist(allDataDFNew$`Player's Pre-Rating`[as.integer(allDataDFNew$`Opp 7`[i])]))

  allDataDFNew$`Average Pre Chess Rating of Opponents`[i] = round(totalOppScore/totalRounds, digits=0)
  
}

# Copy only the required columns and create a new Dataframe for final output
allDataDFFinal <- allDataDFNew[, c(2, 3, 4, 5, 13)]

# This is the final formatted and calculated data in a Dataframe.
allDataDFFinal

# Write to a CSV file
write.csv(allDataDFFinal, file = "DATA607_Project_1_output.csv")

