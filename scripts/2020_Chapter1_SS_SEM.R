source("scripts/2020_Chapter1_libraries.R")
source("scripts/2020_data_cleaning.R") 

#### Building Models for Soil Strength SEM ####

## Burrows
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
Burrows_Anova <- Anova(Burrows_NBglm)
waldtest(Burrows_combined_NBglm)

## Final Soil Strength
# With Burrow Density and Initial Soil Strength Interacting
# summary(lm(data = combined_data_full,
#    Post_Pene_AVG ~
#      Post_Burrow_Count *
#      Pre_Pene_AVG +
#      Year_Fac +
#      Site *
#      Block
# ))

# With no interaction
Post_Pene_lm <- lm(data = combined_data_full, 
                   Post_Pene_AVG ~
                     Post_Burrow_Count +
                     Pre_Pene_AVG +
                     Year_Fac +
                     Site *
                     Block
)
summary(Post_Pene_lm)
Final_SS_Anova <- Anova(Post_Pene_lm)

## Initial Soil Strength
Pre_Pene_lm <- lm(data = combined_data_full, 
                  Pre_Pene_AVG ~
                    Year_Fac +
                    Site *
                    Block
)
summary(Pre_Pene_lm)
Initial_SS_Anova <- Anova(Pre_Pene_lm)

#### Soil Strength Piecewise SEM ####
SS_Model <- psem(Burrows_NBglm,
                 Post_Pene_lm,
                 Pre_Pene_lm
)

#SS_Model$data

SS_Model_Summary <- summary(SS_Model)
SS_Model_Summary

# lapply(SS_Model, formula)
# 
# system.time(
#   SS_SEM_Boot <- bootEff(SS_Model, R = 10000, seed = 53908)
# )
# 
# eff <- suppressWarnings(semEff(SS_SEM_Boot))
# 
# eff$Summary$Post_Pene_lm

rsquared(SS_Model)
basisSet(SS_Model)

## Generate a table
# Isolate only the coefficients from the PSEM output
SS_coefs <- SS_Model_Summary$coefficients

###
Initial_SS_Anova_2 <- Initial_SS_Anova %>%
  as.data.frame() %>%
  mutate(Predictor = rownames(Initial_SS_Anova),
         Response = "Initial Soil Str.") %>%
  na.omit() %>%
  dplyr::select(Predictor, Response, `Sum Sq`, Df, `F value`, `Pr(>F)`)

Initial_SS_Anova_3 <- Initial_SS_Anova_2 %>%
  mutate(`p-Value` = round(Initial_SS_Anova_2$`Pr(>F)`, digits = 5),
         `F Value` = round(Initial_SS_Anova_2$`F value`, digits = 2),
         `Sums Sq` = round(Initial_SS_Anova_2$`Sum Sq`, digits = 2)) %>%
  mutate(Predictor = c("Year", "Site",
                       "Block", "Site-Block Interact.")) %>%
  dplyr::select(Predictor, Response, `Sums Sq`, Df, `F Value`, `p-Value`)

###
Final_SS_Anova_2 <- Final_SS_Anova %>%
  as.data.frame() %>%
  mutate(Predictor = rownames(Final_SS_Anova),
         Response = "Final Soil Str.") %>%
  na.omit() %>%
  dplyr::select(Predictor, Response, `Sum Sq`, Df, `F value`, `Pr(>F)`)

Final_SS_Anova_3 <- Final_SS_Anova_2 %>%
  mutate(`p-Value` = round(Final_SS_Anova_2$`Pr(>F)`, digits = 5),
         `F Value` = round(Final_SS_Anova_2$`F value`, digits = 2),
         `Sums Sq` = round(Final_SS_Anova_2$`Sum Sq`, digits = 2)) %>%
  mutate(Predictor = c("Burrow Density", "Initial Soil Str", "Year", "Site",
                       "Block", "Site-Block Interact.")) %>%
  dplyr::select(Predictor, Response, `Sums Sq`, Df, `F Value`, `p-Value`)

###
SS_Anova <- full_join(Initial_SS_Anova_3, Final_SS_Anova_3)

###
Burrows_Anova_2 <- Burrows_Anova %>%
  as.data.frame() %>%
  mutate(Predictor = rownames(Burrows_Anova),
         Response = "Burrow Density") %>%
  na.omit() %>%
  dplyr::select(Predictor, Response, `LR Chisq`, Df, `Pr(>Chisq)`)

Final_SS_Anova_3 <- Burrows_Anova_2 %>%
  dplyr::mutate(`p-Value` = round(Burrows_Anova_2$`Pr(>Chisq)`, digits = 5),
         `LR Chisq` = round(Burrows_Anova_2$`LR Chisq`, digits = 2)) %>%
  mutate(Predictor = c("Initial Crab Dens.", "Initial Soil Str", "Year", "Site",
                       "Block", "Crab Dens-Soil\\nStr. Interact", "Site-Block Interact.")) %>%
  dplyr::select(Predictor, Response, `LR Chisq`, Df, `p-Value`)

# Use kableExtra to generate and save the table
SS_coefs %>%
  kbl() %>%
  kable_classic(full_width = F, html_font = "Cambria") %>%
  save_kable("figures/SS_Table.jpeg")

SS_Anova %>%
  kbl() %>%
  kable_paper(full_width = T, 
                html_font = "Arial", 
                font_size = 30,
                position = "left") %>%
  save_kable("figures/SS_Table_2.jpeg",
             density = 500)

##
#Side comparison for initial and final soil strength differences between sites
#Initial
summary(lm(data = combined_data_full, 
           Pre_Pene_AVG ~ Site + Year))

#Final
summary(lm(data = combined_data_full, 
           Post_Pene_AVG ~ Site + Year))






