# DATA 606 Week 2 Assignment - Probability
# Student Name: Kalyan (Kalyanaraman Parthasarathy)

# Clear the console
cat("\014")

# Check if the package is installed. If not, install the package
if(!require('VennDiagram')) {
  install.packages('VennDiagram')
}


belowPL <- 0.146
nonEnglishSpeaking <- 0.207
bothCategories <- 0.042

grid.newpage()
draw.pairwise.venn(
                    area1 = belowPL, area2 = nonEnglishSpeaking, 
                    cross.area = bothCategories, category = c("Below Poverty Line", "Foreign Language Speakers")
                    , lty = rep("blank", 2), fill = c("light blue", "yellow"), alpha = rep(0.5, 2)
                    , cat.pos = c(0, 0), cat.dist = rep(0.025, 2)
                  )

# Question 2.20

assortiveMatingStats <- read.csv("https://raw.githubusercontent.com/jbryer/DATA606Fall2016/master/Data/Data%20from%20openintro.org/Ch%202%20Exercise%20Data/assortive_mating.csv")
table(assortiveMatingStats)

# (a) What is the probability that a randomly chosen male respondent or his partner has blue eyes?
# P(Male Blue or Female Blue) = P(Male Blue) + P(Female Blue) - ( P(Male Blue total) + P(Female Blue Total) )
((sum(assortiveMatingStats$self_male =="blue")/nrow(assortiveMatingStats)) + (sum(assortiveMatingStats$partner_female =="blue")/nrow(assortiveMatingStats)))
  - (sum(assortiveMatingStats$self_male =="blue" & assortiveMatingStats$partner_female=="blue")/nrow(assortiveMatingStats))

# (b) What is the probability that a randomly chosen male respondent with blue eyes has a partner with blue eyes?
# P(Male Blue and Female Blue)
(sum(assortiveMatingStats$self_male =="blue" & assortiveMatingStats$partner_female=="blue")/nrow(assortiveMatingStats))

# (c) What is the probability that a randomly chosen male respondent with brown eyes has a partner with blue eyes? 
# P(male Brown and Female Blue) = P(Male Brown) + P(Female Blue)
( sum(assortiveMatingStats$self_male =="brown" & assortiveMatingStats$partner_female == "blue") / nrow(assortiveMatingStats) )/( sum(assortiveMatingStats$self_male =="brown") / nrow(assortiveMatingStats) )

# What about the probability of a randomly chosen male respondent with green eyes having a partner with blue eyes?
( sum(assortiveMatingStats$self_male =="green" & assortiveMatingStats$partner_female == "blue") / nrow(assortiveMatingStats) )/( sum(assortiveMatingStats$self_male =="green") / nrow(assortiveMatingStats) )

# (d) Does it appear that the eye colors of male respondents and their partners are independent? Explain your reasoning.
(sum(assortiveMatingStats$self_male =="blue" & assortiveMatingStats$partner_female=="blue")/nrow(assortiveMatingStats)) # Blue Male with Blue Female
(sum(assortiveMatingStats$self_male =="blue")/nrow(assortiveMatingStats)) # Blue Male ratio
# No, they are not independent. Probability of men with blue eyes are not equal to the female partners.


### Question 2.30

books <- read.csv("https://raw.githubusercontent.com/jbryer/DATA606Fall2016/master/Data/Data%20from%20openintro.org/Ch%202%20Exercise%20Data/books.csv")
table(books)

# (a) Find the probability of drawing a hardcover book first then a paperback fiction book second when drawing without replacement.
(sum(books$format == "hardcover")/nrow(books)) * (sum(books$format == "paperback" & books$type == "fiction")/(nrow(books)-1) )

# (b) Determine the probability of drawing a fiction book first and then a hardcover book second, when drawing without replacement.
(sum(books$type == "fiction")/nrow(books)) * (sum(books$format == "hardcover")/(nrow(books)-1) )

# (c) Calculate the probability of the scenario in part (b), except this time complete the calculations 
# under the scenario where the first book is placed back on the bookcase before randomly drawing the second book.
(sum(books$type == "fiction")/nrow(books)) * (sum(books$format == "hardcover")/nrow(books) )

# (d) The final answers to parts (b) and (c) are very similar. Explain why this is the case.
# Because the difference in the number of books is only one which is very small number compared to the total books size 95



### Question 2.38

# 2.38 Baggage fees. An airline charges the following baggage fees: $25 for the first bag and $35 for the second. 
# Suppose 54% of passengers have no checked luggage, 34% have one piece of checked luggage and 12% have two pieces. 
# We suppose a negligible portion of people check more than two bags.

baggageCharge <- c(0, 25, 70)
probBags <- c(0.54, 0.34, 0.12)
baggageDF <- data.frame(baggageCharge, probBags)
names(baggageDF) <- c("Charge", "Probability")
baggageDF


# (a) Build a probability model, compute the average revenue per passenger, and compute the corresponding standard deviation.
# Average Revenue per Passenger
averageRevenue <- (sum((baggageDF$Charge * baggageDF$Probability)))
averageRevenue


### Question 2.44

# 2.44 The relative frequency table below displays the distribution of annual total personal income 
# (in 2009 inflation-adjusted dollars) for a representative sample of 96,420,486 Americans. 
# These data come from the American Community Survey for 2005-2009. 
# This sample is comprised of 59% males and 41% females.

# (a) Describe the distribution of total personal income.

annualIncome <- c(
                  "$1 to $9,999"
                  ,"$10,000 to $14,999"
                  ,"$15,000 to $24,999"
                  ,"$25,000 to $34,999"
                  ,"$35,000 to $49,999"
                  ,"$50,000 to $64,999"
                  ,"$65,000 to $74,999"
                  ,"$75,000 to $99,999"
                  ,"$100,000 or more"
                )
populationTotal <- c(
                    2.2
                    ,4.7
                    ,15.8
                    ,18.3
                    ,21.2
                    ,13.9
                    ,5.8
                    ,8.4
                    ,9.7
                  )

incomePopulationDF <- data.frame(annualIncome, populationTotal)
incomePopulationDF

barplot(incomePopulationDF$populationTotal, main="Income Distribution", xlab="% of Population")

(2.2 + 4.7 + 15.8 + 18.3 + 21.2) / 100
