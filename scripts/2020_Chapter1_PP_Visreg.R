source("scripts/2020_Chapter1_PP_SEM.R")

# Primary Production Visreg Models ####
#Plotting the relationship between final shoot density and spartina biomass for different soil strengths
visreg(SB_Gamma_combined_glm, 
       "Post_Live_SD", 
       scale = "response", 
       by = "Post_Pene_AVG",
       breaks = c(seq(0, 60, 20)),
       layout = c(4, 1),
       ylab = "S. alterniflora\nBiomass (grams)",
       xlab = "Final S. alterniflora Shoot Density\n(shoots/plot)",
       gg = TRUE,
       strip.names = c("Final Soil Strength: 0", "Final Soil Strength: 20",
                       "Final Soil Strength: 40", "Final Soil Strength: 60"),
) +
  theme_bw() +
  My_Font_Sizes +
  geom_point(alpha = 0.4, size = 0.6) +
  labs(title = "Interaction Plot:",
       subtitle = "Final S. alterniflora Shoot Density vs.\nFinal S. alterniflora Biomass faceted for each Final Soil Strength") +
  theme(plot.title = element_text(size = 22, 
                                  face = "bold"),
        plot.subtitle = element_text(size = 18,
                                     face = "bold"),
        strip.text.x = element_text(size = 15, 
                                    colour = "black", 
                                    angle = 360)) +
  ggsave(filename = "figures/2020_PP_PLSD_PPA_Visreg.png",
         width = 15, 
         height = 5)

#Plotting the relationship between final shoot density and Spartina biomass for each site
visreg(SB_Gamma_combined_glm, 
       "Post_Live_SD", 
       scale = "response", 
       by = "Site",
       ylab = "S. alterniflora\nBiomass (grams)",
       xlab = "Final S. alterniflora Shoot Density\n(shoots/plot)",
       strip.names = c("PIE", "NAN"),
       gg = TRUE,
       line.par = list(col = "slategray")) +
  theme_bw(base_family = "Times") +
  My_Font_Sizes +
  geom_point(alpha = 0.7, 
             size = 0.95,
             aes(color = Site)) +
  scale_color_manual(values = c("darkred", "dodgerblue3")) +
  #scale_colour_discrete(name  = "Site",
  #breaks = c("0", "1"),
  #labels = c("PIE", "NAN")) +
  labs(title = "Interaction Plot:",
       subtitle = "Final S. alterniflora Shoot Density vs.\nFinal S. alterniflora Biomass faceted for each Site") +
  theme(plot.title = element_text(size = 18, 
                                  face = "bold"),
        plot.subtitle = element_text(size = 14, 
                                     face = "bold"),
        strip.text.x = element_text(size = 15, 
                                    colour = "black", 
                                    angle = 360),
        legend.position = "none") +
  ggsave(filename = "figures/2020_PP_Site_Visreg.png",
         width = 10, 
         height = 5)


#Important final plot: final soil strength vs. S. alterniflora biomass for each final shoot density ####
visreg(SB_Gamma_combined_glm, 
       "Post_Pene_AVG", 
       scale = "response", 
       by = "Post_Live_SD",
       ylab = "S. alterniflora\nBiomass (grams)",
       xlab = "Final Soil Strength\n(psi)",
       breaks = c(seq(0, 60, 15)),
       layout = c(5, 1),
       gg = TRUE,
       line.par = list(col = "slategray"),
       strip.names = c("Final Shoot Density: 0", "Final Shoot Density: 15",
                       "Final Shoot Density: 30", "Final Shoot Density: 45",
                       "Final Shoot Density: 60")) +
  theme_bw(base_family = "Times") +
  My_Font_Sizes +
  geom_point(alpha = 0.7, 
             size = 0.95) +
  labs(title = "Interaction Plot:",
       subtitle = "Final Soil Strength vs.\nFinal S. alterniflora Biomass faceted for different Final S. alterniflora Shoot Densities") +
  theme(plot.title = element_text(size = 18, 
                                  face = "bold"),
        plot.subtitle = element_text(size = 14, 
                                     face = "bold"),
        strip.text.x = element_text(size = 15, 
                                    colour = "black", 
                                    angle = 360),
        legend.position = "none") +
  ggsave(filename = "figures/2020_PP_Biomass_Visreg_2.png",
         width = 14, 
         height = 6)

#Burrow density versus spartina biomass for each site
visreg(SB_Gamma_combined_glm, 
       "Post_Burrow_Count", 
       scale = "response", 
       by = "Site",
       ylab = "S. alterniflora\nBiomass (grams)",
       xlab = "Fiddler Crab Burrow Density\n(burrows/plot)",
       strip.names = c("PIE", "NAN"),
       gg = TRUE,
       line.par = list(col = "slategray")) +
  theme_bw(base_family = "Times") +
  My_Font_Sizes +
  geom_point(alpha = 0.7, 
             size = 0.95,
             aes(color = Site)) +
  scale_color_manual(values = c("darkred", "dodgerblue3")) +
  #scale_colour_discrete(name  = "Site",
  #breaks = c("0", "1"),
  #labels = c("PIE", "NAN")) +
  labs(title = "Interaction Plot:",
       subtitle = "Fiddler Crab Burrow Density vs.\nFinal S. alterniflora Biomass faceted for each Site") +
  theme(plot.title = element_text(size = 18, 
                                  face = "bold"),
        plot.subtitle = element_text(size = 14, 
                                     face = "bold"),
        strip.text.x = element_text(size = 15, 
                                    colour = "black", 
                                    angle = 360),
        legend.position = "none") +
  ggsave(filename = "figures/2020_PP_Burrows_Site_Visreg.png",
         width = 10, 
         height = 5)

#Burrow density versus shoot density for each site
visreg(SD_combined_NBglm, 
       "Post_Burrow_Count", 
       scale = "response", 
       by = "Site",
       ylab = "S. alterniflora\nShoot Density (shoots/plot)",
       xlab = "Fiddler Crab Burrow Density\n(burrows/plot)",
       strip.names = c("PIE", "NAN"),
       gg = TRUE,
       line.par = list(col = "slategray")) +
  theme_bw(base_family = "Times") +
  My_Font_Sizes +
  geom_point(alpha = 0.7, 
             size = 0.95,
             aes(color = Site)) +
  scale_color_manual(values = c("darkred", "dodgerblue3")) +
  #scale_colour_discrete(name  = "Site",
  #breaks = c("0", "1"),
  #labels = c("PIE", "NAN")) +
  labs(title = "Interaction Plot:",
       subtitle = "Fiddler Crab Burrow Density vs.\nFinal S. alterniflora Shoot Density faceted for each Site") +
  theme(plot.title = element_text(size = 18, 
                                  face = "bold"),
        plot.subtitle = element_text(size = 14, 
                                     face = "bold"),
        strip.text.x = element_text(size = 15, 
                                    colour = "black", 
                                    angle = 360),
        legend.position = "none") #+
  # ggsave(filename = "figures/2020_SD_Burrows_Site_Visreg.png",
  #        width = 10, 
  #        height = 5)

#Initial shoot density vs. biomass for different final shoot densities
visreg(SB_Gamma_combined_glm, 
       "Pre_Live_SD", 
       scale = "response", 
       by = "Post_Live_SD",
       ylab = "S. alterniflora\nBiomass (grams)",
       xlab = "Initial S. alterniflora\nShoot Density (psi)",
       breaks = c(seq(0, 60, 20)),
       layout = c(5, 1),
       gg = TRUE,
       line.par = list(col = "slategray"),
       strip.names = c("Final Shoot Density: 0", "Final Shoot Density: 20",
                       "Final Shoot Density: 40", "Final Shoot Density: 60")
       ) +
  theme_bw(base_family = "Times") +
  My_Font_Sizes +
  geom_point(alpha = 0.7, 
             size = 0.95) +
  labs(title = "Interaction Plot:",
       subtitle = "Initial S. alterniflora Shoot Density vs.\nFinal S. alterniflora Biomass faceted for different Final S. alterniflora Shoot Densities") +
  theme(plot.title = element_text(size = 18, 
                                  face = "bold"),
        plot.subtitle = element_text(size = 14, 
                                     face = "bold"),
        strip.text.x = element_text(size = 15, 
                                    colour = "black", 
                                    angle = 360),
        legend.position = "none") +
  ggsave(filename = "figures/2020_PP_Biomass_Visreg_init-fin.png",
         width = 14, 
         height = 6)



#A few scraps
ggplot(data = combined_data_full, aes(x = Post_Live_SD,
                                      y = Spartina_Biomass,
                                      color = Location)) +
  geom_point() +
  geom_smooth(method = "lm")

visreg(SB_Gamma_combined_glm, 
       "Pre_Live_SD", 
       scale = "response", 
       by = "Post_Live_SD",
       ylab = "S. alterniflora\nBiomass (grams)",
       xlab = "Initial S. alterniflora Shoot Density\n(shoots/plot)",
       #strip.names = c("PIE", "NAN"),
       gg = TRUE,
       #line.par = list(col = "slategray")
) +
  geom_point(alpha = 0.7, 
             size = 0.95) 

visreg(SB_Gamma_combined_glm, 
       "Post_Pene_AVG", 
       scale = "response", 
       #by = "Post_Live_SD",
       ylab = "S. alterniflora\nBiomass (grams)",
       xlab = "Final Soil Strength\n(psi)",
       #breaks = c(seq(0, 60, 15)),
       #layout = c(4, 1),
       #strip.names = c("PIE", "NAN"),
       gg = TRUE,
       #line.par = list(col = "slategray")
) +
  geom_point(alpha = 0.7, 
             size = 0.95) 

# Heat Map ####
visreg2d(SB_Gamma_combined_glm, 
         x="Post_Live_SD",
         y="Post_Pene_AVG",
         scale = "response", 
         main = "Final Burrow Density",
         xlab = "Final Shoot Density (shoots/quadrat)",
         ylab = "Final Soil Strength (psi)",
         #breaks = c(0, 4, 8, 12, 16, 20),
         #col = colorRampPalette(brewer.pal(9,"YlOrRd"))(20),
         plot.type='gg'
) +
  scale_fill_distiller("Spartina\nBiomass",
                       palette = "RdYlBu") +
  #scale_colour_brewer(palette = "PiYG", direction = - 1) +
  theme_bw(base_size = 18) +
  theme(axis.text = element_text(size = 18),
        axis.title = element_text(size = 22)) +
  labs(title = "Interaction Plot of Final Soil Strength, Final Shoot Density,\nand Spartina Biomass",
       subtitle = "Heat Map") #+
  # ggsave(filename = "figures/2021_Shoots_FSS_Biomass_Heat.png",
  #        width = 10, 
  #        height = 8)

visreg2d(SB_Gamma_combined_glm, 
         x="Pre_Live_SD",
         y="Post_Live_SD",
         scale = "response", 
         #main = "Final Burrow Density",
         xlab = "Initial Shoot Density (shoots/quadrat)",
         ylab = "Final Shoot Density (shoots/quadrat)",
         #breaks = c(0, 4, 8, 12, 16, 20),
         #col = colorRampPalette(brewer.pal(9,"YlOrRd"))(20),
         plot.type='gg'
) +
  scale_fill_distiller("Spartina\nBiomass",
                       palette = "RdYlBu") +
  #scale_colour_brewer(palette = "PiYG", direction = - 1) +
  theme_bw(base_size = 18) +
  theme(axis.text = element_text(size = 18),
        axis.title = element_text(size = 22)) +
  labs(title = "Interaction Plot of Initial Shoot Density, Final Shoot Density,\nand Spartina Biomass",
       subtitle = "Heat Map")


visreg(SB_Gamma_combined_glm, 
       "Pre_Pene_AVG", 
       scale = "response", 
       by = "Site",
       strip.names = c("PIE", "NAN"),
       # breaks = c(seq(0, 60, 20)),
       # layout = c(4, 1),
       ylab = "S. alterniflora\nBiomass (grams)",
       xlab = "Initial Soil Strength\n(psi)",
       gg = TRUE#,
       # strip.names = c("Final Soil Strength: 0", "Final Soil Strength: 20",
       #                 "Final Soil Strength: 40", "Final Soil Strength: 60"),
) +
  theme_bw() +
  My_Font_Sizes +
  geom_point(alpha = 0.4, size = 0.6) +
  # labs(title = "Interaction Plot:",
  #      subtitle = "Final S. alterniflora Shoot Density vs.\nFinal S. alterniflora Biomass faceted for each Final Soil Strength") +
  theme(plot.title = element_text(size = 22, 
                                  face = "bold"),
        plot.subtitle = element_text(size = 18,
                                     face = "bold"),
        strip.text.x = element_text(size = 15, 
                                    colour = "black", 
                                    angle = 360))

visreg(SD_combined_NBglm, 
       "Pre_Live_SD", 
       scale = "response", 
       by = "Site",
       strip.names = c("PIE", "NAN"),
       # breaks = c(seq(0, 60, 20)),
       # layout = c(4, 1),
       ylab = "Final S. alterniflora\nShoot Density (Shoots/Plot)",
       xlab = "Initial S. alterniflora\nShoot Density (Shoots/Plot)",
       gg = TRUE#,
       # strip.names = c("Final Soil Strength: 0", "Final Soil Strength: 20",
       #                 "Final Soil Strength: 40", "Final Soil Strength: 60"),
) +
  theme_bw() +
  My_Font_Sizes +
  geom_point(alpha = 0.4, size = 0.6) +
  # labs(title = "Interaction Plot:",
  #      subtitle = "Final S. alterniflora Shoot Density vs.\nFinal S. alterniflora Biomass faceted for each Final Soil Strength") +
  theme(plot.title = element_text(size = 22, 
                                  face = "bold"),
        plot.subtitle = element_text(size = 18,
                                     face = "bold"),
        strip.text.x = element_text(size = 15, 
                                    colour = "black", 
                                    angle = 360))


visreg(SD_combined_NBglm, 
       "Pre_Pene_AVG", 
       scale = "response", 
       by = "Site",
       ylab = "S. alterniflora\nShoot Density (shoots/plot)",
       xlab = "Initial Soil Strength\n(psi)",
       strip.names = c("PIE", "NAN"),
       gg = TRUE,
       line.par = list(col = "slategray")) +
  theme_bw(base_family = "Times") +
  My_Font_Sizes +
  geom_point(alpha = 0.7, 
             size = 0.95,
             aes(color = Site)) +
  scale_color_manual(values = c("darkred", "dodgerblue3")) +
  #scale_colour_discrete(name  = "Site",
  #breaks = c("0", "1"),
  #labels = c("PIE", "NAN")) +
  # labs(title = "Interaction Plot:",
  #      subtitle = "Fiddler Crab Burrow Density vs.\nFinal S. alterniflora Shoot Density faceted for each Site") +
  theme(plot.title = element_text(size = 18, 
                                  face = "bold"),
        plot.subtitle = element_text(size = 14, 
                                     face = "bold"),
        strip.text.x = element_text(size = 15, 
                                    colour = "black", 
                                    angle = 360),
        legend.position = "none")

ggplot(combined_data_full, aes(x = Pre_Live_SD,
                               y = Post_Live_SD,
                               color = Year)) +
  geom_point() +
  stat_smooth(method = "lm") +
  facet_wrap(vars(Location))

ggplot(combined_data_full, aes(x = Location,
                               y = Pre_Live_SD)) +
  geom_boxplot()
