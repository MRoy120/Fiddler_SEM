source("scripts/2020_Chapter1_SS_SEM.R")

#### Soil Strength DAGs - PSEM Plots ####
plot(SS_Model, show = "Estimate")

#### Soil Strength DAGs - DiagrammeR Plots ####
## Including Site and Year
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
  
      # Interaction
      node [shape = rectangle,
            fixedsize = true,
            width = 2,
            height = 0.9,
            color = steelblue,
            fontcolor = darkslategray,
            penwidth = 2] 
      CrabSoil_Intrctn [label = '@@2']
  
  
  # several 'edge' statements
  edge [color = grey, arrowhead = normal, arrowtail = dot, penwidth = 1, minlen = 3]
  Initial_SS->Burrow_Density
  Crab_Density->Burrow_Density
  
  edge [color = DimGray, arrowhead = normal, penwidth = 5, minlen = 5]
  Site->Burrow_Density
  Year->Burrow_Density
  Burrow_Density->Final_SS [color = steelblue]
  Site->Initial_SS
  Year->Initial_SS
  Site->Final_SS
  Year->Final_SS
  Initial_SS->Final_SS
  
  edge [color = steelblue, arrowhead = normal, penwidth = 5, minlen = 4]
  CrabSoil_Intrctn->Burrow_Density
  }

  [1]: 'Crab Density'
  [2]: 'Crab Density and\\nInitial Soil Strength\\nInteraction\\n'
  [3]: 'Burrow Density'
  [4]: 'Initial Soil Strength'
  [5]: 'Site'
  [6]: 'Year'
  [7]: 'Final Soil Strength'
      
")

## Excluding Site and Year
grViz("digraph Soil_Strength {
      # a 'graph' statement
      graph [layout = dot,
             overlap = false,
             fontsize = 14,
             ranksep = .25,
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
      Crab_Density [label = '@@1']
      CrabSoil_Intrctn [label = '@@2', color = steelblue, height = 0.9]
      Initial_SS [label = '@@4']
      
      # Endogenous Variables
      node [shape = rectangle,
            fixedsize = true,
            width = 1.8,
            color = steelblue,
            fontcolor = darkslategray,
            penwidth = 2] 
      Burrow_Density [label = '@@3']
      Final_SS [label = '@@5']
  
  # several 'edge' statements
  edge [color = grey, arrowhead = normal, minlen = 4, penwidth = 1]
  Initial_SS->Burrow_Density 
  Crab_Density->Burrow_Density 
  
  edge [color = DimGray, arrowhead = normal, minlen = 5, penwidth = 5]
  CrabSoil_Intrctn->Burrow_Density [color = steelblue, label = '0.0027', minlen = 4]
  Burrow_Density->Final_SS [color = steelblue, label = '-0.41']
  Initial_SS->Final_SS [label = '0.32']
  }

  [1]: 'Crab Density'
  [2]: 'Crab Density and\\nInitial Soil Strength\\nInteraction\\n'
  [3]: 'Burrow Density\\nR2=0.97'
  [4]: 'Initial Soil Strength'
  [5]: 'Final Soil Strength\\nR2=0.57'
      
") #%>%
  export_svg %>% 
  charToRaw %>% 
  rsvg_png("figures/SS_DAG.jpg",
           width = 10000,
           height = 4000)
