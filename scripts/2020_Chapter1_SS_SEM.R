source("scripts/2020_Chapter1_libraries.R")
source("scripts/2020_data_cleaning.R")

#### Building Models for Soil Strength SEM ####

## Final Soil Strength
Post_Pene_lm <- lm(data = combined_data_full, 
                   Post_Pene_AVG ~
                     Post_Burrow_Count + 
                     Pre_Pene_AVG +
                     Site +
                     Year_Fac
)
summary(Post_Pene_lm)

#Burrows
Burrows_NBglm <- glm.nb(data = combined_data_full,
                        Post_Burrow_Count ~
                          Density_Num *
                          Pre_Pene_AVG +
                          Site +
                          Year_Fac
                        ,
                        link = "log"
)
summary(Burrows_NBglm)

#Initial Soil Strength
Pre_Pene_lm <- lm(data = combined_data_full, 
                  Pre_Pene_AVG ~
                    Site +
                    Year_Fac
)
summary(Pre_Pene_lm)

#### Soil Strength Piecewise SEM ####
#Original Names
SS_Model <- psem(Burrows_NBglm,
                 Post_Pene_lm,
                 Pre_Pene_lm
)
summary(SS_Model)
