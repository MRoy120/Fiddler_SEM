source("scripts/2020_Chapter1_libraries.R")
source("scripts/2020_data_cleaning.R")

combined_data_full_centered <- combined_data_full_centered %>%
  mutate(NPP = Post_Live_SD - Pre_Live_SD)

combined_data_full_centered_2 <- combined_data_full_centered %>%
  filter(Spartina_Biomass > 1)

#### Piecewise (Local) SEM for Primary Production####
### Building the Models
## Burrow Density
Burrows_combined_NBglm <- glm.nb(data = combined_data_full_centered_2,
                                 Post_Burrow_Count ~ 
                                   Density_Num *
                                   Pre_Pene_AVG +
                                   Year_Fac +
                                   Site *
                                   Block
                                 ,
                                 link = "log"
)
summary(Burrows_combined_NBglm)
Anova(Burrows_combined_NBglm)
vif(Burrows_combined_NBglm)
check_collinearity(Burrows_combined_NBglm)
Burrows_res <- simulateResiduals(Burrows_combined_NBglm)
plot(Burrows_res)

## Initial Soil Strength
Pre_Pene_combined_lm <- lm(data = combined_data_full_centered_2, 
                           Pre_Pene_AVG ~
                             Year_Fac +
                             Site *
                             Block
)
summary(Pre_Pene_combined_lm)
Anova(Pre_Pene_combined_lm)
#plot(Pre_Pene_combined_lm)
plot(Pre_Pene_combined_lm, which = 4)
vif(Pre_Pene_combined_lm)
check_collinearity(Pre_Pene_combined_lm)

## Final Soil  Strength
Post_Pene_combined_lm <- lm(data = combined_data_full_centered_2, 
                            Post_Pene_AVG ~ 
                              Post_Burrow_Count + 
                              Pre_Pene_AVG +
                              Year_Fac +
                              Pre_Live_SD +
                              Site *
                              Block
)
Anova(Post_Pene_combined_lm)
summary(Post_Pene_combined_lm)
#plot(Post_Pene_combined_lm)
plot(Post_Pene_combined_lm, which = 4)
vif(Post_Pene_combined_lm)
check_collinearity(Post_Pene_combined_lm)
Post_pene_res <- simulateResiduals(Post_Pene_combined_lm)
plot(Post_pene_res)

## Final Shoot Density (SD)
SD_combined_NBglm <- glm.nb(data = combined_data_full_centered_2,
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
summary(SD_combined_NBglm)
Anova(SD_combined_NBglm)
SD_nb_res_combined <- simulateResiduals(SD_combined_NBglm)
plot(SD_nb_res_combined)
vif(SD_combined_NBglm)
check_collinearity(SD_combined_NBglm)

NPP_glm <- glm(data = combined_data_full_centered,
                   NPP ~
                     Pre_Live_SD +
                     Post_Live_SD +
                     Spartina_Biomass +
                     Density_Num +
                     Post_Burrow_Count +
                     Pre_Pene_AVG +
                     Year_Fac +
                     Site *
                     Block,
                   family = "gaussian"
)
#fitdistrplus::descdist(combined_data_full_centered$NPP)
plot(NPP_glm)
shapiro.test(combined_data_full_centered$NPP)
SD_res <- simulateResiduals(NPP_glm)
plot(SD_res)
Anova(NPP_glm)
vif(SD_combined)
check_collinearity(NPP_glm)

## Spartina Biomass
# Initial soil strength and crab density interaction - no significant relationship
# SB_Gamma_combined_glm <- glm(data = combined_data_full,
#                              Spartina_Biomass ~  
#                                Pre_Live_SD * 
#                                Post_Live_SD +
#                                Post_Burrow_Count +
#                                Pre_Pene_AVG *
#                                Density_Num +
#                                Post_Live_SD * 
#                                Post_Pene_AVG +
#                                Site +
#                                Year_Fac,
#                              family = Gamma(link = "log")
# )

# Initial soil strength and burrow density interaction - no significant relationship
# SB_Gamma_combined_glm <- glm(data = combined_data_full,
#                              Spartina_Biomass ~  
#                                Pre_Live_SD * 
#                                Post_Live_SD +
#                                Post_Burrow_Count *
#                                Pre_Pene_AVG +
#                                Density_Num +
#                                Post_Live_SD * 
#                                Post_Pene_AVG +
#                                Site +
#                                Year_Fac,
#                              family = Gamma(link = "log")
# )

# Removing non-significant interaction terms
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
vif(SB_slim_glm)
Anova(SB_slim_glm)
summary(SB_slim_glm)
check_collinearity(SB_slim_glm)
SB_slim_res <- simulateResiduals(SB_slim_glm)
plot(SB_slim_res)

# Removing non-significant interaction terms
SB_Gamma_combined_glm <- glm(data = combined_data_full_centered_2,
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
Anova(SB_Gamma_combined_glm)
#plot(SB_Gamma_combined_glm, which = 4)
SB_res <- simulateResiduals(SB_Gamma_combined_glm)
plot(SB_res)
vif(SB_Gamma_combined_glm)
check_collinearity(SB_Gamma_combined_glm)

#'In other words, those three 0 values are skewing my data so much that
#'the model no longer fits, and the effect of the final live sd and final
#'soil strength interactiondisappears. Those three 0s are driving a lot of the 
#'statistical and ecological inference, and change the entire dynamics of 
#'the the model and my interpretation of the results.
#'
#'Also, when I remove the final live sd and final soil strength interaction,
#'the vifs go down, there is still a relationship between initial and final
#'shoot density and initial soil strength the spartina biomass, but the vifs
#'are still high. So after centering, the same relationships hold.

SB_combined_lm <- lm(data = combined_data_full_centered,
                             Spartina_Biomass ~
                               Pre_Live_SD *
                               Post_Live_SD +
                               Post_Burrow_Count +
                               Pre_Pene_AVG +
                               Density_Num +
                               #Post_Live_SD *
                               Post_Pene_AVG +
                               Year_Fac +
                               Site *
                               Block)#,
                           #weights = 1/combined_data_full$Post_Pene_AVG)

summary(SB_combined_lm)
shapiro.test(combined_data_full$Spartina_Biomass)
gamma_test(combined_data_full$Spartina_Biomass)
ggplot(combined_data_full, aes(Spartina_Biomass)) + 
  geom_histogram() + 
  stat_bin(bins = 10, binwidth = 4)
library(lmtest)
bptest(SB_combined_lm, varformula = ~ Post_Live_SD, data = combined_data_full)
#plot(SB_combined_lm, which = 4)
plot(SB_combined_lm)
library(fitdistrplus)
fitdistrplus::plotdist(combined_data_full$Spartina_Biomass)
descdist(combined_data_full$Spartina_Biomass)
vif(SB_combined_lm)

library(fitdistrplus)
data(danishuni) 
logLoss <- log(danishuni$Loss)   # logarithm of Loss variable
logLoss <- logLoss[logLoss > 0]  # observations > 0
gamma_test(logLoss) 



spartina <- combined_data_full$Spartina_Biomass
spartina <- spartina[spartina > 0]
gamma_test(spartina)

SB_Resid <- combined_data_full %>%
  mutate(SB_resid = Spartina_Biomass - mean(Spartina_Biomass))

SB_Resid_2 <- combined_data_full %>%
  add_residuals(SB_combined_lm)

#Let's compare predictor vs residuals, there should be no relationship
qplot(Spartina_Biomass, resid, data = SB_Resid_2) +
  stat_smooth()

#What about fitted vs residuals
SB_Resid_2 <- SB_Resid_2 %>%
  add_predictions(SB_combined_lm)

#Plot it!
qplot(pred, resid, data = SB_Resid_2) +
  stat_smooth()

#Now qq plot
qqnorm(SB_Resid_2$resid)
qqline(SB_Resid_2$resid)

#Plot the spread of the residuals
ggplot(data = SB_Resid_2, mapping=aes(x=resid)) +
  geom_density()

#Test for normality using a Shapiro-Wilks Test
shapiro.test(SB_Resid_2$resid)

#Finally, a histogram showing the spread of data
hist(sqrt(combined_data_full$Spartina_Biomass))

#That looks pretty non-normal, and gamma distributed to me!
#Let's test if it is gamma distributed
fit_gamma <- fitdist(combined_data_full$Spartina_Biomass, distr = "gamma", method = "mme")
plot(fit_gamma)


library(nlme)
spartina_gls <- gls(data = combined_data_full_centered,
                    Spartina_Biomass ~
                      Pre_Live_SD *
                      Post_Live_SD +
                      Post_Burrow_Count +
                      Pre_Pene_AVG +
                      Density_Num +
                      Post_Live_SD *
                      Post_Pene_AVG +
                      Year_Fac +
                      Site +
                      Block,
                    weights = varComb(# varFixed(~ Post_Burrow_Count),
                                      # varFixed(~ Pre_Pene_AVG),
                                      # varFixed(~ Post_Pene_AVG),
                                      varIdent(form = ~ 1 | Year_Fac),
                                      varIdent(form = ~ 1 | Site),
                                      varIdent(form = ~ 1 | Block)))#,
                   # method = "ML")

spartina_gls_2 <- gls(data = combined_data_full_centered,
                    Spartina_Biomass ~
                      NPP +
                      Post_Burrow_Count +
                      Pre_Pene_AVG +
                      Density_Num +
                      Year_Fac +
                      Site +
                      Block,
                    weights = varComb(# varFixed(~ Post_Burrow_Count),
                      # varFixed(~ Pre_Pene_AVG),
                      # varFixed(~ Post_Pene_AVG),
                      varIdent(form = ~ 1 | Year_Fac),
                      varIdent(form = ~ 1 | Site),
                      varIdent(form = ~ 1 | Block)))

summary(MASS::rlm(data = combined_data_full,
          Spartina_Biomass ~
            Pre_Live_SD *
            Post_Live_SD +
            Post_Burrow_Count +
            Pre_Pene_AVG +
            Density_Num +
            Post_Live_SD *
            Post_Pene_AVG +
            Year_Fac +
            Site +
            Block))

# spartina_gnls <- gnls(Spartina_Biomass ~
#                         )

qqline(spartina_gls$residuals)
qqnorm(spartina_gls$residuals)
#plot(spartina_gls)
vif(spartina_gls_2)
Anova(spartina_gls_2)
spartina_res <- simulateResiduals(SB_Gamma_combined_glm)
spartina_res_2 <- simulateResiduals(SB_slim_glm)
spartina_res_3 <- simulateResiduals(SB_Gamma_combined_glm_center)
#plot(SB_slim_glm)
#plot(spartina_res)
testOutliers(spartina_res_2)
residuals(spartina_res_2)
simxulationOutput <- recalculateResiduals(spartina_res_2, group = combined_data_full$Spartina_Biomass)
#plot(simulationOutput, quantreg = FALSE)

DHARMa::plotSimulatedResiduals(spartina_gls_2)
car::Anova(spartina_gls_2)
summary(spartina_gls_2)
vif(spartina_gls_2)
sdensity <- combined_data_full %>%
  dplyr::select(Pre_Live_SD, Post_Live_SD)
cov(sdensity)
vcov(spartina_gls)
se <- sqrt(diag(vcov(spartina_gls)))

combined_data_full %>%
  group_by(Site) %>%
  dplyr::summarise(var_weight_site = var(Spartina_Biomass)) %>%
  ungroup() #%>%
 # knitr::kable()

combined_data_full %>%
  group_by(Year) %>%
  dplyr::summarise(var_weight_year = var(Spartina_Biomass)) %>%
  ungroup()

combined_data_full %>%
  group_by(Block) %>%
  dplyr::summarise(var_weight_block = var(Spartina_Biomass)) %>%
  ungroup()

combined_data_full %>%
  group_by(Block, Site, Year_Fac) %>%
  dplyr::summarise(var_weight_all = var(Spartina_Biomass)) %>%
  ungroup()

#plot(spartina_gls)

anova(spartina_gls, SB_combined_lm)

residuals_spartina <- simulateResiduals(SB_combined_lm)
#plot(residuals_spartina)

Centering
SB_Gamma_combined_glm_center <- glm(data = combined_data_full_centered_2,
                             Spartina_Biomass ~
                               pre_live_centered *
                               post_live_centered +
                               post_burrow_centered +
                               pre_pene_centered +
                               Density_Num +
                               post_live_centered +
                               post_pene_centered +
                               Year_Fac +
                               Site *
                               Block,
                             family = Gamma(link = "log"))

SB_center_res <- simulateResiduals(SB_Gamma_combined_glm_center)
plot(SB_res)
Anova(SB_slim_glm)
vif(SB_slim_glm)
Anova(SB_Gamma_combined_glm_center)
vif(SB_Gamma_combined_glm_center)
multicollinearity(SB_Gamma_combined_glm_center)

Anova(SB_Gamma_combined_glm)
vif(SB_Gamma_combined_glm)

SB_combined_lm_center <- lm(data = combined_data_full_centered,
                             sqrt(Spartina_Biomass) ~
                               pre_live_centered *
                               post_live_centered +
                               post_burrow_centered +
                               pre_pene_centered +
                               Density_Num +
                               #post_live_centered *
                               post_pene_centered +
                               Year_Fac +
                               Site *
                               Block)

summary(SB_combined_lm_center)
vif(SB_combined_lm_center)
shapiro.test(sqrt(combined_data_full$Spartina_Biomass))
anova(SB_Gamma_combined_glm)

weights <- lm(data = combined_data_full, Spartina_Biomass ~ Pre_Live_SD * Post_Live_SD + Site)
summary(weights)
vif(weights)

# Building DHARMa residual diagnostics plots
Burrows_nb_res_combined <- simulateResiduals(Burrows_combined_NBglm)
#plot(Burrows_nb_res_combined)

#### Building and Running the Combined SEM ####
combined_SEM <- psem(Post_Pene_combined_lm,
                     Burrows_combined_NBglm,
                     #SB_Gamma_combined_glm,
                     SB_slim_glm,
                     #spartina_gls_2,
                     #NPP_glm,
                     SD_combined_NBglm,
                     Pre_Pene_combined_lm)

summary(combined_SEM)

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


