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
  Crab_Density->Burrow_Density [color = steelblue, arrowhead = normal, penwidth = 5, minlen = 4]
  
  #All Endogenous Variables
  edge [color = DimGray, arrowhead = normal, penwidth = 5, minlen = 5]
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
  [5]: 'Depth'
  [6]: 'Burrow Density and\\nDepth Interaction\\n'
  [7]: 'Final Litterbag Mass'
      
") %>%
  export_svg %>% 
  charToRaw %>% 
  rsvg_png("figures/Decomp_DAG.jpg")




