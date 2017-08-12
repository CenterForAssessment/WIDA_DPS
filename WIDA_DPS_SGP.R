##########################################################################################
###
### Script for calculating SGPs for 2011 to 2016 for WIDA/ACCESS DPS
###
##########################################################################################

### Load SGP package

require(SGP)


### Load Data

load("Data/WIDA_DPS_Data_LONG.Rdata")


### Run analyses

WIDA_DPS_SGP <- abcSGP(
		WIDA_DPS_Data_LONG,
		steps=c("prepareSGP", "analyzeSGP", "combineSGP", "visualizeSGP", "outputSGP"),
		sgp.percentiles=TRUE,
		sgp.projections=TRUE,
		sgp.projections.lagged=TRUE,
		sgp.percentiles.baseline=FALSE,
		sgp.projections.baseline=FALSE,
		sgp.projections.lagged.baseline=FALSE,
		sgp.target.scale.scores=FALSE)#,
		plot.types=c("growthAchievementPlot", "studentGrowthPlot",
		sgPlot.demo.report=TRUE,
		parallel.config=list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=4, BASELINE_PERCENTILES=4, PROJECTIONS=4, LAGGED_PROJECTIONS=4, SGP_SCALE_SCORE_TARGETS=4, GA_PLOTS=1, SG_PLOTS=1)))


### Save results

save(WIDA_DPS_SGP, file="Data/WIDA_DPS_SGP.Rdata")
