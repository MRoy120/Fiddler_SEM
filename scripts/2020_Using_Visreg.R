fit <- lm(Ozone ~ Solar.R + Wind + Temp + I(Wind^2) + I(Temp^2) +
            I(Wind*Temp)+I(Wind*Temp^2) + I(Temp*Wind^2) + I(Temp^2*Wind^2),
          data=airquality)

visreg2d(fit, x="Wind", y="Temp", plot.type="image")
visreg2d(fit, x="Wind", y="Temp", plot.type="image",
         color=c("purple", "green", "red"))
visreg2d(fit, x="Wind", y="Temp", plot.type="persp")

## Requires the rgl package
# }
# NOT RUN {
visreg2d(fit,x="Wind",y="Temp",plot.type="rgl")
# }
# NOT RUN {
## Requires the ggplot2 package
# }
# NOT RUN {
visreg2d(fit, x="Wind", y="Temp", plot.type="gg")