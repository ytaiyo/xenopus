

#enter desired final NF-stage here:
nfStage <- 40.1

#enter hours until that stage should be reached:
time <- 60



library("rootSolve")

if(nfStage<=40){
  f1 = function(temp){
    -137.4*exp(-0.1460*temp) + (21.54*exp(-0.1192*temp))*nfStage-time
  }
} else {
  f1 = function(temp){
    -2481.0*exp(-0.09332*temp) + (81.97*exp(-0.09745*temp))*nfStage-time
  }
}
temperature = round((uniroot.all(f1, c(0,35))), digits = 1)

print(paste("Incubate at", temperature, "°C"))


