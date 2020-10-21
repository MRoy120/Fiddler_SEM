source("scripts/2020_Chapter1_SS_SEM.R")

#### Visreg Plot Comparison ####
#Initial Soil Strength to Final Burrow Density by Initial Crab Density
visreg(Burrows_NBglm, 
       "Pre_Pene_AVG", 
       scale = "response", 
       by = "Density_Num",
       breaks = c(seq(0, 20, 4)),
       layout = c(6, 1),
       ylab = "Fiddler Crab Burrow\nDensity (burrows/plot)",
       xlab = "Initial Soil Strength (psi)",
       gg = TRUE,
       line.par = list(col = "slategray"),
       strip.names = c("Initial Crab Density: 0", "Initial Crab Density: 4",
                       "Initial Crab Density: 8", "Initial Crab Density: 12",
                       "Initial Crab Density: 16", "Initial Crab Density: 20"),
       ) +
  theme_bw(base_family = "Times") +
  scale_y_continuous(limits = c(0, 35)) +
  My_Font_Sizes +
  theme(strip.text.x = element_text(size = 15, colour = "black", angle = 360)) +
  geom_point(alpha = 0.4, size = 0.6) +
  labs(title = "Interaction Plot:",
       subtitle = "Initial Soil Strength vs.\nCrab Burrow Density faceted for each Initial Crab Density") +
  theme(plot.title = element_text(size = 22, 
                                  face = "bold"),
        plot.subtitle = element_text(size = 18,
                                     face = "bold")) +
  ggsave(filename = "figures/2020_ISS_CBD_ICD_Visreg.png",
         width = 15, 
         height = 5)

#Initial Crab Density to Final Burrow Density by Soil Strength
visreg(Burrows_NBglm, 
       "Density_Num", 
       scale = "response", 
       by = c("Pre_Pene_AVG"),
       breaks = c(seq(0, 30, 10)),
       ylab = "Crab Burrow Density",
       xlab = "Initial Crab Density",
       layout = c(2, 2),
       strip.names = c("Initial Soil Strength: 0", "Initial Soil Strength: 10",
                       "Initial Soil Strength: 20", "Initial Soil Strength: 30"),
       gg = TRUE
       ) +
  theme_bw() +
  scale_y_continuous(limits = c(0, 25)) +
  scale_x_continuous(breaks = c(0, 4, 8, 12, 16, 20)) +
  My_Font_Sizes +
  theme(strip.text.x = element_text(size = 18, colour = "black", angle = 360)) +
  ggsave(filename = "figures/2020_ICD_CBD_ISS_Visreg.png",
         width = 15, 
         height = 5)

#Initial Burrow Density to Final Burrow Density by Site
visreg(Post_Pene_lm, 
       "Post_Burrow_Count", 
       scale = "response", 
       by = "Site",
       ylab = "Final Soil Strength\n(psi)",
       xlab = "Fiddler Crab Burrow Density\n(burrows per plot)",
       strip.names = c("PIE", "NAN"),
       gg = TRUE,
       line.par = list(col = "slategray")
       ) +
  theme_bw(base_family = "Times") +
  scale_color_discrete() +
  My_Font_Sizes +
  geom_point(alpha = 0.7, 
             size = 0.95,
             aes(color = Site)) +
  scale_color_manual(values = c("darkred", "dodgerblue3")) +
  #scale_colour_discrete(name  = "Site",
                        #breaks = c("0", "1"),
                        #labels = c("PIE", "NAN")) +
  labs(title = "Interaction Plot:",
       subtitle = "Crab Burrow Density vs.\nFinal Soil Strength faceted for each Site") +
  theme(plot.title = element_text(size = 18, 
                                  face = "bold"),
        plot.subtitle = element_text(size = 14, 
                                     face = "bold"),
        strip.text.x = element_text(size = 15, 
                                    colour = "black", 
                                    angle = 360),
        legend.position="none") +
  ggsave(filename = "figures/2020_SS_Site_Visreg.png",
         width = 10, 
         height = 5)

#Same plot, but with overlay
visreg(Post_Pene_lm, 
       "Post_Burrow_Count", 
       scale = "response", 
       by = "Site",
       ylab = "Final Soil Strength",
       xlab = "Crab Burrow Density",
       strip.names = c("PIE", "NAN"),
       gg = TRUE,
       overlay = TRUE,
       partial = FALSE) +
  theme_bw() +
  My_Font_Sizes +
  scale_color_discrete(labels = FALSE) +
  theme(strip.text.x = element_text(size = 20, colour = "black", angle = 360))

#Initial Burrow Density to Final Burrow Density by Initial Soil Strength
visreg(Post_Pene_lm, 
       "Post_Burrow_Count", 
       scale = "response", 
       by = "Pre_Pene_AVG",
       breaks = c(0, 10, 20, 30),
       layout = c(4, 1),
       ylab = "Final Soil Strength",
       xlab = "Crab Burrow Density",
       strip.names = c("Initial Soil Strength: 0", "Initial Soil Strength: 10",
                       "Initial Soil Strength: 20", "Initial Soil Strength: 30"),
       gg = TRUE
) +
  theme_bw() +
  My_Font_Sizes +
  theme(strip.text.x = element_text(size = 20, colour = "black", angle = 360)) +
  ggsave(filename = "figures/2020_CBD_FSS_ISS_Visreg.png",
         width = 15, 
         height = 5)

#Same plot but with overlay
visreg(Post_Pene_lm, 
       "Post_Burrow_Count", 
       scale = "response", 
       by = "Pre_Pene_AVG",
       breaks = c(0, 10, 20, 30),
       layout = c(4, 1),
       ylab = "Final Soil Strength",
       xlab = "Crab Burrow Density",
       strip.names = c("Initial Soil Strength: 0", "Initial Soil Strength: 10",
                       "Initial Soil Strength: 20", "Initial Soil Strength: 30"),
       gg = TRUE,
       overlay = TRUE
) +
  theme_bw() +
  My_Font_Sizes +
  theme(strip.text.x = element_text(size = 20, colour = "black", angle = 360))

#Just plotting the relationship
visreg(Post_Pene_lm, 
       "Post_Burrow_Count", 
       scale = "response", 
       #by = "Pre_Pene_AVG",
       #breaks = c(0, 10, 20, 30),
       #layout = c(4, 1),
       ylab = "Final Soil Strength",
       xlab = "Crab Burrow Density",
       #strip.names = c("Initial Soil Strength: 0", "Initial Soil Strength: 10",
                       #"Initial Soil Strength: 20", "Initial Soil Strength: 30"),
       gg = TRUE#,
       #overlay = TRUE
) +
  theme_bw() +
  My_Font_Sizes #+
  #theme(strip.text.x = element_text(size = 20, colour = "black", angle = 360))

#Initial Soil Strength to Final Soil Strength by Site
visreg(Post_Pene_lm, 
       "Pre_Pene_AVG", 
       #scale = "response", 
       by = "Site",
       #breaks = c(0, 10, 20, 30),
       ylab = "Final Soil Strength",
       xlab = "Initial Soil Strength"
)

##Initial Soil Strength to Final Soil Strength by Burrows
visreg(Post_Pene_lm, 
       "Pre_Pene_AVG", 
       #scale = "response", 
       by = "Post_Burrow_Count",
       breaks = c(0, 10, 20, 30),
       ylab = "Final Soil Strength",
       xlab = "Initial Soil Strength"
)

## Two and Three Dimensional Visreg models
# Initial Soil Strength and Crab Density to Final Burrow Density Interaction 3D model
visreg2d(Burrows_NBglm, 
         "Pre_Pene_AVG",
         "Density_Num",
         scale = "response", 
         by = "Density_Num",
         breaks = c(0, 4, 8, 12, 16, 20),
         #ylab = "Crab Burrow Density",
         xlab = "Initial Soil Strength",
         plot.type = "rgl"
)

# Initial Soil Strength and Crab Density to Final Burrow Density Interaction Heat Map
visreg2d(Burrows_NBglm, 
         x="Pre_Pene_AVG",
         y="Density_Num",
         scale = "response", 
         main = "Final Burrow Density",
         #by = "Density_Num",
         #breaks = c(0, 4, 8, 12, 16, 20),
         ylab = "Initial Crab Density",
         xlab = "Initial Soil Strength",
         #plot.type = "rgl"
)
