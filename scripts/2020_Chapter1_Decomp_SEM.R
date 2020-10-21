source("scripts/2020_Chapter1_libraries.R")
source("scripts/2020_data_cleaning.R")

#### Building Models for Decomposition SEM ####

#Burrows
Burrows_decomp_NBglm <- glm.nb(data = Decomp_2018_3, 
                                   Post_Burrow_Count ~ 
                                     Density_Num *
                                     Pre_Pene_AVG +
                                     Site +
                                     Depth,
                                   link = "log")
summary(Burrows_decomp_NBglm)

#Initial Soil Strength
Pre_Pene_decomp_lm <- lm(data = Decomp_2018_3, 
                             Pre_Pene_AVG ~
                               Site +
                               Depth
)
summary(Pre_Pene_decomp_lm)

#Decomposition
Decomp_lm <- lm(data = Decomp_2018_3,
                  End_Mass_LB ~
                    Post_Burrow_Count *
                    Depth +
                    Pre_Pene_AVG +
                    Site
)
summary(Decomp_lm)

#### Decomposition SEM ####
decomp_SEM <- psem(Pre_Pene_decomp_lm,
                   Burrows_decomp_NBglm,
                   Decomp_lm
)
summary(decomp_SEM) 

#As a side note for visreg
Decomp_2018_3 <- Decomp_2018_3 %>%
  mutate(Depth_Chr_alt = as.character(Depth))

Decomp_lm_vis <- lm(data = Decomp_2018_3,
                End_Mass_LB ~
                  Post_Burrow_Count *
                  Depth_Chr +
                  Pre_Pene_AVG +
                  Site
)
summary(Decomp_lm_vis)



