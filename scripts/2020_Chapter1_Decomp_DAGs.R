source("scripts/2020_Chapter1_Decomp_SEM.R")

#### Decomposition DAGs - PSEM Plots ####
plot(decomp_SEM, show = "Estimate")

#### Decomposition DAGs - DiagrammeR Plots ####
### With Site
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
      Site [label = '@@5']
      Depth [label = '@@6', color = SaddleBrown]
      Burrow_Depth_Intrctn [label = '@@7', color = SaddleBrown]
      
      # Endogenous Variables
      node [shape = rectangle,
            fixedsize = true,
            width = 1.8,
            color = steelblue,
            fontcolor = darkslategray,
            penwidth = 2] 
      Burrow_Density [label = '@@3']
      Initial_SS [label = '@@4', color = darkslategray]
      End_Mass_LB [label = '@@8', color = SaddleBrown]
  
      # Soil Strength Interaction
      node [shape = rectangle,
            fixedsize = true,
            width = 2,
            height = 0.9,
            color = steelblue,
            fontcolor = darkslategray,
            penwidth = 2] 
      CrabSoil_Intrctn [label = '@@2']
      Crab_Density [label = '@@1']
      
  # several 'edge' statements
  #Soil Strength Exogenous Variables
  edge [color = grey, arrowhead = normal, penwidth = 1, minlen = 3]
  Initial_SS->Burrow_Density 
  Crab_Density->Burrow_Density [color = steelblue, arrowhead = normal, penwidth = 5, minlen = 4]
  
  #All Endogenous Variables
  edge [color = DimGray, arrowhead = normal, penwidth = 5, minlen = 5]
  Site->Burrow_Density
  Site->Initial_SS
  Site -> End_Mass_LB [color = grey, arrowhead = normal, penwidth = 1, minlen = 3]
  Depth -> End_Mass_LB [color = grey, arrowhead = normal, penwidth = 1, minlen = 3]
  Initial_SS -> End_Mass_LB
  Burrow_Depth_Intrctn -> End_Mass_LB [color = SaddleBrown]
  Burrow_Density -> End_Mass_LB [color = grey, arrowhead = normal, penwidth = 1, minlen = 3]
  
  edge [color = steelblue, arrowhead = normal, penwidth = 5, minlen = 4]
  CrabSoil_Intrctn->Burrow_Density
  }

  [1]: 'Crab Density'
  [2]: 'Crab Density and\\nInitial Soil Strength\\nInteraction\\n'
  [3]: 'Burrow Density'
  [4]: 'Initial Soil Strength'
  [5]: 'Site'
  [6]: 'Depth'
  [7]: 'Burrow Density and\\nDepth Interaction\\n'
  [8]: 'Final Litterbag Mass'
      
"
)  

### Without Site
grViz("digraph Soil_Strength {
      # a 'graph' statement
      graph [layout = dot,
             overlap = false,
             fontsize = 14,
             rankdir = LR]

      # several 'node' statements
      # Exogenous Variables
      node [shape = rectangle,
            fontname = Times,
            width = 1.3,
            fontcolor = darkslategray,
            color = darkslategray,
            nodesep = 1,
            penwidth = 2]
      Depth [label = '@@5', color = SaddleBrown]
      Burrow_Depth_Intrctn [label = '@@6', color = SaddleBrown]
      
      # Endogenous Variables
      node [shape = rectangle,
            fixedsize = true,
            width = 1.8,
            color = steelblue,
            fontcolor = darkslategray,
            penwidth = 2] 
      Burrow_Density [label = '@@3']
      Initial_SS [label = '@@4', color = darkslategray]
      End_Mass_LB [label = '@@7', color = SaddleBrown]
  
      # Soil Strength Interaction
      node [shape = rectangle,
            fixedsize = true,
            width = 2,
            height = 0.9,
            color = steelblue,
            fontcolor = darkslategray,
            penwidth = 2] 
      CrabSoil_Intrctn [label = '@@2']
      Crab_Density [label = '@@1']
      
  # several 'edge' statements
  #Soil Strength Exogenous Variables
  edge [color = grey, arrowhead = normal, penwidth = 1, minlen = 3]
  Initial_SS->Burrow_Density
  Crab_Density->Burrow_Density [color = steelblue, arrowhead = normal, penwidth = 5, minlen = 3, label = '-0.035']
  
  #All Endogenous Variables
  edge [color = DimGray, arrowhead = normal, penwidth = 5, minlen = 5]
  Depth -> End_Mass_LB [color = grey, arrowhead = normal, penwidth = 1, minlen = 3]
  Initial_SS -> End_Mass_LB [color = SaddleBrown, label = '-0.0069']
  Burrow_Depth_Intrctn -> End_Mass_LB [color = SaddleBrown, label = '0.00060']
  Burrow_Density -> End_Mass_LB [color = grey, arrowhead = normal, penwidth = 1, minlen = 3]
  
  edge [color = steelblue, arrowhead = normal, penwidth = 5, minlen = 4]
  CrabSoil_Intrctn->Burrow_Density [label = '0.0038']
  }

  [1]: 'Crab Density'
  [2]: 'Crab Density and\\nInitial Soil Strength\\nInteraction\\n'
  [3]: 'Burrow Density'
  [4]: 'Initial Soil Strength'
  [5]: 'Depth'
  [6]: 'Burrow Density and\\nDepth Interaction\\n'
  [7]: 'Final Litterbag Mass'
      
") #%>%
  export_svg %>% 
  charToRaw %>% 
  rsvg_png("figures/Decomp_DAG_2.jpg")

# Without Site, Cleaned Up ####
  grViz("digraph Soil_Strength {
      # a 'graph' statement
      graph [layout = dot,
             overlap = false,
             fontsize = 14,
             rankdir = TD]

      # several 'node' statements
      # Exogenous Variables
      node [shape = rectangle,
            fontname = Arial,
            width = 1.3,
            height = 0.9,
            fontcolor = darkslategray,
            color = darkslategray,
            nodesep = 1,
            penwidth = 2,
            fontsize = 16]
      Depth [label = '@@5', color = SaddleBrown]
      Burrow_Depth_Intrctn [label = '@@6', color = SaddleBrown]
      
      # Endogenous Variables
      node [shape = rectangle,
            fixedsize = true,
            width = 1.8,
            height = 0.9,
            color = SteelBlue4,
            fontcolor = darkslategray,
            penwidth = 2] 
      Burrow_Density [label = '@@3']
      Initial_SS [label = '@@4', color = darkslategray]
      End_Mass_LB [label = '@@7', color = Sienna4]
  
      # Soil Strength Interaction
      node [shape = rectangle,
            fixedsize = true,
            width = 2,
            height = 0.9,
            color = SteelBlue4,
            fontcolor = darkslategray,
            penwidth = 2] 
      CrabSoil_Intrctn [label = '@@2']
      Crab_Density [label = '@@1']
      
  # several 'edge' statements
  #Soil Strength Exogenous Variables
  edge [color = grey, arrowhead = normal, penwidth = 1, minlen = 2]
  Initial_SS->Burrow_Density 
  Crab_Density->Burrow_Density [color = SteelBlue4, arrowhead = normal, penwidth = 8, minlen = 2, label = '  -0.035', headport = 'n', fontsize = 18]
  
  #All Endogenous Variables
  edge [color = DimGray, arrowhead = normal, penwidth = 6, minlen = 3]
  Depth -> End_Mass_LB [color = grey, arrowhead = normal, penwidth = 1, minlen = 3]
  Initial_SS -> End_Mass_LB [color = DimGray, label = '  -0.0069', headport = 'e', minlen = 2, fontsize = 18]
  Burrow_Depth_Intrctn -> End_Mass_LB [color = Sienna4, label = '  0.00060', minlen = 4, penwidth = 4, fontsize = 18]
  Burrow_Density -> End_Mass_LB [color = grey, arrowhead = normal, penwidth = 1, minlen = 3]
  
  edge [color = SteelBlue4, arrowhead = normal, penwidth = 5, minlen = 2]
  CrabSoil_Intrctn->Burrow_Density [label = '\\n0.0038', tailport = 's', fontsize = 18]
  }

  [1]: 'Crab Density'
  [2]: 'Crab Density and\\nInitial Soil Strength\\nInteraction\\n'
  [3]: 'Burrow Density\\nR2=0.78'
  [4]: 'Initial\\nSoil Strength'
  [5]: 'Depth'
  [6]: 'Burrow Density and\\nDepth Interaction\\n'
  [7]: 'Final\\nLitterbag Mass\\nR2=0.39'
      
") %>%
  export_svg %>% 
    charToRaw %>% 
    rsvg_png("figures/Decomp_DAG_3.jpg",
             width = 11000,
             height = 10000)


