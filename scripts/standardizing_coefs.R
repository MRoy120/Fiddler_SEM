source("scripts/2020_Chapter1_libraries.R")
source("scripts/2020_data_cleaning.R") 

#### Building Models for Soil Strength SEM ####

## Final Soil Strength
Post_Pene_lm <- lm(data = combined_data_full, 
                   Post_Pene_AVG ~
                     Post_Burrow_Count + 
                     Pre_Pene_AVG +
                     Year_Fac +
                     Site *
                     Block
)
summary(Post_Pene_lm)

#Burrows
Burrows_NBglm <- glm.nb(data = combined_data_full,
                        Post_Burrow_Count ~
                          Density_Num *
                          Pre_Pene_AVG +
                          Year_Fac +
                          Site *
                          Block
                        ,
                        link = "log"
)
summary(Burrows_NBglm)

#Initial Soil Strength
Pre_Pene_lm <- lm(data = combined_data_full, 
                  Pre_Pene_AVG ~
                    Year_Fac +
                    Site *
                    Block
)
summary(Pre_Pene_lm)

#### Soil Strength Piecewise SEM ####
SS_Model <- psem(Burrows_NBglm,
                 Post_Pene_lm,
                 Pre_Pene_lm
)

#SS_Model$data

SS_Model_Summary <- summary(SS_Model)
SS_Model_Summary







coefs(Burrows_NBglm, standardize.type = "Menard.OE")

sem.coefs(SS_Model)


B <- summary(Burrows_NBglm)$coefficients[1, 3]

sd.x <- sd(combined_data_full$Post_Burrow_Count)

sd.y <- sd(combined_data_full$Density_Num)

B.sdscaled <- B * sd.x/sd.y




coefs.data <- data.frame(
  y = runif(100),
  x1 = runif(100),
  x2 = runif(100)
)

# Evaluate linear model
model <- lm(y ~ x1, coefs.data)

coefs(model, standardize = "none")

summary(model)$coefficients

coefs(model, standardize = "none", intercepts = TRUE)

B <- summary(model)$coefficients[2, 1]

sd.x <- sd(coefs.data$x1)

sd.y <- sd(coefs.data$y)

B.sdscaled <- B * sd.x/sd.y

coefs(model, standardize = "scale")




glmdat <- data.frame(x1 = runif(50), y1 = rpois(50, 10), y2 = rpois(50, 50), y3 = runif(50))

# Construct SEM
glmsem <- psem(
  glm(y1 ~ x1, "poisson", glmdat),
  glm(y2 ~ x1, "poisson", glmdat),
  lm(y3 ~ y1 + y2, glmdat)
)

summary(glmsem)






# Create fake data
set.seed(1)

data <- data.frame(
  x = runif(100),
  y1 = runif(100),
  y2 = rpois(100, 1),
  y3 = runif(100)
)

# Store in SEM list
modelList <- psem(
  lm(y1 ~ x, data),
  glm(y2 ~ x, "poisson", data),
  lm(y3 ~ y1 + y2, data),
  data
)

# Run summary
summary(modelList)

# Address conflict using conserve = T
summary(modelList, conserve = T)

# Address conflict using direction = c()
summary(modelList, direction = c("y2 <- y1"))

# Address conflict using correlated errors
modelList2 <- update(modelList, y2 %~~% y1)

summary(modelList2)

raw.dat <- read.csv("data/ecs22283-sup-0006-grace-datas1/Data_for_Examples_Revision1/Exotic_Bird_Invasions.csv")
keepvars <- c("Status", "Upland", "Migr", "Indiv")
bird.dat <- raw.dat[keepvars]

bird.mod <- glm(Status ~ Upland + Migr + Indiv,
                data = bird.dat,
                family = binomial(link = "logit"),
                na.action(na.omit))

coefs(bird.mod, standardize = "none")

unique(bird.dat$Upland)
unique(bird.dat$Migr)
unique(bird.dat$Indiv)

unique(combined_data_full$Density_Num)
unique(combined_data_full$Pre_Pene_AVG)
unique(combined_data_full$Block)
max(unique(c(combined_data_full$Density_Num)*c(combined_data_full$Pre_Pene_AVG)))
min(unique(c(combined_data_full$Site)*c(combined_data_full$Block)))

coefs(Burrows_NBglm, standardize = list(Density_Num = c(0,20), 
                                        Pre_Pene_AVG = c(0,37),
                                        Year_Fac = c(0,1),
                                        Site = c(0,1),
                                        Block = c(1, 4),
                                        `Density_Num:Pre_Pene_AVG` = c(0, 520),
                                        `Site:Block` = c(0, 4)),
      standardize.type = "latent.linear")


coefs(bird.mod, standardize = list(Upland = c(0,1), Migr = c(1,3),
                                   Indiv = c(2,1539)),
      standardize.type = "latent.linear")

#How do I calculate the standardized range coefficients using the range when I have a glm
#and interaction terms