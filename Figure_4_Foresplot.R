# Load library

library(forestplot)

# Read data to dataframe

figura2 = read.csv("/Users/antonio_mac/Desktop/Estudios_COVID_19/RAASi_discontinuation_cohort/forest_plot/figura_ACEIcon_ARBcont_sin_switch.csv",
                   colClasses = c("character","character","character","numeric","character","numeric","numeric",
                                  "numeric", "character"))

# Subgroups

#subgps <- c(6,8,14,16,22,24,30,32,39,41,47,49)
#figura2$Variable[subgps] <- paste("",figura2$Variable[subgps])

np <- ifelse(!is.na(figura2$HR), paste(format(round(figura2$HR,2), nsmall=2)," (",figura2$X95CI,")",sep=""), NA)

# Table

tabletext <- cbind(c("","\n",figura2$Variable), 
                   c("ARBs \ncontinued \nDeaths (%)","\n",figura2$ARBs.continued), 
                   c("ACEIs \ncontinued \nDeaths (%)","\n",figura2$ACEIs.continued),
                   c("MC-HR \n(95%CI)*","\n",np),
                   c("Test of interaction \np-value","\n",figura2$Test))

# Foresplot

forestplot(labeltext=tabletext, graph.pos=4, 
           mean=c(NA,NA,figura2$PointEstimate), 
           lower=c(NA,NA,figura2$Low), upper=c(NA,NA,figura2$High),
           title="",
           xlab="HR (95%CI)",
           
           is.summary = c(TRUE, rep(FALSE,7), 
                          TRUE, rep(FALSE,4), 
                          TRUE, rep(FALSE,7), 
                          TRUE, rep(FALSE,7),
                          TRUE,rep(FALSE,7),
                          TRUE,rep(FALSE,7),
                          TRUE,rep(FALSE,7),
                          rep(TRUE,3), rep(FALSE,7),
                          TRUE,rep(FALSE,9),
                          TRUE,rep(FALSE,4),
                          TRUE,rep(FALSE,7),
                          TRUE,rep(FALSE,5)),
           
           hrzl_lines=list("9" = gpar(lwd=25, lineend="butt", columns=c(1:6), col="#99999922"),  
                           "25" = gpar(lwd=55, lineend="butt", columns=c(1:6), col="#99999922"),
                           "41" = gpar(lwd=55, lineend="butt", columns=c(1:6), col="#99999922"),
                           "58" = gpar(lwd=70, lineend="butt", columns=c(1:6), col="#99999922"),
                           "75" = gpar(lwd=25, lineend="butt", columns=c(1:6), col="#99999922"),
                           "90" = gpar(lwd=55, lineend="butt", columns=c(1:6), col="#99999922")),
                           
           txt_gp=fpTxtGp(label=gpar(cex=0.9),
                          ticks=gpar(cex=0.9),
                          xlab=gpar(cex = 0.9),
                          title=gpar(cex = 0.9)),
           
           col=fpColors(box="black", lines="black", zero = "black"), graphwidth = unit(40,'mm'),
           zero=1, cex=1.0, lineheight = "auto", boxsize=0.5, colgap=unit(0.9,"mm"),
           lwd.ci=1.5, ci.vertices=TRUE, ci.vertices.height = 0.3, align = c("l","l","l","c","c"),
           xticks = c(0.1,0.5,1,1.5), clip=c(0.02,1.5))




