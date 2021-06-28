source("scripts/2020_Chapter1_libraries.R")
source("scripts/2020_data_cleaning.R")

#### Building Models for Decomposition SEM ####

## Burrows
Burrows_decomp_NBglm <- glm.nb(data = Decomp_2018_3, 
                               Post_Burrow_Count ~ 
                                 Density_Num *
                                 Pre_Pene_AVG +
                                 Site *
                                 Block,
                                   link = "log")

# Checking Model Fit and Colinearity
Decomp_Burrows_res <- simulateResiduals(Burrows_decomp_NBglm)
plot(Decomp_Burrows_res)
vif(Burrows_decomp_NBglm)
check_collinearity(Burrows_decomp_NBglm)

# Determining Relationships Between Response and Predictors
summary(Burrows_decomp_NBglm)
Anova(Burrows_decomp_NBglm)

## Initial Soil Strength
Pre_Pene_decomp_lm <- lm(data = Decomp_2018_3, 
                         Pre_Pene_AVG ~
                           Site *
                           Block
)

# Checking Model Fit and Colinearity
Decomp_pre_pene_res <- simulateResiduals(Pre_Pene_decomp_lm)
plot(Decomp_pre_pene_res)
vif(Pre_Pene_decomp_lm)
check_collinearity(Pre_Pene_decomp_lm)

# Determining Relationships Between Response and Predictors
summary(Pre_Pene_decomp_lm)
Anova(Pre_Pene_decomp_lm)

#Decomposition
Decomp_lm <- lm(data = Decomp_2018_3,
                Mass_Trans ~
                  Pre_Pene_AVG +
                  Depth *
                  Post_Burrow_Count +
                  Site *
                  Block
)

# Checking Model Fit and Colinearity
Decomp_res <- simulateResiduals(Decomp_lm)
plot(Decomp_res)
vif(Decomp_lm)
check_collinearity(Decomp_lm)

# Determining Relationships Between Response and Predictors
summary(Decomp_lm)
Anova(Decomp_lm)

#### Decomposition SEM ####
decomp_SEM <- psem(Pre_Pene_decomp_lm,
                   Burrows_decomp_NBglm, 
                   Decomp_lm
)
decomp_summary <- summary(decomp_SEM) 
decomp_summary

rsquared(decomp_SEM)

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

## Generate a table
# Isolate only the coefficients from the PSEM output
decomp_coefs <- decomp_summary$coefficients

# Use kableExtra to generate and save the table
decomp_coefs %>%
  kbl() %>%
  kable_classic(full_width = F, html_font = "Cambria") %>%
  save_kable("figures/Decomp_Table.jpeg")

