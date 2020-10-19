#### Loading in My Data ####
combined_data <- read_csv("data/Complete_CrabCageExp.csv")

#Make Year Discrete
combined_data$Year <- as.character(combined_data$Year)

#### Manipulating My Data ####
#### The Dataset without Decomposition or Belowground Biomass ####
#Filter out the treatments
combined_data_controls <- filter(combined_data, Density_NN %in% c("Caged_Control"))

combined_data_controls_PIE2017 <- filter(combined_data_controls, Location %in% "PIE")
combined_data_controls_PIE2017 <- filter(combined_data_controls_PIE2017, Year %in% "2017")
combined_data_controls_PIE2017 <- combined_data_controls_PIE2017 %>%
  mutate(Mean_Burrows = mean(Post_Burrow_Count))

combined_data_controls_PIE2018 <- filter(combined_data_controls, Location %in% "PIE")
combined_data_controls_PIE2018 <- filter(combined_data_controls_PIE2018, Year %in% "2018")
combined_data_controls_PIE2018 <- combined_data_controls_PIE2018 %>%
  mutate(Mean_Burrows = mean(Post_Burrow_Count))

combined_data_controls_NAN2017 <- filter(combined_data_controls, Location %in% "NAN")
combined_data_controls_NAN2017 <- filter(combined_data_controls_NAN2017, Year %in% "2017")
combined_data_controls_NAN2017 <- combined_data_controls_NAN2017 %>%
  mutate(Mean_Burrows = mean(Post_Burrow_Count) + 0.5)

combined_data_controls_NAN2018 <- filter(combined_data_controls, Location %in% "NAN")
combined_data_controls_NAN2018 <- filter(combined_data_controls_NAN2018, Year %in% "2018")
combined_data_controls_NAN2018 <- combined_data_controls_NAN2018 %>%
  mutate(Mean_Burrows = mean(Post_Burrow_Count))

combined_data_controls_PIE <- full_join(combined_data_controls_PIE2017, combined_data_controls_PIE2018)
combined_data_controls_NAN <- full_join(combined_data_controls_NAN2017, combined_data_controls_NAN2018)
combined_data_controls_2 <- full_join(combined_data_controls_NAN, combined_data_controls_PIE)

#Filter out the control plots
combined_data_nocontrols <- filter(combined_data, Density_NN %in% c("Four", "Eight",
                                                                    "Twelve", "Sixteen",
                                                                    "Twenty"))

combined_data_nocontrols_PIE2017 <- filter(combined_data_nocontrols, Location %in% "PIE")
combined_data_nocontrols_PIE2017 <- filter(combined_data_nocontrols_PIE2017, Year %in% "2017")
combined_data_nocontrols_PIE2017 <- combined_data_nocontrols_PIE2017 %>%
  mutate(Mean_Burrows = 0)

combined_data_nocontrols_PIE2018 <- filter(combined_data_nocontrols, Location %in% "PIE")
combined_data_nocontrols_PIE2018 <- filter(combined_data_nocontrols_PIE2018, Year %in% "2018")
combined_data_nocontrols_PIE2018 <- combined_data_nocontrols_PIE2018 %>%
  mutate(Mean_Burrows = 0)

combined_data_nocontrols_NAN2017 <- filter(combined_data_nocontrols, Location %in% "NAN")
combined_data_nocontrols_NAN2017 <- filter(combined_data_nocontrols_NAN2017, Year %in% "2017")
combined_data_nocontrols_NAN2017 <- combined_data_nocontrols_NAN2017 %>%
  mutate(Mean_Burrows = 6)

combined_data_nocontrols_NAN2018 <- filter(combined_data_nocontrols, Location %in% "NAN")
combined_data_nocontrols_NAN2018 <- filter(combined_data_nocontrols_NAN2018, Year %in% "2018")
combined_data_nocontrols_NAN2018 <- combined_data_nocontrols_NAN2018 %>%
  mutate(Mean_Burrows = 18)

combined_data_nocontrols_PIE <- full_join(combined_data_nocontrols_PIE2017, combined_data_nocontrols_PIE2018)
combined_data_nocontrols_NAN <- full_join(combined_data_nocontrols_NAN2017, combined_data_nocontrols_NAN2018)
combined_data_nocontrols_2 <- full_join(combined_data_nocontrols_NAN, combined_data_nocontrols_PIE)

#Now create a new column for no controls called Plot_Type = Treatment for no controls
combined_data_nocontrols_2 <- combined_data_nocontrols_2 %>%
  group_by(Location, Year) %>%
  mutate(Plot_Type = "Treatment") %>%
  ungroup()

#Now do the same thing for the controls, Plot_Type = Control for no controls
combined_data_controls_2 <- combined_data_controls_2 %>%
  group_by(Location, Year) %>%
  mutate(Plot_Type = "Control") %>%
  ungroup()

#Join the two data frames together
combined_data_full <- full_join(combined_data_nocontrols_2, combined_data_controls_2)

combined_data_full <- combined_data_full %>%
  mutate(Burrow_Diff = abs(Post_Burrow_Count - Mean_Burrows))

## Location/Site
#Let's create a new column of site, and make it 0 and 1
combined_data_full <- combined_data_full %>%
  mutate(Site = as.numeric(recode_factor(Location,
                                         "NAN" = 0,
                                         "PIE" = 1))) 

# Ok, for some reason, when I do the above, it makes one of the parameters 2
# Let's make that 0
combined_data_full$Site[combined_data_full$Site == "2"] <- "0"

# Let's make that a number again
combined_data_full$Site <- as.numeric(combined_data_full$Site)

## Year
#Let's make year a factor of 0 and 1
combined_data_full <- combined_data_full %>%
  mutate(Year_Fac = as.numeric(recode_factor(Year,
                                             "2017" = 0,
                                             "2018" = 1))) 

# Ok, for some reason, when I do the above, it makes one of the parameters 2
# Let's make that 0
combined_data_full$Year_Fac[combined_data_full$Year_Fac == "2"] <- "0"

# Let's make that a number again
#combined_data_full$Year_Fac <- as.factor(combined_data_full$Year_Fac)
combined_data_full$Year_Fac <- as.numeric(combined_data_full$Year_Fac)

#Ok, let's look at it, and see if Site and Year are now numeric
#str(combined_data_full)

#OK, great!

#Separate out the complete dataset by Year only
combined_data_full_2017 <- filter(combined_data_full, Year %in% "2017")
combined_data_full_2018 <- filter(combined_data_full, Year %in% "2018")
#str(combined_data_full_2018)

#Separate Out By Each Site
#Nantucket
fidd_NAN <- filter(combined_data_full, Location %in% "NAN")

#Plum Island Estuary (PIE)
fidd_PIE <- filter(combined_data_full, Location %in% "PIE")

#Renaming Column Names
combined_data_full_2 <- combined_data_full %>%
  dplyr::select(Year, Year_Fac, Location, Site, Density_Num, Post_Burrow_Count, 
                Pre_Live_SD, Post_Live_SD, Pre_Pene_AVG, Post_Pene_AVG, 
                Spartina_Biomass) %>%
  dplyr::rename(Crab_Density = "Density_Num",
                Burrow_Density = "Post_Burrow_Count",
                Initial_Soil_Strength = "Pre_Pene_AVG",
                Final_Soil_Strength = "Post_Pene_AVG",
                Initial_Spartina_Density = "Pre_Live_SD",
                Final_Spartina_Density = "Post_Live_SD",
                Spartina_Biomass = "Spartina_Biomass",
                Year_NonFactor = "Year",
                Year = "Year_Fac")

#### Decomposition ####
#Load in the Decomp Data
Decomp_2018 <- read_csv("data/Decomp_Summer_2018_2.csv")
Decomp_2018_Wider <- Decomp_2018 %>%
  pivot_wider(names_from = Depth, values_from = End_Mass_LB)

#Make Depth a Character
Decomp_2018$Depth <- as.character(Decomp_2018$Depth)

#Make Year a Character
#Decomp_2018$Year <- as.character(Decomp_2018$Year)

#Filter out 2018 data again, but for the raw combined_data Object
combined_data_2018 <- filter(combined_data, Year %in% "2018")

#Ok, select out Location, Cage_Num, Post_Burrow_Count, Post_Crab_Count
Decomp_2 <- combined_data_2018 %>%
  group_by(Location, Cage_Num, Post_Burrow_Count, Post_Crab_Count) %>%
  dplyr::select(Location, Cage_Num, Post_Burrow_Count, Post_Crab_Count) %>%
  ungroup()

#OK, now join the two together
Decomp_2018 <- full_join(Decomp_2, Decomp_2018) 
Decomp_2018$Year <- as.character(Decomp_2018$Year)
Decomp_2018_2 <- factor(Decomp_2018$Depth, levels = c("5", "15"))
Decomp_2018_3 <- full_join(combined_data_full_2018, Decomp_2018) 
Decomp_2018_3 <- na.omit(Decomp_2018_3)
Decomp_2018_3$Depth <- as.numeric(Decomp_2018_3$Depth)
#Decomp_2018_3$Depth <- as.character(Decomp_2018_3$Depth)
#Decomp_2018_3$Depth <- as.factor(Decomp_2018_3$Depth)
#Decomp_2018_3$Depth <- factor(Decomp_2018_3$Depth, labels=c("5","15"))

Decomp_2018_3 <- Decomp_2018_3 %>%
  group_by(End_Mass_LB) %>%
  mutate(Mass_Trans = 1.02-End_Mass_LB) %>%
  ungroup()

Decomp_2018_3$Depth <- as.character(Decomp_2018_3$Depth)

Depths <- c(`5` = "Five", `15` = "Fifteen")

Decomp_2018_3 <- Decomp_2018_3 %>%
  group_by(Depth) %>%
  mutate(Depth_Chr = as.character(Depths[Decomp_2018_3$Depth])) %>%
  ungroup()

Decomp_2018_3$Depth <- as.numeric(Decomp_2018_3$Depth)

Decomp_2018_Wider <- full_join(Decomp_2, Decomp_2018_Wider)
Decomp_2018_Wider$Year <- as.character(Decomp_2018_Wider$Year)
Decomp_2018_Wider_2 <- full_join(combined_data_full_2018, Decomp_2018_Wider)
Decomp_2018_Wider_2 <- na.omit(Decomp_2018_Wider_2)

Decomp_2018_4 <- Decomp_2018_3 %>%
  dplyr::select(Year, Year_Fac, Location, Site, Density_Num, Post_Burrow_Count, 
                Pre_Live_SD, Post_Live_SD, Pre_Pene_AVG, Post_Pene_AVG, 
                Spartina_Biomass, Depth, End_Mass_LB) %>%
  dplyr::rename(Crab_Density = "Density_Num",
                Burrow_Density = "Post_Burrow_Count",
                Initial_Soil_Strength = "Pre_Pene_AVG",
                Final_Soil_Strength = "Post_Pene_AVG",
                Initial_Spartina_Density = "Pre_Live_SD",
                Final_Spartina_Density = "Post_Live_SD",
                Spartina_Biomass = "Spartina_Biomass",
                Year_NonFactor = "Year",
                Year = "Year_Fac",
                Final_Litterbag_Mass = "End_Mass_LB")

#### Font Sizes and Colors ####

My_Font_Sizes = theme(axis.title = element_text(face = "bold", size = 18), 
                      axis.text = element_text(size = 16),
                      legend.text = element_text(size = 16),
                      legend.title = element_text(size = 18))

Location_Colors_Line = scale_color_manual("Location", values = c("NAN" = "steelblue4", 
                                                                 "PIE" = "indianred4"))

Location_Colors_Bar <- c(scale_fill_manual("Location", values = c("NAN" = "steelblue4", 
                                                                  "PIE" = "indianred4")))

Year_Colors_Line <- scale_color_manual("Year", values = c("2017" = "darkgreen", 
                                                          "2018" = "slategray4"))

Year_Colors_Bar <- scale_fill_manual("Year", values = c("2017" = "darkgreen", 
                                                        "2018" = "slategray4"))

PlotType_Colors_Line <- scale_color_manual("Plot Type", values = c("Control" = "tomato4", 
                                                                   "Treatment" = "wheat"))

PlotType_Colors_Bar <- scale_fill_manual("Plot Type", values = c("Control" = "tomato4", 
                                                                 "Treatment" = "wheat"))

Depth_Colors_Line <- scale_color_manual("Depth", values = c("5" = "darkgoldenrod2", 
                                                            "15" = "papayawhip"))

Depth_Colors_Bar <- scale_fill_manual("Depth", values = c("5" = "darkgoldenrod2", 
                                                          "15" = "papayawhip"))

Density_NN_Colors <- scale_color_manual("Initial Density", 
                                        values = c("Control Plot" = "red4",
                                                   "Caged Control" = "orange1",
                                                   "Four" = "yellow1",
                                                   "Eight" = "green4",
                                                   "Twelve" = "azure2",
                                                   "Sixteen" = "purple3",
                                                   "Twenty" = "black"))

Density_NN_Colors_2 <- scale_color_manual("Initial Density", 
                                          values = c("Caged Control" = "orange1",
                                                     "Four" = "yellow1",
                                                     "Eight" = "green4",
                                                     "Twelve" = "azure2",
                                                     "Sixteen" = "purple3",
                                                     "Twenty" = "black"))

