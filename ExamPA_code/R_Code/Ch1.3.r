# CHUNK
install.packages("dplyr")
library("dplyr")

x <- c(1:8)
name <- c("Embryo Luo", "", "Peter Smith", NA,"Angela Peterson", "Emily Johnston", "Barbara Scott", "Benjamin Eng")

gender <- c("M","F","M","F","F","F","?","M")

age <- c(-1, 25, 22, 50, 30, 42, 29, 36)

exams <- c(10, 3, 0, 4, 6, 7, 5, 9)

Q1 <- c(10, NA, 4, 7, 8, 9, 8, 7)

Q2 <- c(9, 9, 5, 7, 8, 10, 9, 8)

Q3 <- c(9, 7, 5, 8, 10, 10, 7, 8)

salary <- c(300000, NA, 80000, NA, NA, NA, NA, NA)

# working with the dataset
actuary <- data.frame(x, name, gender, age, exams, Q1, Q2, Q3, salary,
                      stringsAsFactors = TRUE)
actuary$x  <- NULL
actuary$salary <- NULL
actuary$gender <- factor(actuary$gender,levels = c("M","F","?"))

#actuary[!(is.na(actuary$Q1) | is.na(actuary$name)),]
actuary.n <- na.omit(actuary)
#actuary$S = (actuary$Q1 +actuary$Q2 +actuary$Q3)/3
actuary.n$S <- apply(actuary.n[,c("Q1","Q2","Q3")], 1, mean)
relocate(actuary.n,S,.after = exams)
actuary.n %>% relocate(S,.after = age)
actuary.n

# mean of Q1 Q2 and Q3
mean_of_all_actuary <- apply(actuary.n[,c("Q1","Q2","Q3")], 2, mean)
mean_of_all_actuary 

#get best and worst acturay
actuary.n[which.max(actuary.n$S),]
actuary.n[which.min(actuary.n$S),]
actuary.n <- actuary.n[order(actuary.n$gender,actuary.n$S, decreasing = TRUE),]
actuary.n

#get FSA and ASA
actuary.FSA <- actuary..n[actuary.n$exams >=7 & actuary.n$exams <= 9]

#Ex 1.3.2
actuary.reduced <- actuary.n[actuary.n$gender == "M" | (actuary.n$exams >=7 & actuary.n$exams <= 9), ]
actuary.reduced <- actuary.reduced[order(actuary.reduced$exams, decreasing = TRUE),]
actuary.reduced

#Task 4(b)
actuary.n$title <- ifelse(actuary.n$exams ==10, "FSA",ifelse(actuary.n$exams >= 7 & actuary.n$exams <= 9,"ASA","Student"))
actuary.n

#Task 5
actuary.n <- actuary.n[order(rownames(actuary.n),decreasing = FALSE),]
actuary.n
new <- data.frame(smoke = c("N", "N", "Y", "Y","N","N","N","Y"),
                  weight = c(70, 65, 60, 90, 60, 55, 50, 75))
rows_to_extract = new[as.numeric(c(rownames(actuary.n))),]

actuary.n <- cbind(actuary.n,rows_to_extract)
actuary.n

#Task 6
actuary.n$genderSmoke <- paste0(actuary.n$gender,actuary.n$smoke)
actuary.n

#Exercise 1.3.3
text = paste0("Q",c(1,2,3))
actuary.n$S.new <- apply(actuary.n[,text], 1, mean)
actuary.n

#1.4
psum <- function(x) {
    s = 0
    for ( i in 1:x) {
       s <- s + i
    }
    return (s)
}
result = psum(10)
result

#1.4 chunk3
set.seed(0)
num_of_samples <- 100
num_of_simulations <- 1000
standard_deviation <- 2
sd_of_distribution  <- standard_deviation/sqrt(num_of_samples)
mu <- 5
count <- rep(NA,1000)
for (i in 1:num_of_simulations) {
    sigma <- mean(rnorm(num_of_samples,mean = mu,sd = standard_deviation))
    count[i] <- ((sigma <= mu + qnorm(0.975)*sd_of_distribution) & (sigma >= mu - qnorm(0.975)*sd_of_distribution))
}

mean(count)

#1.5.1
set.seed(1)
dat <- data.frame(result = rnorm(30,mean = 5, sd = 1), row.names = NULL, check.rows = FALSE, check.names = TRUE, stringsAsFactors = default.stringsAsFactors())
dat
partition <- 1:nrow(dat)
set.seed(2)
row <- sample(partition, size = 0.7*nrow(dat), replace = FALSE, prob = NULL)
dat.train <- dat[row,]
dat.test <- dat[-row,]
dat.train
dat.test

#1.5.2

