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
        strip.text.x = element_text(size = 18, colour = "black", angle = 360),
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
       xlab = "Depth (cm)",
       strip.names = c("PIE", "NAN"),
       gg = TRUE,
       line.par = list(col = "slategray")
) +
  theme_bw(base_family = "Times") +
  scale_color_discrete() +
  My_Font_Sizes +
  scale_color_manual(values = c("darkred", "dodgerblue3")) +
  #scale_colour_discrete(name  = "Site",
  #breaks = c("0", "1"),
  #labels = c("PIE", "NAN")) +
  labs(title = "Interaction Plot:",
       subtitle = "Depth of Bag Burial vs.\nLitterbag Mass faceted for each Site") +
  theme(plot.title = element_text(size = 18, 
                                  face = "bold"),
        plot.subtitle = element_text(size = 14, 
                                     face = "bold"),
        strip.text.x = element_text(size = 18, colour = "black", angle = 360),
        legend.position="none") +
  ggsave(filename = "figures/2020_Decomp_Site_Visreg.png",
         width = 8, 
         height = 5)

