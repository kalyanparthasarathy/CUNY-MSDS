# DATA 606 Week 2 Lab 2 - Probability
# Student Name: Kalyan (Kalyanaraman Parthasarathy)

# Clear the console
cat("\014")

# Lab 2 Details
DATA606::viewLab('Lab2')
DATA606::startLab('Lab2')

#### Getting Started

load(url("http://www.openintro.org/stat/data/kobe.RData"))

head(kobe)
kobe$basket[1:9]

# Exercise 1 - What does a streak length of 1 mean, i.e. how many hits and misses are in a streak of 1? What about a streak length of 0?

# Answer:
# Streak length of 1 is a hit (into the basket) followed by a miss
# Streak length of 0 is a miss (not making to the basket) followed by another miss

kobe_streak <- calc_streak(kobe$basket)

kobe_streak_df <- as.data.frame(kobe_streak)
names(kobe_streak_df) <- c("# of Streaks")
# kobe_streak_df

barplot(table(kobe_streak), xlab='Number of Continuous Streaks', ylab='Number of Occurences', cex.axis = par("cex.axis"), beside=FALSE)


# Exercise 2 - Describe the distribution of Kobe’s streak lengths from the 2009 NBA finals. 
# What was his typical streak length? How long was his longest streak of baskets?

# Answer:
boxplot(kobe_streak_df)
nrow(as.data.frame(kobe_streak_df[kobe_streak_df$`# of Streaks` == "0",])) # 39
nrow(as.data.frame(kobe_streak_df[kobe_streak_df$`# of Streaks` == "1",])) # 24
nrow(as.data.frame(kobe_streak_df[kobe_streak_df$`# of Streaks` == "2",])) # 6
nrow(as.data.frame(kobe_streak_df[kobe_streak_df$`# of Streaks` == "3",])) # 6
nrow(as.data.frame(kobe_streak_df[kobe_streak_df$`# of Streaks` == "4",])) # 1

# The distribution is righly skewed

# Typical Streak Length is 0

max(kobe_streak)
# Longest streak length: 4

#### Simulations in R

outcomes <- c("heads", "tails")
sample(outcomes, size = 1, replace = TRUE)

sim_fair_coin <- sample(outcomes, size = 100, replace = TRUE)

sim_fair_coin

table(sim_fair_coin)

sim_unfair_coin <- sample(outcomes, size = 100, replace = TRUE, prob = c(0.2, 0.8))

table(sim_unfair_coin)


# Exercise 3 - In your simulation of flipping the unfair coin 100 times, how many flips came up heads?

# Answer:
flip_coin_df <- as.data.frame(sample(outcomes, size = 100, replace = TRUE))
names(flip_coin_df) <- c("Outcome")
nrow(as.data.frame(flip_coin_df[flip_coin_df$Outcome == "heads",])) # 54 in my R studio but it may change during RMD execution


#### Simulating the Independent Shooter

outcomes <- c("H", "M")
sim_basket <- sample(outcomes, size = 1000, replace = TRUE)
table(sim_basket)

# Exercise 4 - What change needs to be made to the sample function 
# so that it reflects a shooting percentage of 45%? 
# Make this adjustment, then run a simulation to sample 133 shots. 
# Assign the output of this simulation to a new object called sim_basket.

# Answer:
sim_basket <- sample(outcomes, size=133, replace = TRUE, prob= c(0.45, 0.55))
table(sim_basket)


### On your own

#### Comparing Kobe Bryant to the Independent Shooter

# Using `calc_streak`, compute the streak lengths of `sim_basket`.
calc_streak(sim_basket)

# Describe the distribution of streak lengths. What is the typical streak 
# length for this simulated independent shooter with a 45% shooting percentage?
# How long is the player's longest streak of baskets in 133 shots?

sim_basket_df <- as.data.frame(calc_streak(sim_basket))
names(sim_basket_df) <- c("# of Streaks")

barplot(table(sim_basket_df), xlab='Number of Continuous Streaks', ylab='Number of Occurences', cex.axis = par("cex.axis"), beside=FALSE)
nrow(as.data.frame(sim_basket_df[sim_basket_df$`# of Streaks` == "0",])) # 39
nrow(as.data.frame(sim_basket_df[sim_basket_df$`# of Streaks` == "1",])) # 24
nrow(as.data.frame(sim_basket_df[sim_basket_df$`# of Streaks` == "2",])) # 6
nrow(as.data.frame(sim_basket_df[sim_basket_df$`# of Streaks` == "3",])) # 6
nrow(as.data.frame(sim_basket_df[sim_basket_df$`# of Streaks` == "4",])) # 1
nrow(as.data.frame(sim_basket_df[sim_basket_df$`# of Streaks` == "5",])) # 1
nrow(as.data.frame(sim_basket_df[sim_basket_df$`# of Streaks` == "6",])) # 1

#1 - Describe the distribution of streak lengths
# The distribution is righly skewed

#2 - What is the typical streak length for this simulated independent shooter with a 45% shooting percentage?
# Typical streak length is 0

#3 - How long is the player's longest streak of baskets in 133 shots?
# Longest streak is 6 and it occurred one time

# If you were to run the simulation of the independent shooter a second time, 
# how would you expect its streak distribution to compare to the distribution 
# from the question above? Exactly the same? Somewhat similar? Totally 
# different? Explain your reasoning.

# Answer - The outcome will not be fixed because the simulation is picking the Hit or Miss randomly so I did not get the exact results

# How does Kobe Bryant's distribution of streak lengths compare to the 
# distribution of streak lengths for the simulated shooter? Using this 
# comparison, do you have evidence that the hot hand model fits Kobe's 
# shooting patterns? Explain.

# Answer - Kobe Bryant's distribution is also rightly skewed just like the simulation. The simulated model fits Kobe Bryant's pattern
# however the max hot hand differs - 4 for Kobe vs 6 for Simulation
