source("scripts/2020_Chapter1_PP_SEM.R")

#Plotting the relationship between final shoot density and spartina biomass for different soil strengths
visreg(SB_Gamma_combined_glm, 
       "Post_Live_SD", 
       scale = "response", 
       by = "Post_Pene_AVG",
       breaks = c(seq(0, 30, 10)),
       layout = c(4, 1),
       ylab = "Spartina alterniflora Biomass",
       xlab = "Final S. alterniflora Shoot Density",
       gg = TRUE,
       strip.names = c("Final Soil Strength: 0", "Final Soil Strength: 10",
                       "Final Soil Strength: 20", "Final Soil Strength: 30"),
) +
  theme_bw() +
  #scale_y_continuous(limits = c(0, 1000)) +
  My_Font_Sizes +
  theme(strip.text.x = element_text(size = 15, colour = "black", angle = 360)) +
  ggsave(filename = "figures/2020_PP_PLSD_PPA_Visreg.png",
         width = 15, 
         height = 5)

#Plotting the relationship between final shoot density and Spartina biomass for each site
visreg(SB_Gamma_combined_glm, 
       "Post_Live_SD", 
       scale = "response", 
       by = "Site",
       ylab = "Spartina alterniflora Biomass",
       xlab = "Final S. alterniflora Shoot Density",
       strip.names = c("PIE", "NAN"),
       gg = TRUE,
) +
  theme_bw() +
  scale_color_discrete() +
  My_Font_Sizes +
  theme(strip.text.x = element_text(size = 20, colour = "black", angle = 360)) +
  ggsave(filename = "figures/2020_PP_Site_Visreg.png",
         width = 10, 
         height = 5)

