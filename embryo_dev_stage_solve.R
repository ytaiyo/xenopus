

#enter temperature here:
temp<-23

#enter hours here:
time<- 53.5



library("rootSolve")

f1 = function(nfstage){
    -137.4*exp(-0.1460*temp) + (21.54*exp(-0.1192*temp))*nfstage-time
  }

stage = round((uniroot.all(f1, c(0,120))), digits = 1)

if(stage<=40){
  print(stage)
  
} else {
  f1 = function(nfstage){
    -2481.0*exp(-0.09332*temp) + (81.97*exp(-0.09745*temp))*nfstage-time
  }
  
  stage = round((uniroot.all(f1, c(0,50))), digits = 1)
  print(stage)
}





