source("scripts/2020_Chapter1_libraries.R")
source("scripts/2020_data_cleaning.R")

#### Piecewise (Local) SEM for Primary Production####
### Building the Models
## Burrow Density
Burrows_combined_NBglm <- glm.nb(data = combined_data_full,
                                 Post_Burrow_Count ~ 
                                   Density_Num *
                                   Pre_Pene_AVG +
                                   Year_Fac +
                                   Site *
                                   Block
                                 ,
                                 link = "log"
)

# Checking Model Fit and Colinearity
Burrows_res <- simulateResiduals(Burrows_combined_NBglm)
plot(Burrows_res)
vif(Burrows_combined_NBglm)
check_collinearity(Burrows_combined_NBglm)

# Testing fitted versus raw data curves
ggplot(data=combined_data_full,
       mapping=aes(x=Post_Burrow_Count)) +
  geom_density(color = "blue", size = 2) +
  geom_density(data = data.frame(f = fitted(Burrows_combined_NBglm)),
               aes(x = f))

# Determining Relationships Between Response and Predictors
summary(Burrows_combined_NBglm)
Anova(Burrows_combined_NBglm)

## Initial Soil Strength
Pre_Pene_combined_lm <- lm(data = combined_data_full, 
                           Pre_Pene_AVG ~
                             Year_Fac +
                             Site *
                             Block
)

# Checking Model Fit and Colinearity
pre_pene_res <- simulateResiduals(Pre_Pene_combined_lm)
plot(pre_pene_res)
vif(Pre_Pene_combined_lm)
check_collinearity(Pre_Pene_combined_lm)

# Determining Relationships Between Response and Predictors
summary(Pre_Pene_combined_lm)
Anova(Pre_Pene_combined_lm)

## Final Soil  Strength
Post_Pene_combined_lm <- lm(data = combined_data_full, 
                            Post_Pene_AVG ~ 
                              Post_Burrow_Count + 
                              Pre_Pene_AVG +
                              Year_Fac +
                              Pre_Live_SD +
                              Site *
                              Block
)

# Checking Model Fit and Colinearity
Post_pene_res <- simulateResiduals(Post_Pene_combined_lm)
plot(Post_pene_res)
vif(Post_Pene_combined_lm)
check_collinearity(Post_Pene_combined_lm)

# Testing fitted versus raw data curves
ggplot(data=combined_data_full,
       mapping=aes(x=Post_Pene_AVG)) +
  geom_density(color = "blue", size = 2) +
  geom_density(data = data.frame(f = fitted(Post_Pene_combined_lm)),
               aes(x = f))

# Determining Relationships Between Response and Predictors
Anova(Post_Pene_combined_lm)
summary(Post_Pene_combined_lm)

## Initial Shoot Density
Initial_SD_combined_NBglm <- glm.nb(data = combined_data_full,
                            Pre_Live_SD ~
                              Year_Fac +
                              Site *
                              Block,
                            link = "log"
)

# Checking Model Fit and Colinearity
pre_sd_res <- simulateResiduals(Initial_SD_combined_NBglm)
plot(pre_sd_res)
vif(Initial_SD_combined_NBglm )
check_collinearity(Initial_SD_combined_NBglm )

# Determining Relationships Between Response and Predictors
summary(Initial_SD_combined_NBglm )
Anova(Initial_SD_combined_NBglm )

## Final Shoot Density (SD)
SD_combined_NBglm <- glm.nb(data = combined_data_full,
                            Post_Live_SD ~
                              Density_Num +
                              Pre_Pene_AVG +
                              Pre_Live_SD +
                              Post_Burrow_Count +
                              Year_Fac +
                              Site *
                              Block,
                            link = "log"
)

# Checking Model Fit and Colinearity
SD_nb_res_combined <- simulateResiduals(SD_combined_NBglm)
plot(SD_nb_res_combined)
vif(SD_combined_NBglm)
check_collinearity(SD_combined_NBglm)

# Testing fitted versus raw data curves
ggplot(data=combined_data_full_centered_2,
       mapping=aes(x=Post_Pene_AVG)) +
  geom_density(color = "blue", size = 2) +
  geom_density(data = data.frame(f = fitted(SD_combined_NBglm)),
               aes(x = f))

# Determining Relationships Between Response and Predictors
summary(SD_combined_NBglm)
Anova(SD_combined_NBglm)

## Spartina Biomass
# Full Model
SB_Gamma_combined_glm <- glm(data = combined_data_full,
                             Spartina_Biomass ~
                               Pre_Live_SD *
                               Post_Live_SD +
                               Post_Burrow_Count +
                               Pre_Pene_AVG +
                               Density_Num +
                               Post_Live_SD *
                               Post_Pene_AVG +
                               Year_Fac +
                               Site *
                               Block,
                             family = Gamma(link = "log")
)

# Checking Model Fit and Colinearity
SB_res <- simulateResiduals(SB_Gamma_combined_glm)
plot(SB_res)
vif(SB_Gamma_combined_glm)
check_collinearity(SB_Gamma_combined_glm)

# Determining Relationships Between Response and Predictors
Anova(SB_Gamma_combined_glm)
summary(SB_Gamma_combined_glm)

# Ok, those are somewhat high vifs, let's check the cor matrix
with(combined_data_full, cor(cbind(Spartina_Biomass,
                                   Post_Live_SD,
                                   Post_Pene_AVG, 
                                   Post_Live_SD*Post_Pene_AVG)))

with(combined_data_full, cor(cbind(Spartina_Biomass, 
                                   Post_Burrow_Count,
                                   Pre_Pene_AVG,
                                   Density_Num,
                                   Block,
                                   Year_Fac,
                                   Post_Live_SD,
                                   Post_Pene_AVG,
                                   Post_Live_SD *
                                   Post_Pene_AVG)))

# Slimmed down version
SB_slim_glm <- glm(data = combined_data_full_centered_2,
                   Spartina_Biomass ~
                     Pre_Live_SD + 
                     Pre_Pene_AVG +
                     Density_Num +
                     Post_Burrow_Count +
                     Pre_Live_SD *
                     Post_Live_SD +
                     Post_Pene_AVG +
                     Year_Fac +
                     Site *
                     Block,
                   family = Gamma(link = "log"))

# Checking Model Fit and Colinearity
SB_slim_res <- simulateResiduals(SB_slim_glm)
plot(SB_slim_res)
vif(SB_slim_glm)
check_collinearity(SB_slim_glm)

# Determining Relationships Between Response and Predictors
Anova(SB_slim_glm)
summary(SB_slim_glm)

# Determining Error Distribution for Spartina Biomass
#Let's test if it is gamma distributed
fit_gamma <- fitdist(combined_data_full$Spartina_Biomass, distr = "gamma", method = "mme")
plot(fit_gamma)
#Yep

# Centering
SB_Gamma_combined_glm_center <- glm(data = combined_data_full_centered,
                             Spartina_Biomass ~
                               pre_live_centered *
                               post_live_centered +
                               post_burrow_centered +
                               pre_pene_centered +
                               Density_Num +
                               post_live_centered *
                               post_pene_centered +
                               Year_Fac +
                               Site *
                               Block,
                             family = Gamma(link = "log"))

# Checking Model Fit and Colinearity
SB_center_res <- simulateResiduals(SB_Gamma_combined_glm_center)
plot(SB_res)
vif(SB_Gamma_combined_glm_center)
multicollinearity(SB_Gamma_combined_glm_center)

# Determining Relationships Between Response and Predictors
summary(SB_Gamma_combined_glm_center)
Anova(SB_Gamma_combined_glm_center)

weights <- lm(data = combined_data_full, Spartina_Biomass ~ Pre_Live_SD * Post_Live_SD + Site)
summary(weights)
vif(weights)

#### Building and Running the Combined SEM ####
combined_SEM <- psem(Post_Pene_combined_lm,
                     Burrows_combined_NBglm,
                     SB_Gamma_combined_glm,
                     #SB_slim_glm,
                     SD_combined_NBglm,
                     Pre_Pene_combined_lm)

summary(combined_SEM)
plot(combined_SEM)

#coefs(combined_SEM, standardize = "range", standardize.type = "latent.linear")

# system.time(
#   PP_SEM_Boot <- bootEff(combined_SEM, R = 10000, seed = 53908, ran.eff = "Site")
# )
# 
# eff <- suppressWarnings(semEff(PP_SEM_Boot))
# 
# eff$Summary$Spartin_Biomass

piecewiseSEM::rsquared(combined_SEM)

#### Alternate (less complex) Piecewise (Local) SEM for Primary Production####
### Building the Models
#Burrows
Burrows_combined_NBglm_alt <- glm.nb(data = combined_data_full,
                                 Post_Burrow_Count ~ 
                                   Density_Num *
                                   Pre_Pene_AVG +
                                   Year_Fac +
                                   Site
                                 ,
                                 link = "log"
)
summary(Burrows_combined_NBglm_alt)

## Soil  Strength
Post_Pene_combined_lm_alt <- lm(data = combined_data_full, 
                            Post_Pene_AVG ~ 
                              Post_Burrow_Count + 
                              Pre_Pene_AVG +
                              Site +
                              Year_Fac +
                              Pre_Live_SD #*
                            #Post_Live_SD
)
summary(Post_Pene_combined_lm_alt)

#Initial Soil Strength
Pre_Pene_combined_lm_alt <- lm(data = combined_data_full, 
                           Pre_Pene_AVG ~
                             Site +
                             Year_Fac
)
summary(Pre_Pene_combined_lm_alt)

#Final Shoot Density (SD)
SD_combined_NBglm_alt <- glm.nb(data = combined_data_full,
                            Post_Live_SD ~
                              Post_Burrow_Count +
                              Pre_Live_SD +
                              Site +
                              Year_Fac,
                            link = "log"
)
summary(SD_combined_NBglm_alt)

#Spartina Biomass
SB_Gamma_combined_glm_alt <- glm(data = combined_data_full,
                             Spartina_Biomass ~
                               Pre_Live_SD *
                               Post_Live_SD +
                               Post_Pene_AVG *
                               Post_Live_SD +
                               Post_Burrow_Count +
                               Pre_Pene_AVG +
                               Site +
                               Year_Fac,
                             family = Gamma(link = "log")
)
summary(SB_Gamma_combined_glm_alt)

# Building DHARMa residual diagnostics plots
#SD_nb_res_combined <- simulateResiduals(Burrows_combined_NBglm)
#plot(SD_nb_res_combined)

#### Building and Running the Combined SEM for Alternate PP Model ####
combined_SEM_alt <- psem(Post_Pene_combined_lm_alt,
                         Burrows_combined_NBglm_alt,
                         SB_Gamma_combined_glm_alt,
                         SD_combined_NBglm_alt,
                         Pre_Pene_combined_lm_alt)

combined_summary <- summary(combined_SEM_alt)
combined_summary
#plot(combined_SEM_alt, show = "unstd")

## Generate a table
# Isolate only the coefficients from the PSEM output
combined_coefs <- combined_summary$coefficients

# Use kableExtra to generate and save the table
combined_coefs %>%
  kbl() %>%
  kable_classic(full_width = F, html_font = "Cambria") %>%
  save_kable("figures/Combined_Table.jpeg")


