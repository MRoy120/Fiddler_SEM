source("scripts/2020_Chapter1_libraries.R")
source("scripts/2020_data_cleaning.R")

#### Piecewise (Local) SEM for Primary Production####
### Building the Models
## Soil  Strength
Post_Pene_combined_lm <- lm(data = combined_data_full, 
                            Post_Pene_AVG ~ 
                              Post_Burrow_Count + 
                              Pre_Pene_AVG +
                              Site +
                              Year_Fac +
                              Pre_Live_SD #*
                              #Post_Live_SD
)
summary(Post_Pene_combined_lm)

#Burrows
Burrows_combined_NBglm <- glm.nb(data = combined_data_full,
                                 Post_Burrow_Count ~ 
                                   Density_Num *
                                   Pre_Pene_AVG +
                                   Year_Fac +
                                   Site
                                 ,
                                 link = "log"
)
summary(Burrows_combined_NBglm)

#Initial Soil Strength
Pre_Pene_combined_lm <- lm(data = combined_data_full, 
                           Pre_Pene_AVG ~
                             Site +
                             Year_Fac
)
summary(Pre_Pene_combined_lm)

#Spartina Biomass
SB_Gamma_combined_glm <- glm(data = combined_data_full,
                             Spartina_Biomass ~  
                               Pre_Live_SD * 
                               Post_Live_SD +
                               Post_Pene_AVG *
                               Post_Live_SD +
                               Post_Burrow_Count +
                               Pre_Pene_AVG +
                               Density_Num +
                               Site +
                               Year_Fac,
                             family = Gamma(link = "log")
)
summary(SB_Gamma_combined_glm)

#Final Shoot Density (SD)
SD_combined_NBglm <- glm.nb(data = combined_data_full,
                            Post_Live_SD ~
                              Density_Num +
                              Post_Burrow_Count +
                              Pre_Live_SD +
                              Pre_Pene_AVG +
                              Site +
                              Year_Fac,
                            link = "log"
)
summary(SD_combined_NBglm)

# Building DHARMa residual diagnostics plots
SD_nb_res_combined <- simulateResiduals(Burrows_combined_NBglm)
plot(SD_nb_res_combined)

#### Building and Running the Combined SEM ####
combined_SEM <- psem(Post_Pene_combined_lm,
                     Burrows_combined_NBglm,
                     SB_Gamma_combined_glm,
                     SD_combined_NBglm,
                     Pre_Pene_combined_lm)

summary(combined_SEM)


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

summary(combined_SEM_alt)
plot(combined_SEM_alt, show = "unstd")



