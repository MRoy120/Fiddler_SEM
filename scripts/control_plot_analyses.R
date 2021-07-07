source("scripts/2020_data_cleaning.R")

# NAN ####
caged_control <- combined_data %>%
  filter(Density_NN == "Caged_Control")

control_plot <- combined_data %>%
  filter(Density_NN == "Control_Plot")

control <- full_join(caged_control, control_plot)

control_NAN <- control %>%
  filter(Location == "NAN") %>%
  dplyr::select(-c(Year_2, Location_2, Cage_Num_2, Replication_2, Density_NN_2,
                   Post_Crab_Count, Post_Mussels, Post_Pene_1, Post_Pene_2, Post_Pene_3,
                   Pre_Pene_1, Pre_Pene_2, Pre_Pene_3, Pre_Dead_SD, Post_Dead_SD, Density_Num))

control_NAN_long <- pivot_longer(data = control_NAN,
                                 cols = Pre_Live_SD:Spartina_Biomass,
                                 values_to = "Measurements",
                                 names_to = "Metrics")

control_ttest_NAN <- t.test(data = control_NAN_long, Measurements ~ Density_NN)

control_anova_NAN <- lm(data = control_NAN_long, Measurements ~ Density_NN * Metrics)
summary(control_anova_NAN)

# PIE ####
four_plot <- combined_data %>%
  filter(Density_NN == "Four")

plot_comparison <- full_join(control_plot, four_plot)

control_PIE <- plot_comparison %>%
  filter(Location == "PIE") %>%
  dplyr::select(-c(Year_2, Location_2, Cage_Num_2, Replication_2, Density_NN_2,
                   Post_Crab_Count, Post_Mussels, Post_Pene_1, Post_Pene_2, Post_Pene_3,
                   Pre_Pene_1, Pre_Pene_2, Pre_Pene_3, Pre_Dead_SD, Post_Dead_SD, Density_Num))

control_PIE_long <- pivot_longer(data = control_PIE,
                                 cols = Pre_Live_SD:Spartina_Biomass,
                                 values_to = "Measurements",
                                 names_to = "Metrics")

control_ttest_PIE <- t.test(data = control_PIE_long, Measurements ~ Density_NN)

control_anova_PIE <- lm(data = control_PIE_long, Measurements ~ Density_NN * Metrics)
summary(control_anova_PIE)


