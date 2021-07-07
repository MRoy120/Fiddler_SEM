# install.packages(c("semEff", "ggplot2"))
library(semEff)
library(ggplot2)

# Simulated data from Shipley (2009) on tree growth and survival (see ?Shipley)
head(Shipley)

# Hypothesised SEM: latitude -> degree days to bud burst -> date of burst -> growth -> survival
lapply(Shipley.SEM, formula)

# Bootstrap model effects (10000 reps... can take a while)
# system.time(
#   Shipley.SEM.Boot <- bootEff(Shipley.SEM, R = 10000, seed = 53908, ran.eff = "site")
# )

# Calculate SEM effects and CIs (use saved bootstrapped SEM)
eff <- suppressWarnings(semEff(Shipley.SEM.Boot))

eff$Summary$Growth

tot <- totEff(eff)[["Growth"]]
tot.b <- totEff(eff, type = "boot")[["Growth"]]
