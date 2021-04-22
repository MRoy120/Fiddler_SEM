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

rsquared(SS_Model)

## Generate a table
# Isolate only the coefficients from the PSEM output
SS_coefs <- SS_Model_Summary$coefficients

# Use kableExtra to generate and save the table
SS_coefs %>%
  kbl() %>%
  kable_classic(full_width = F, html_font = "Cambria") %>%
  save_kable("figures/SS_Table.jpeg")

##
#Side comparison for initial and final soil strength differences between sites
#Initial
summary(lm(data = combined_data_full, 
           Pre_Pene_AVG ~ Site + Year))

#Final
summary(lm(data = combined_data_full, 
           Post_Pene_AVG ~ Site + Year))

