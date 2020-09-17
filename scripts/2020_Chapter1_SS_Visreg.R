source("scripts/2020_Chapter1_SS_SEM.R")

#### Visreg Plot Comparison ####
#Initial Soil Strength to Final Burrow Density by Initial Crab Density
visreg(Burrows_NBglm, 
       "Pre_Pene_AVG", 
       scale = "response", 
       by = "Density_Num",
       breaks = c(seq(0, 20, 4)),
       layout = c(6, 1),
       ylab = "Crab Burrow Density",
       xlab = "Initial Soil Strength",
       gg = TRUE,
       strip.names = c("Initial Crab Density: 0", "Initial Crab Density: 4",
                       "Initial Crab Density: 8", "Initial Crab Density: 12",
                       "Initial Crab Density: 16", "Initial Crab Density: 20"),
       ) +
  theme_bw() +
  scale_y_continuous(limits = c(0, 35)) +
  My_Font_Sizes +
  theme(strip.text.x = element_text(size = 15, colour = "black", angle = 360)) +
  ggsave(filename = "2020_ISS_CBD_ICD_Visreg.png",
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
  theme(strip.text.x = element_text(size = 20, colour = "black", angle = 360)) +
  ggsave(filename = "2020_ICD_CBD_ISS_Visreg.png",
         width = 15, 
         height = 5)

#Initial Burrow Density to Final Burrow Density by Site
visreg(Post_Pene_lm, 
       "Post_Burrow_Count", 
       #scale = "response", 
       by = "Site",
       #breaks = c(0, 4, 8, 12, 16, 20),
       ylab = "Final Soil Strength",
       xlab = "Crab Burrow Density"
)

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
  ggsave(filename = "2020_CBD_FSS_ISS_Visreg.png",
         width = 15, 
         height = 5)

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