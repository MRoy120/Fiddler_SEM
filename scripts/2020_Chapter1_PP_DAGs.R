source("scripts/2020_Chapter1_PP_SEM.R")

#### Primary Production and Soil Strength DAGs - DiagrammeR Plots ####
## Including Site and Year
grViz("digraph Soil_Strength {
      # a 'graph' statement
      graph [overlap = false,
             fontsize = 14]

      # several 'node' statements
      # Exogenous Variables
      node [shape = rectangle,
            fontname = Helvetica,
            width = 1.3,
            fontcolor = darkslategray,
            color = darkslategray,
            nodesep = 1,
            penwidth = 2]
      Crab_Density [label = '@@1']
      Site [label = '@@5']
      Year [label = '@@6']
      
      # Endogenous Variables
      node [shape = rectangle,
            fixedsize = true,
            width = 1.8,
            color = steelblue,
            fontcolor = darkslategray,
            penwidth = 2] 
      Burrow_Density [label = '@@3']
      Initial_SS [label = '@@4', color = darkslategray]
      Final_SS [label = '@@7']
  
      # Soil Strength Interaction
      node [shape = rectangle,
            fixedsize = true,
            width = 2,
            height = 0.9,
            color = steelblue,
            fontcolor = darkslategray,
            penwidth = 2] 
      CrabSoil_Intrctn [label = '@@2']
      
      # Primary Production
      node [shape = rectangle,
            fixedsize = true,
            width = 2,
            color = forestgreen,
            fontcolor = darkslategray,
            penwidth = 2] 
      Pre_Live_SD [label = '@@8']
      Spartina_Biomass [label = '@@9']
      Post_Live_SD [label = '@@10']
      Pre_post_Intrctn [label = '@@11', height = 0.9]
      
      # Soil Shoots Interaction
      node [shape = rectangle,
            fixedsize = true,
            width = 2.2,
            height = 0.9,
            color = CadetBlue,
            fontcolor = darkslategray,
            penwidth = 2] 
      SoilShoots_Intrctn [label = '@@12']
  
  # several 'edge' statements
  #Soil Strength Exogenous Variables
  edge [color = grey, arrowhead = normal, penwidth = 1, minlen = 3]
  Initial_SS->Burrow_Density
  Crab_Density->Burrow_Density
  Initial_SS->Spartina_Biomass [color = forestgreen, arrowhead = normal, penwidth = 5, minlen = 3]
  Initial_SS->Post_Live_SD 
  
  #Primary Production Exogenous Variables
  edge [color = forestgreen, arrowhead = normal, penwidth = 5, minlen = 3]
  Pre_Live_SD -> Final_SS
  Pre_Live_SD -> Spartina_Biomass 
  Pre_Live_SD -> Post_Live_SD 
  Pre_post_Intrctn -> Spartina_Biomass
  Pre_post_Intrctn -> Final_SS
  Burrow_Density -> Spartina_Biomass [color = grey, arrowhead = normal, penwidth = 1, minlen = 3]
  Final_SS -> Spartina_Biomass [color = grey, arrowhead = normal, penwidth = 1, minlen = 3]
  Burrow_Density -> Post_Live_SD [color = grey, arrowhead = normal, penwidth = 1, minlen = 3]
  
  #All Endogenous Variables
  edge [color = DimGray, arrowhead = normal, penwidth = 5, minlen = 5]
  Site->Burrow_Density
  Year->Burrow_Density
  Burrow_Density->Final_SS [color = steelblue]
  Site->Initial_SS
  Year->Initial_SS
  Site->Final_SS
  Year->Final_SS
  Initial_SS->Final_SS
  Year -> Post_Live_SD
  Post_Live_SD->Spartina_Biomass [color = forestgreen]
  Site -> Spartina_Biomass
  
  edge [color = steelblue, arrowhead = normal, penwidth = 5, minlen = 4]
  CrabSoil_Intrctn->Burrow_Density
  
  edge [color = CadetBlue arrowhead = normal, penwidth = 5, minlen = 4]
  SoilShoots_Intrctn->Spartina_Biomass
  }

  [1]: 'Crab Density'
  [2]: 'Crab Density and\\nInitial Soil Strength\\nInteraction\\n'
  [3]: 'Burrow Density'
  [4]: 'Initial Soil Strength'
  [5]: 'Site'
  [6]: 'Year'
  [7]: 'Final Soil Strength'
  [8]: 'Initial Shoot Density'
  [9]: 'Spartina Biomass'
  [10]: 'Final Shoot Density'
  [11]: 'Initial Shoot Density and\\nFinal Shoot Density\\nInteraction\\n'
  [12]: 'Final Soil Strength and\\nFinal Shoot Density\\nInteraction\\n'
      
") 

#### Omitting Site and Year ####
grViz("digraph Soil_Strength {
      # a 'graph' statement
      graph [overlap = false,
             fontsize = 14]

      # several 'node' statements
      # Exogenous Variables
      node [shape = rectangle,
            fontname = Helvetica,
            width = 1.3,
            fontcolor = darkslategray,
            color = darkslategray,
            nodesep = 1,
            penwidth = 2]
      Crab_Density [label = '@@1']
      
      # Endogenous Variables
      node [shape = rectangle,
            fixedsize = true,
            width = 1.8,
            color = steelblue,
            fontcolor = darkslategray,
            penwidth = 2] 
      Burrow_Density [label = '@@3']
      Initial_SS [label = '@@4', color = darkslategray]
      Final_SS [label = '@@5']
  
      # Soil Strength Interaction
      node [shape = rectangle,
            fixedsize = true,
            width = 2,
            height = 0.9,
            color = steelblue,
            fontcolor = darkslategray,
            penwidth = 2] 
      CrabSoil_Intrctn [label = '@@2']
      
      # Primary Production
      node [shape = rectangle,
            fixedsize = true,
            width = 2,
            color = forestgreen,
            fontcolor = darkslategray,
            penwidth = 2] 
      Pre_Live_SD [label = '@@6']
      Spartina_Biomass [label = '@@7']
      Post_Live_SD [label = '@@8']
      Pre_post_Intrctn [label = '@@9', height = 0.9, width = 2.2]
      
      # Soil Shoots Interaction
      node [shape = rectangle,
            fixedsize = true,
            width = 2.1,
            height = 0.9,
            color = CadetBlue,
            fontcolor = darkslategray,
            penwidth = 2] 
      SoilShoots_Intrctn [label = '@@10']
  
  # several 'edge' statements
  #Soil Strength Exogenous Variables
  edge [color = grey, arrowhead = normal, penwidth = 1, minlen = 3]
  Initial_SS->Burrow_Density
  Crab_Density->Burrow_Density
  Initial_SS->Spartina_Biomass [color = forestgreen, arrowhead = normal, penwidth = 5, minlen = 3]
  Initial_SS->Post_Live_SD 

  
  #Primary Production Exogenous Variables
  edge [color = forestgreen, arrowhead = normal, penwidth = 5, minlen = 3]
  Pre_Live_SD -> Final_SS
  Pre_Live_SD -> Spartina_Biomass 
  Pre_Live_SD -> Post_Live_SD 
  Pre_post_Intrctn -> Spartina_Biomass
  Pre_post_Intrctn -> Final_SS
  Burrow_Density -> Spartina_Biomass [color = grey, arrowhead = normal, penwidth = 1, minlen = 3]
  Final_SS -> Spartina_Biomass [color = grey, arrowhead = normal, penwidth = 1, minlen = 3]
  Burrow_Density -> Post_Live_SD [color = grey, arrowhead = normal, penwidth = 1, minlen = 3]
  
  #All Endogenous Variables
  edge [color = DimGray, arrowhead = normal, penwidth = 5, minlen = 5]
  Burrow_Density->Final_SS [color = steelblue]
  Initial_SS->Final_SS
  Post_Live_SD->Spartina_Biomass [color = forestgreen]
  Post_Live_SD->Final_SS [color = grey, arrowhead = normal, penwidth = 1, minlen = 3]
  Crab_Density->Spartina_Biomass [color = grey, arrowhead = normal, penwidth = 1, minlen = 3]
  
  #Crab Density and Soil Strength Interaction
  edge [color = steelblue, arrowhead = normal, penwidth = 5, minlen = 4]
  CrabSoil_Intrctn->Burrow_Density
  
  #Soil Strength and Final Shoot Density Interaction
  edge [color = CadetBlue arrowhead = normal, penwidth = 5, minlen = 4]
  SoilShoots_Intrctn->Spartina_Biomass
  }

  [1]: 'Crab Density'
  [2]: 'Crab Density and\\nInitial Soil Strength\\nInteraction\\n'
  [3]: 'Burrow Density'
  [4]: 'Initial Soil Strength'
  [5]: 'Final Soil Strength'
  [6]: 'Initial Shoot Density'
  [7]: 'Spartina Biomass'
  [8]: 'Final Shoot Density'
  [9]: 'Initial Shoot Density and\\nFinal Shoot Density\\nInteraction\\n'
  [10]: 'Final Soil Strength and\\nFinal Shoot Density\\nInteraction\\n'
      
") %>%
  export_svg %>% 
  charToRaw %>% 
  rsvg_png("figures/PP_DAG.jpg")

#### Cleaner DAG ####
grViz("digraph Soil_Strength {
      # a 'graph' statement
      graph [overlap = false,
             fontsize = 14]

      # several 'node' statements
      # Exogenous Variables
      node [shape = rectangle,
            fontname = Times,
            width = 1.3,
            fontcolor = darkslategray,
            color = darkslategray,
            nodesep = 1,
            penwidth = 2]
      Crab_Density [label = '@@1']
      
      # Endogenous Variables
      node [shape = rectangle,
            fixedsize = true,
            width = 1.8,
            color = steelblue,
            fontcolor = darkslategray,
            penwidth = 2] 
      Burrow_Density [label = '@@3']
      Initial_SS [label = '@@4', color = darkslategray]
      Final_SS [label = '@@5']
  
      # Soil Strength Interaction
      node [shape = rectangle,
            fixedsize = true,
            width = 2,
            height = 0.9,
            color = steelblue,
            fontcolor = darkslategray,
            penwidth = 2] 
      CrabSoil_Intrctn [label = '@@2']
      
      # Primary Production
      node [shape = rectangle,
            fixedsize = true,
            width = 2,
            color = forestgreen,
            fontcolor = darkslategray,
            penwidth = 2] 
      Pre_Live_SD [label = '@@6']
      Spartina_Biomass [label = '@@7']
      Post_Live_SD [label = '@@8']
      Pre_post_Intrctn [label = '@@9', height = 0.9, width = 2.2]
      
      # Soil Shoots Interaction
      node [shape = rectangle,
            fixedsize = true,
            width = 2.1,
            height = 0.9,
            color = CadetBlue,
            fontcolor = darkslategray,
            penwidth = 2] 
      SoilShoots_Intrctn [label = '@@10']
  
  # several 'edge' statements
  #Soil Strength Exogenous Variables
  edge [color = grey, arrowhead = normal, penwidth = 1, minlen = 3]
  Initial_SS->Burrow_Density
  Crab_Density->Burrow_Density
  Initial_SS->Post_Live_SD 
  
  #Primary Production Exogenous Variables
  edge [color = forestgreen, arrowhead = normal, penwidth = 5, minlen = 3]
  Pre_Live_SD -> Final_SS [color = grey, arrowhead = normal, penwidth = 1, minlen = 3]
  Pre_Live_SD -> Spartina_Biomass 
  Pre_Live_SD -> Post_Live_SD 
  Pre_post_Intrctn -> Spartina_Biomass
  Burrow_Density -> Spartina_Biomass [color = grey, arrowhead = normal, penwidth = 1, minlen = 3]
  Final_SS -> Spartina_Biomass [color = grey, arrowhead = normal, penwidth = 1, minlen = 3]
  Burrow_Density -> Post_Live_SD [color = grey, arrowhead = normal, penwidth = 1, minlen = 3]
  
  #All Endogenous Variables
  edge [color = DimGray, arrowhead = normal, penwidth = 5, minlen = 5]
  Burrow_Density->Final_SS [color = steelblue]
  Initial_SS->Final_SS
  Post_Live_SD->Spartina_Biomass [color = forestgreen]
  Crab_Density->Spartina_Biomass [color = grey, arrowhead = normal, penwidth = 1, minlen = 3]
  Crab_Density->Post_Live_SD [color = grey, arrowhead = normal, penwidth = 1, minlen = 3]
  
  #Crab Density and Soil Strength Interaction
  edge [color = steelblue, arrowhead = normal, penwidth = 5, minlen = 4]
  CrabSoil_Intrctn->Burrow_Density
  CrabSoil_Intrctn->Spartina_Biomass [color = grey, arrowhead = normal, penwidth = 1, minlen = 3]
  
  #Soil Strength and Final Shoot Density Interaction
  edge [color = CadetBlue arrowhead = normal, penwidth = 5, minlen = 4]
  SoilShoots_Intrctn->Spartina_Biomass
  }

  [1]: 'Crab Density'
  [2]: 'Crab Density and\\nInitial Soil Strength\\nInteraction\\n'
  [3]: 'Burrow Density'
  [4]: 'Initial Soil Strength'
  [5]: 'Final Soil Strength'
  [6]: 'Initial Shoot Density'
  [7]: 'Spartina Biomass'
  [8]: 'Final Shoot Density'
  [9]: 'Initial Shoot Density and\\nFinal Shoot Density\\nInteraction\\n'
  [10]: 'Final Soil Strength and\\nFinal Shoot Density\\nInteraction\\n'
      
") #%>%
  export_svg %>% 
  charToRaw %>% 
  rsvg_png("figures/PP_DAG_2.jpg")

# Simpler DAG ####
grViz("digraph Soil_Strength {
      # a 'graph' statement
      graph [layout = dot,
             overlap = false,
             fontsize = 14,
             ranksep = 0.25
             rankdir = TD]

      # several 'node' statements
      # Exogenous Variables
      node [shape = rectangle,
            fontname = Times,
            width = 1.3,
            fontcolor = darkslategray,
            color = darkslategray,
            nodesep = 1,
            penwidth = 2]
      Crab_Density [label = '@@1']
      
      # Endogenous Variables
      node [shape = rectangle,
            fixedsize = true,
            width = 1.8,
            color = steelblue,
            fontcolor = darkslategray,
            penwidth = 2] 
      Burrow_Density [label = '@@3']
      Initial_SS [label = '@@4', color = darkslategray]
      Final_SS [label = '@@5']
  
      # Soil Strength Interaction
      node [shape = rectangle,
            fixedsize = true,
            width = 2,
            height = 0.9,
            color = steelblue,
            fontcolor = darkslategray,
            penwidth = 2] 
      CrabSoil_Intrctn [label = '@@2']
      
      # Primary Production
      node [shape = rectangle,
            fixedsize = true,
            width = 2,
            color = forestgreen,
            fontcolor = darkslategray,
            penwidth = 2] 
      Spartina_Biomass [label = '@@7']
      
      # Soil Shoots Interaction
      node [shape = rectangle,
            fixedsize = true,
            width = 2.1,
            height = 0.9,
            color = CadetBlue,
            fontcolor = darkslategray,
            penwidth = 2] 
      SoilShoots_Intrctn [label = '@@10']
  
  # several 'edge' statements
  #Soil Strength Exogenous Variables
  edge [color = grey, arrowhead = normal, penwidth = 1, minlen = 3, tailport = 's']
  Initial_SS->Burrow_Density
  Crab_Density->Burrow_Density 
  
  #Primary Production Exogenous Variables
  edge [color = forestgreen, arrowhead = normal, penwidth = 5, minlen = 2]
  Burrow_Density -> Spartina_Biomass [color = grey, arrowhead = normal, penwidth = 1, minlen = 3]
  Final_SS -> Spartina_Biomass [color = grey, arrowhead = normal, penwidth = 1, minlen = 3, headport = 'n']
  
  #Crab Density and Soil Strength Interaction
  edge [color = steelblue, arrowhead = normal, penwidth = 5, minlen = 3]
  CrabSoil_Intrctn->Burrow_Density [label = '  0.0027']
  
  #All Endogenous Variables
  edge [color = DimGray, arrowhead = normal, penwidth = 5, minlen = 4]
  Burrow_Density->Final_SS [color = steelblue, label = '  -0.34']
  Initial_SS->Final_SS [label = '  0.28', tailport = 's']
  Crab_Density->Spartina_Biomass [color = grey, arrowhead = normal, penwidth = 1, minlen = 3]

  #Soil Strength and Final Shoot Density Interaction
  edge [color = CadetBlue arrowhead = normal, penwidth = 5, minlen = 3]
  SoilShoots_Intrctn->Spartina_Biomass [label = '-0.00070']
  }

  [1]: 'Crab Density'
  [2]: 'Crab Density and\\nInitial Soil Strength\\nInteraction\\n'
  [3]: 'Burrow Density\\nR2=0.97'
  [4]: 'Initial Soil Strength'
  [5]: 'Final Soil Strength\\nR2=0.58'
  [6]: 'Initial Shoot Density'
  [7]: 'Spartina Biomass\\nR2=0.36'
  [8]: 'Final Shoot Density\\nR2=0.93'
  [9]: 'Initial Shoot Density and\\nFinal Shoot Density\\nInteraction\\n'
  [10]: 'Final Soil Strength and\\nFinal Shoot Density\\nInteraction\\n'
      
") #%>%
  export_svg %>% 
  charToRaw %>% 
  rsvg_png("figures/PP_DAG_3.jpg")

# Simpler DAG with Shoot Density ####
  grViz("digraph Soil_Strength {
      # a 'graph' statement
      graph [overlap = false,
             fontsize = 14,
             bold = true]

      # several 'node' statements
      # Exogenous Variables
      node [shape = rectangle,
            fontname = Arial,
            width = 2,
            height = 1.3,
            fontcolor = darkslategray,
            color = darkslategray,
            nodesep = 1,
            penwidth = 2,
            fontsize = 16]
      Crab_Density [label = '@@1']
      
      # Endogenous Variables
      node [shape = rectangle,
            fixedsize = true,
            width = 2,
            height = 1.3,
            color = SteelBlue4,
            fontcolor = darkslategray,
            penwidth = 2] 
      Burrow_Density [label = '@@3']
      Initial_SS [label = '@@4', color = darkslategray]
      Final_SS [label = '@@5']
  
      # Soil Strength Interaction
      node [shape = rectangle,
            fixedsize = true,
            width = 2.5,
            height = 1.3,
            color = SteelBlue4,
            fontcolor = darkslategray,
            penwidth = 2] 
      CrabSoil_Intrctn [label = '@@2']
      
      # Primary Production
      node [shape = rectangle,
            fixedsize = true,
            width = 2.5,
            height = 1.3,
            color = DarkGreen,
            fontcolor = darkslategray,
            penwidth = 2] 
      Pre_Live_SD [label = '@@6']
      Spartina_Biomass [label = '@@7']
      Post_Live_SD [label = '@@8']
      Pre_post_Intrctn [label = '@@9', height = 1.4, width = 3]
      
      # Soil Shoots Interaction
      node [shape = rectangle,
            fixedsize = true,
            width = 2.5,
            height = 1.3,
            color = CadetBlue,
            fontcolor = darkslategray,
            penwidth = 2] 
      SoilShoots_Intrctn [label = '@@10']
  
  # several 'edge' statements
  #Soil Strength Exogenous Variables
  edge [color = gainsboro, arrowhead = normal, penwidth = 1, minlen = 3]
  Initial_SS->Burrow_Density
  Crab_Density->Burrow_Density
  Initial_SS->Post_Live_SD 
  
  #Primary Production Exogenous Variables
  edge [color = DarkGreen, arrowhead = normal, penwidth = 5, minlen = 1]
  Pre_Live_SD -> Final_SS [color = gainsboro, arrowhead = normal, penwidth = 1, minlen = 3]
  Pre_Live_SD -> Spartina_Biomass [color = gainsboro, arrowhead = normal, penwidth = 1, minlen = 3]
  Pre_Live_SD -> Post_Live_SD [label = '0.013', fontsize = 18]
  Pre_post_Intrctn -> Spartina_Biomass [headport = 'w', label = '-0.0011', fontsize = 18]
  Burrow_Density -> Spartina_Biomass [color = gainsboro, arrowhead = normal, penwidth = 1, minlen = 3]
  Final_SS -> Spartina_Biomass [color = gainsboro, arrowhead = normal, penwidth = 1, minlen = 2]
  Burrow_Density -> Post_Live_SD [color = gainsboro, arrowhead = normal, penwidth = 1, minlen = 3]
  
  #All Endogenous Variables
  edge [color = DimGray, arrowhead = normal, penwidth = 5, minlen = 3]
  Burrow_Density->Final_SS [color = SteelBlue4, label = '-0.34', fontsize = 18, penwidth = 12]
  Initial_SS->Final_SS [label = '  0.28', fontsize = 18, penwidth = 10]
  Initial_SS->Spartina_Biomass [label = '  -0.041', penwidth = 8, fontsize = 18]
  Post_Live_SD->Spartina_Biomass [color = gainsboro, arrowhead = normal, penwidth = 1, minlen = 2]
  Crab_Density->Spartina_Biomass [color = gainsboro, arrowhead = normal, penwidth = 1, minlen = 2]
  Crab_Density->Post_Live_SD [color = gainsboro, arrowhead = normal, penwidth = 1, minlen = 3]
  
  #Crab Density and Soil Strength Interaction
  edge [color = SteelBlue4, arrowhead = normal, penwidth = 5, minlen = 3]
  CrabSoil_Intrctn->Burrow_Density [label = '  0.0027', fontsize = 18]
  
  #Soil Strength and Final Shoot Density Interaction
  edge [color = CadetBlue arrowhead = normal, penwidth = 5, minlen = 1]
  SoilShoots_Intrctn->Spartina_Biomass [headport = 'e', label = ' -0.00070', fontsize = 18]
  }

  [1]: 'Crab\\nDensity'
  [2]: 'Crab Density and\\nInitial Soil Strength\\nInteraction\\n'
  [3]: 'Burrow Density\\nR2=0.97'
  [4]: 'Initial\\nSoil Strength'
  [5]: 'Final Soil Strength\\nR2=0.58'
  [6]: 'Initial\\nShoot Density'
  [7]: 'Spartina Biomass\\nR2=0.36'
  [8]: 'Final Shoot Density\\nR2=0.93'
  [9]: 'Initial Shoot Density and\\nFinal Shoot Density\\nInteraction\\n'
  [10]: 'Final Soil Strength and\\nFinal Shoot Density\\nInteraction\\n'
      
")  %>%
    export_svg %>% 
    charToRaw %>% 
    rsvg_png("figures/PP_DAG_3.jpg",
             width = 12000,
             height = 10000)
  