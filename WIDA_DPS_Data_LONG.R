##############################################################
###                                                        ###
### Script for creating LONG 2016 and 2017 data for DPS    ###
###                                                        ###
##############################################################

### Load packages

require(data.table)


### Load data

tmp_LONG <- fread("Data/Base_Files/WIDA_DPS_Student_Level_Data.csv", colClasses=rep("character", 7))


### Rename variables

setnames(tmp_LONG, c("ID", "GRADE_2017", "GRADE_2016", "SCALE_SCORE_2017", "SCALE_SCORE_2016", "ACHIEVEMENT_LEVEL_2017", "ACHIEVEMENT_LEVEL_2016"))

### Stack data

WIDA_DPS_Data_LONG <- data.table(
    ID=rep(tmp_LONG$ID, 2),
    GRADE=as.character(as.numeric(c(tmp_LONG$GRADE_2017, tmp_LONG$RADE_2016))),
    SCALE_SCORE=as.numeric(c(tmp_LONG$SCALE_SCORE_2017, tmp_LONG$SCALE_SCORE_2016)),
    ACHIEVEMENT_LEVEL=c(tmp_LONG$ACHIEVEMENT_LEVEL_2017, tmp_LONG$ACHIEVEMENT_LEVEL_2016),
    YEAR=c(rep("2017", dim(tmp_LONG)[1]), rep("2016", dim(tmp_LONG)[1])),
    VALID_CASE="VALID_CASE",
    CONTENT_AREA="READING",
    key=c("VALID_CASE", "CONTENT_AREA", "YEAR", "GRADE", "ID"))


### Filter out missing SCALE_SCOREs

WIDA_DPS_Data_LONG <- WIDA_DPS_Data_LONG[!is.na(SCALE_SCORE)]


### reorder columns

setcolorder(WIDA_DPS_Data_LONG, c("VALID_CASE", "CONTENT_AREA", "YEAR", "ID", "GRADE", "SCALE_SCORE", "ACHIEVEMENT_LEVEL"))


### Save data

save(WIDA_DPS_Data_LONG, file="Data/WIDA_DPS_Data_LONG.Rdata")
