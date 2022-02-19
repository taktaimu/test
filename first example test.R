#Using the script to understand how git and version control works


library(stringi)

set.seed(10)

Income <- rgamma(10,2000,2)
Age <- rbinom(10,100,0.2)
Gender <- stri_rand_strings(10,1,"[MF]")

#create train DF dataframe
DF <- data.frame(Age, Income, Gender)

#create holdout dataframe
DFtest <- data.frame(Income=rgamma(15,3000,2),Age=rbinom(15,90,0.4),Gender=stri_rand_strings(15,1,"[MF]"))

#GLM to predict income based on age and gender
modeltest <- glm(Income~Age+Gender, family = gaussian(link = "log"), data=DF)

#Refer to this link for understanding the summary
#https://www.statology.org/interpret-glm-output-in-r/
summary(modeltest)

#predict values from holdout
predicted_values<-predict(modeltest, DFtest, type = "response")

#compare predictions vs actual (results imply the model is under-predecting, which makes sense based on the distribution of the train data set)
#consider lift charts
predicted_values/DFtest$Income-1
