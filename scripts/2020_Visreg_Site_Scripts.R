VRB <- visreg2d(Burrows_NBglm, 
                x="Pre_Pene_AVG",
                y="Density_Num"#,
                #scale = "response", 
                #main = "Final Burrow Density"#,
                #by = "Density_Num",
                #breaks = c(0, 4, 8, 12, 16, 20),
                #ylab = "Initial Crab Density",
                #xlab = "Initial Soil Strength"#,
                #plot.type = "rgl"
)
str(VRB)
show(VRB)
show(VRB_2)


#By Site
visreg(Burrows_NBglm, 
       "Pre_Pene_AVG", 
       scale = "response", 
       by = "Site",
       #breaks = c(0, 4, 8, 12, 16, 20),
       ylab = "Crab Burrow Density",
       xlab = "Initial Soil Strength"
)

visreg(Post_Pene_lm, "Post_Burrow_Count", by = "Site", overlay = TRUE)


#OK, I'll model the same thing for Burrows_NBglm, but for each site
#NAN
Burrows_NBglm_NAN <- glm.nb(data = fidd_NAN,
                            Post_Burrow_Count ~ 
                              Density_Num *
                              Pre_Pene_AVG +
                              Year_Fac
                            ,
                            link = "log"
)
summary(Burrows_NBglm_NAN)

#PIE
Burrows_NBglm_PIE <- glm.nb(data = fidd_PIE,
                            Post_Burrow_Count ~ 
                              Density_Num *
                              Pre_Pene_AVG +
                              Year_Fac
                            ,
                            link = "log"
)
summary(Burrows_NBglm_PIE)
summary(Burrows_NBglm)

#NAN
# Initial Soil Strength and Crab Density to Final Burrow Density Interaction Heat Map
visreg2d(Burrows_NBglm_NAN, 
         "Pre_Pene_AVG",
         "Density_Num",
         scale = "response", 
         main = "Final Burrow Density NAN",
         #by = "Density_Num",
         #breaks = c(0, 4, 8, 12, 16, 20),
         ylab = "Initial Crab Density",
         xlab = "Initial Soil Strength"#,
         #plot.type = "rgl"
)

#NAN
visreg(Burrows_NBglm_NAN, 
       "Density_Num", 
       scale = "response", 
       by = c("Pre_Pene_AVG"),
       breaks = c(0, 10, 20, 30),
       ylab = "Crab Burrow Density",
       xlab = "Initial Crab Density",
       main = "NAN"
       #gg = TRUE
) #+
#theme_bw() #+
#aes(color = "Site")

visreg(Burrows_NBglm_NAN, 
       "Pre_Pene_AVG", 
       scale = "response", 
       by = c("Density_Num"),
       breaks = c(0, 4, 8, 12, 16, 20),
       ylab = "Crab Burrow Density",
       xlab = "Initial Soil Strength",
       main = "NAN"
       #gg = TRUE
) #+
#theme_bw() #+
#aes(color = "Site")

visreg(Burrows_NBglm_NAN, 
       "Pre_Pene_AVG", 
       scale = "response", 
       #by = c("Density_Num"),
       #breaks = c(0, 4, 8, 12, 16, 20),
       ylab = "Crab Burrow Density",
       xlab = "Initial Soil Strength",
       main = "NAN"
       #gg = TRUE
) #+
#theme_bw() #+
#aes(color = "Site")

#PIE
# Initial Soil Strength and Crab Density to Final Burrow Density Interaction Heat Map
visreg2d(Burrows_NBglm_PIE,
         "Pre_Pene_AVG",
         "Density_Num",
         scale = "response", 
         main = "Final Burrow Density PIE",
         #by = "Density_Num",
         #breaks = c(0, 4, 8, 12, 16, 20),
         ylab = "Initial Crab Density",
         xlab = "Initial Soil Strength"#,
         #plot.type = "rgl"
)

#PIE
visreg(Burrows_NBglm_PIE, 
       "Density_Num", 
       scale = "response", 
       by = c("Pre_Pene_AVG"),
       breaks = c(0, 10, 20, 30),
       ylab = "Crab Burrow Density",
       xlab = "Initial Crab Density",
       main = "PIE"
       #gg = TRUE
) #+
#theme_bw() #+
#aes(color = "Site")

visreg(Burrows_NBglm_PIE, 
       "Pre_Pene_AVG", 
       scale = "response", 
       by = c("Density_Num"),
       breaks = c(0, 4, 8, 12, 16, 20),
       ylab = "Crab Burrow Density",
       xlab = "Initial Soil Strength",
       main = "PIE"
       #gg = TRUE
) #+
#theme_bw() #+
#aes(color = "Site")

#Compare Initial Soil Strength to Burrow Density
ggplot(data = combined_data_full, 
       mapping = aes(x = Pre_Pene_AVG, 
                     y = Post_Burrow_Count, 
                     color = Location
       )) +
  geom_point() +
  geom_smooth(method = "lm",
              se = FALSE) +
  ylab("Number of Burrows per Plot") +
  xlab("Initial Soil Strength") +
  theme_bw() +
  My_Font_Sizes +
  Location_Colors_Line

summary(lm(data = combined_data_full, Post_Burrow_Count ~ Pre_Pene_AVG * Location))
summary(lm(data = fidd_PIE, Post_Burrow_Count ~ Pre_Pene_AVG))
summary(lm(data = fidd_NAN, Post_Burrow_Count ~ Pre_Pene_AVG))


#OK, I'll model the same thing for Burrows_NBglm, but for each year
#NAN
Burrows_NBglm_2017 <- glm.nb(data = combined_data_full_2017,
                        Post_Burrow_Count ~ 
                          Density_Num *
                          Pre_Pene_AVG +
                          Site
                        ,
                        link = "log"
                        )
summary(Burrows_NBglm_2017)

#PIE
Burrows_NBglm_2018 <- glm.nb(data = combined_data_full_2018,
                        Post_Burrow_Count ~ 
                          Density_Num *
                          Pre_Pene_AVG +
                          Site
                        ,
                        link = "log"
                        )
summary(Burrows_NBglm_2018)
summary(Burrows_NBglm)

#NAN
# Initial Soil Strength and Crab Density to Final Burrow Density Interaction Heat Map
visreg2d(Burrows_NBglm_2017, 
         "Pre_Pene_AVG",
         "Density_Num",
         scale = "response", 
         main = "Final Burrow Density 2017",
         #by = "Density_Num",
         #breaks = c(0, 4, 8, 12, 16, 20),
         ylab = "Initial Crab Density",
         xlab = "Initial Soil Strength"#,
         #plot.type = "rgl"
         )

visreg(Burrows_NBglm_2017, 
       "Density_Num", 
       scale = "response", 
       by = c("Pre_Pene_AVG"),
       breaks = c(0, 10, 20, 30),
       ylab = "Crab Burrow Density",
       xlab = "Initial Crab Density",
       main = "2017"
       #gg = TRUE
       ) #+
  #theme_bw() #+
  #aes(color = "Site")

visreg(Burrows_NBglm_2017, 
       "Pre_Pene_AVG", 
       scale = "response", 
       by = c("Density_Num"),
       breaks = c(0, 4, 8, 12, 16, 20),
       ylab = "Crab Burrow Density",
       xlab = "Initial Soil Strength",
       main = "2017"
       #gg = TRUE
       ) #+
  #theme_bw() #+
  #aes(color = "Site")

visreg2d(Burrows_NBglm_2018, 
         "Pre_Pene_AVG",
         "Density_Num",
         scale = "response", 
         main = "Final Burrow Density 2018",
         #by = "Density_Num",
         #breaks = c(0, 4, 8, 12, 16, 20),
         ylab = "Initial Crab Density",
         xlab = "Initial Soil Strength"#,
         #plot.type = "rgl"
         )


visreg(Burrows_NBglm_2018, 
       "Density_Num", 
       scale = "response", 
       by = c("Pre_Pene_AVG"),
       breaks = c(0, 10, 20, 30),
       ylab = "Crab Burrow Density",
       xlab = "Initial Crab Density",
       main = "2018"
       #gg = TRUE
       ) #+
  #theme_bw() #+
  #aes(color = "Site")

visreg(Burrows_NBglm_2018, 
       "Pre_Pene_AVG", 
       scale = "response", 
       by = c("Density_Num"),
       breaks = c(0, 4, 8, 12, 16, 20),
       ylab = "Crab Burrow Density",
       xlab = "Initial Soil Strength",
       main = "2018"
       #gg = TRUE
       ) #+
  #theme_bw() #+
  #aes(color = "Site")


visreg(Burrows_NBglm, 
       "Site", 
       scale = "response", 
       by = c("Year_Fac"),
       #breaks = c(0, 4, 8, 12, 16, 20),
       ylab = "Crab Burrow Density",
       xlab = "Site"#,
       #main = "2018"
       #gg = TRUE
       ) #+
  #theme_bw() #+
  #aes(color = "Site")






#OK, now let's look at the combined affect of burrows and initial soil strength on final soil strength
visreg2d(Post_Pene_lm,
         "Pre_Pene_AVG",
         "Post_Burrow_Count",
         scale = "response", 
         main = "Final Soil Strength",
         #by = "Density_Num",
         #breaks = c(0, 4, 8, 12, 16, 20),
         ylab = "Final Burrow Count",
         xlab = "Initial Soil Strength"#,
         #plot.type = "rgl"
)