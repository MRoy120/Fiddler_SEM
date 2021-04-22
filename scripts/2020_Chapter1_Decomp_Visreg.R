source("scripts/2020_Chapter1_Decomp_SEM.R")

#Decomp Visreg Plots
visreg(Decomp_lm, 
       "Post_Burrow_Count", 
       scale = "response", 
       by = "Depth",
       xlab = "Burrow Density\n(burrows per plot)",
       ylab = "Litterbag Mass\nTransformation (grams)",
       gg = TRUE,
       line.par = list(col = "slategray")) +
  theme_bw(base_family = "Times") +
  My_Font_Sizes +
  geom_point(alpha = 0.7, 
             size = 0.95,
             aes(color = Depth)) +
  scale_color_manual(values = c("peru", "steelblue2")) +
  #scale_colour_discrete(name  = "Site",
  #breaks = c("0", "1"),
  #labels = c("PIE", "NAN")) +
  labs(title = "Interaction Plot:",
       subtitle = "Crab Burrow Density vs.\nLitterbag Mass faceted for each Depth of Bag Burial") +
  theme(plot.title = element_text(size = 18, 
                                  face = "bold"),
        plot.subtitle = element_text(size = 14, 
                                     face = "bold"),
        strip.text.x = element_text(size = 15, 
                                    colour = "black", 
                                    angle = 360),
        legend.position="none") +
  ggsave(filename = "figures/2020_Decomp_Depth_Visreg.png",
         width = 8, 
         height = 5)

#And now with Site
visreg(Decomp_lm_vis, 
       "Depth_Chr", 
       scale = "response", 
       by = "Site",
       ylab = "Litterbag Mass\nTransformation (grams)",
       xlab = "Depth\n(cm)",
       strip.names = c("PIE", "NAN"),
       gg = TRUE,
       line.par = list(col = "slategray")
) +
  theme_bw(base_family = "Times") +
  #scale_color_discrete() +
  My_Font_Sizes +
  #scale_color_manual(values = c("darkred", "dodgerblue3")) +
  #scale_colour_discrete(name  = "Site",
  #breaks = c("0", "1"),
  #labels = c("PIE", "NAN")) +
  labs(title = "Interaction Plot:",
       subtitle = "Depth of Bag Burial vs.\nLitterbag Mass faceted for each Site") +
  
  #scale_x_discrete(breaks = c("Five", "Fifteen")) +
  theme(plot.title = element_text(size = 18, 
                                  face = "bold"),
        plot.subtitle = element_text(size = 14, 
                                     face = "bold"),
        strip.text.x = element_text(size = 15, 
                                    colour = "black", 
                                    angle = 360),
        legend.position="none") +
  ggsave(filename = "figures/2020_Decomp_Site_Visreg.png",
         width = 8, 
         height = 5)

#Initial Soil Strength vs Decomp for each site
visreg(Decomp_lm, 
       "Pre_Pene_AVG", 
       scale = "response", 
       by = "Site",
       ylab = "Litterbag Mass\n(grams)",
       xlab = "Initial Soil Strength\n(cm)",
       strip.names = c("PIE", "NAN"),
       gg = TRUE,
       line.par = list(col = "slategray")
) +
  theme_bw(base_family = "Times") +
  scale_color_discrete() +
  My_Font_Sizes +
  scale_color_manual(values = c("darkred", "dodgerblue3")) +
  geom_point(alpha = 0.7, 
             size = 0.95,
             aes(color = Site)) +
  #scale_colour_discrete(name  = "Site",
  #breaks = c("0", "1"),
  #labels = c("PIE", "NAN")) +
  labs(title = "Interaction Plot:",
       subtitle = "Initial Soil Strength vs.\nLitterbag Mass faceted for each Site") +
  theme(plot.title = element_text(size = 18, 
                                  face = "bold"),
        plot.subtitle = element_text(size = 14, 
                                     face = "bold"),
        strip.text.x = element_text(size = 15, 
                                    colour = "black", 
                                    angle = 360),
        legend.position="none")

# Important plot: Depth vs. Decomp for each burrow density ####
visreg(Decomp_lm_vis, 
       "Depth_Chr", 
       scale = "response", 
       by = "Post_Burrow_Count",
       ylab = "Litterbag Mass\n(grams)",
       xlab = "Depth\n(cm)",
       breaks = c(seq(0, 30, 10)),
       layout = c(4, 1),
       gg = TRUE,
       line.par = list(col = "slategray"),
       strip.names = c("Burrow Density: 0", "Burrow Density: 10",
                       "Burrow Density: 20", "Burrow Density: 30")) +
  theme_bw(base_family = "Times") +
  My_Font_Sizes +
  #scale_color_manual(values = c("darkred", "dodgerblue3")) +
  #geom_point(alpha = 0.7, 
             #size = 0.95) +
  #scale_colour_discrete(name  = "Site",
  #breaks = c("0", "1"),
  #labels = c("PIE", "NAN")) +
  labs(title = "Interaction Plot:",
       subtitle = "Depth of Bag Burial vs.\nLitterbag Mass faceted for each Crab Burrow Density") +
  theme(plot.title = element_text(size = 18, 
                                  face = "bold"),
        plot.subtitle = element_text(size = 14, 
                                     face = "bold"),
        strip.text.x = element_text(size = 15, 
                                    colour = "black", 
                                    angle = 360),
        legend.position="none") +
  ggsave(filename = "figures/2020_Decomp_Depth_Burrows_Visreg.png",
         width = 9, 
         height = 5)

# Heat Map ####
visreg2d(Decomp_lm, 
         x="Post_Burrow_Count",
         y="Depth",
         scale = "response", 
         #main = "Final Burrow Density",
         xlab = "Burrow Density (burrows/plot)",
         ylab = "Depth (cm below surface)",
         #breaks = c(0, 4, 8, 12, 16, 20),
         #col = colorRampPalette(brewer.pal(9,"YlOrRd"))(20),
         plot.type='gg'
) +
  scale_fill_distiller("Degree of\nDecomposition",
                       palette = "RdYlBu") +
  scale_y_continuous(trans = "reverse") +
  #scale_colour_brewer(palette = "PiYG", direction = - 1) +
  theme_bw(base_size = 18) +
  theme(axis.text = element_text(size = 18),
        axis.title = element_text(size = 22)) +
  labs(title = "Interaction Plot of Burrow Density, Depth,\nand Decomposition",
       subtitle = "Heat Map") +
  ggsave(filename = "figures/2021_Decomp_Interaction.png",
         width = 10, 
         height = 8)

