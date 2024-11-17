setwd("C:/Users/.../Your Directory Path/.../15_Global_SES")
data_folder = "GitHub"

########### CGY2021 - dissimilarity between Calgary's nerighborhoods
# to create a data subset containing 'only' the pairs between Calgary neighborhoods
dat<- read.delim(file.path(data_folder,"distance.matrix.results_v9.2_SES_Updated.csv"),sep=",",check.names = FALSE,,na.strings = "")
dat.CGY<-subset(dat,node1.detail=='This_Study' & node2.detail=='This_Study')
dat.CGY<-subset(dat.CGY,dissim.distance!=0)

CGY.median<-median(dat.CGY$dissim.distance) # to take a median - dissimilarity between Calgary neighborhoods

########### (Run-1) dissimilarity between cities - comparison between the same HDI category (e.g., H vs H, ...)
dat<- read.delim(file.path(data_folder,"distance.matrix.results_v9.2_SES_Updated.csv"),sep=",",check.names = FALSE,,na.strings = "")
dat$`node1:node2`<-paste(dat$node1,dat$node2,sep=":") # to create a column - unique identifier for each pair

dat<-subset(dat,node1.detail!='This_Study'&node2.detail!='This_Study') # to eliminate the samples from this study - only samples from 'other studies' were considered
dat<-subset(dat,dissim.distance!=0) # to eliminate diagonal axis - with '0' dissimilarity index

# the following code (L20-23) will create a data subset - for each comparison pair (H vs H, UM vs UM, ...)
dat.H.H<-subset(dat,node1.HDI=='H' & node2.HDI=='H')
dat.UM.UM<-subset(dat,node1.HDI=='UM' & node2.HDI=='UM')
dat.LM.LM<-subset(dat,node1.HDI=='LM' & node2.HDI=='LM')
dat.L.L<-subset(dat,node1.HDI=='L' & node2.HDI=='L')

# to create empty lists, where median value for each comparison pair will be saved
ls.med.H.H<-c()
ls.med.UM.UM<-c()
ls.med.LM.LM<-c()
ls.med.L.L<-c()

# the following code will run permutation simulation by 100 times (for details or rational behind each code within the look, please refer to the previous R script '*_An_Example_Run_v1.R')
for (i in c(1:100)){
  ls.dat.H.H<-sample(dat.H.H$`node1:node2`,28)
  ls.dat.UM.UM<-sample(dat.UM.UM$`node1:node2`,28)
  ls.dat.LM.LM<-sample(dat.LM.LM$`node1:node2`,28)
  ls.dat.L.L<-sample(dat.L.L$`node1:node2`,28)
  
  sub.dat.H.H<-dat.H.H[dat.H.H$`node1:node2` %in% ls.dat.H.H,]
  sub.dat.UM.UM<-dat.UM.UM[dat.UM.UM$`node1:node2` %in% ls.dat.UM.UM,]
  sub.dat.LM.LM<-dat.LM.LM[dat.LM.LM$`node1:node2` %in% ls.dat.LM.LM,]
  sub.dat.L.L<-dat.L.L[dat.L.L$`node1:node2` %in% ls.dat.L.L,]
  
  med.H.H<-median((sub.dat.H.H$dissim.distance))
  med.UM.UM<-median((sub.dat.UM.UM$dissim.distance))
  med.LM.LM<-median((sub.dat.LM.LM$dissim.distance))
  med.L.L<-median((sub.dat.L.L$dissim.distance))
  
  ls.med.H.H<-c(ls.med.H.H,med.H.H)
  ls.med.UM.UM<-c(ls.med.UM.UM,med.UM.UM)
  ls.med.LM.LM<-c(ls.med.LM.LM,med.LM.LM)
  ls.med.L.L<-c(ls.med.L.L,med.L.L)
}

########### (Run-2) dissimilarity between cities - comparison between different HDI category (e.g., H vs UM, H vs LM, ...)
# the following code (L56-61) will create a data subset - for each comparison pair (H vs UM, H vs LM, ...)
dat.H.UM<-subset(dat,node1.HDI=='H' & node2.HDI=='UM')
dat.H.LM<-subset(dat,node1.HDI=='H' & node2.HDI=='LM')
dat.H.L<-subset(dat,node1.HDI=='H' & node2.HDI=='L')
dat.UM.LM<-subset(dat,node1.HDI=='UM' & node2.HDI=='LM')
dat.UM.L<-subset(dat,node1.HDI=='UM' & node2.HDI=='L')
dat.LM.L<-subset(dat,node1.HDI=='LM' & node2.HDI=='L')

# to create empty lists, where median value for each comparison pair will be saved
ls.med.H.UM<-c()
ls.med.H.LM<-c()
ls.med.H.L<-c()
ls.med.UM.LM<-c()
ls.med.UM.L<-c()
ls.med.LM.L<-c()

# the following code will run permutation simulation by 100 times (for details or rational behind each code within the look, please refer to the previous R script '*_An_Example_Run_v1.R')
for (i in c(1:100)) {
  ls.dat.H.UM<-sample(dat.H.UM$`node1:node2`,28)
  ls.dat.H.LM<-sample(dat.H.LM$`node1:node2`,28)
  ls.dat.H.L<-sample(dat.H.L$`node1:node2`,28)
  ls.dat.UM.LM<-sample(dat.UM.LM$`node1:node2`,28)
  ls.dat.UM.L<-sample(dat.UM.L$`node1:node2`,28)
  ls.dat.LM.L<-sample(dat.LM.L$`node1:node2`,28)
  
  sub.dat.H.UM<-dat.H.UM[dat.H.UM$`node1:node2` %in% ls.dat.H.UM,]
  sub.dat.H.LM<-dat.H.LM[dat.H.LM$`node1:node2` %in% ls.dat.H.LM,]
  sub.dat.H.L<-dat.H.L[dat.H.L$`node1:node2` %in% ls.dat.H.L,]
  sub.dat.UM.LM<-dat.UM.LM[dat.UM.LM$`node1:node2` %in% ls.dat.UM.LM,]
  sub.dat.UM.L<-dat.UM.L[dat.UM.L$`node1:node2` %in% ls.dat.UM.L,]
  sub.dat.LM.L<-dat.LM.L[dat.LM.L$`node1:node2` %in% ls.dat.LM.L,]
  
  med.H.UM<-median((sub.dat.H.UM$dissim.distance))
  med.H.LM<-median((sub.dat.H.LM$dissim.distance))
  med.H.L<-median((sub.dat.H.L$dissim.distance))
  med.UM.LM<-median((sub.dat.UM.LM$dissim.distance))
  med.UM.L<-median((sub.dat.UM.L$dissim.distance))
  med.LM.L<-median((sub.dat.LM.L$dissim.distance))
  
  ls.med.H.UM<-c(ls.med.H.UM,med.H.UM)
  ls.med.H.LM<-c(ls.med.H.LM,med.H.LM)
  ls.med.H.L<-c(ls.med.H.L,med.H.L)
  ls.med.UM.LM<-c(ls.med.UM.LM,med.UM.LM)
  ls.med.UM.L<-c(ls.med.UM.L,med.UM.L)
  ls.med.LM.L<-c(ls.med.LM.L,med.LM.L)
}

################# to merge the results above (Run-1 + Run-2)
# to create a data frame, summarizing 'Run-2'
name1<-c(rep('H:UM',100),rep('H:LM',100),rep('H:L',100),rep('UM:LM',100),rep('UM:L',100),rep('LM:L',100))
distance1<-c(ls.med.H.UM,ls.med.H.LM,ls.med.H.L,ls.med.UM.LM,ls.med.UM.L,ls.med.LM.L)
dat.1<-cbind(name1,distance1)

# to create a data frame, summarizing 'Run-1'
name2<-c(rep('H:H',100),rep('UM:UM',100),rep('LM:LM',100),rep('L:L',100))
distance2<-c(ls.med.H.H,ls.med.UM.UM,ls.med.LM.LM,ls.med.L.L)
dat.2<-cbind(name2,distance2)

# to merge data frames for Run-1 & Run-2, then create the final data set 'dat.3'
dat.3<-rbind(dat.1,dat.2)
dat.3<-as.data.frame(dat.3)
colnames(dat.3)<-c('name','distance')
dat.3$distance<-as.numeric(dat.3$distance)

dat.3$name  = factor(dat.3$name, levels=c('H:H','H:UM','H:LM','H:L','UM:UM','UM:LM','UM:L','LM:LM','LM:L','L:L')) # to order data by 'name'

################# to calculate 'p-value' for each comparison pair
CGY.median<-median(dat.CGY$dissim.distance) # to calculate 'median' dissimilarity value for CGY:CGY

# the following code (L128-137) calculate p.value for each comparison pair
pvalue.H.H<-sum(ls.med.H.H < CGY.median)/100
pvalue.UM.UM<-sum(ls.med.UM.UM < CGY.median)/100
pvalue.LM.LM<-sum(ls.med.LM.LM < CGY.median)/100
pvalue.L.L<-sum(ls.med.L.L < CGY.median)/100
pvalue.H.UM<-sum(ls.med.H.UM < CGY.median)/100
pvalue.H.LM<-sum(ls.med.H.LM < CGY.median)/100
pvalue.H.L<-sum(ls.med.H.L < CGY.median)/100
pvalue.UM.LM<-sum(ls.med.UM.LM < CGY.median)/100
pvalue.UM.L<-sum(ls.med.UM.L < CGY.median)/100
pvalue.LM.L<-sum(ls.med.LM.L < CGY.median)/100

# the lists containing the name of comparison pair, and the corresponding p-value
ls.pair.name<-c('H.H','UM.UM','LM.LM','L.L',
                'H.UM','H.LM','H.L','UM.LM','UM.L','LM.L')
ls.pvalue<-c(pvalue.H.H,
             pvalue.UM.UM,
             pvalue.LM.LM,
             pvalue.L.L,
             pvalue.H.UM,
             pvalue.H.LM,
             pvalue.H.L,
             pvalue.UM.LM,
             pvalue.UM.L,
             pvalue.LM.L)

# to consolidate two lists - ls.pair.name + ls.pvalue
final.results.pvalue<-cbind(ls.pair.name,ls.pvalue)
final.results.pvalue<-as.data.frame(final.results.pvalue)
colnames(final.results.pvalue)<-c('comparison.pair','p.value')

################# to visualize the final results, for 'dat.3'
par(mar = c(4, 5, 2, 2)) # mar = c(bottom, left, top, right)
boxplot(dat.3$distance~dat.3$name,
        outline=FALSE, 
        ylim=c(0.25,max(dat.3$distance)),
        xlab='',
        ylab='Median Dissimilarity Distance',
        xaxt="n",
        cex.axis=1.3,
        cex.lab=1.4
)

# the following codes (L168-175) visualizes data points for each comparison pair
x.position<-c(rep(1,100),rep(2,100),rep(3,100),rep(4,100),rep(5,100),rep(6,100),rep(7,100),
              rep(8,100),rep(9,100),rep(10,100))
y.position<-c(ls.med.H.H, ls.med.H.UM, ls.med.H.LM, ls.med.H.L, ls.med.UM.UM,
              ls.med.UM.LM,ls.med.UM.L,ls.med.LM.LM,ls.med.LM.L,ls.med.L.L)
points(x.position,
       y.position,
       cex=1.5, 
       pch=21)

# x-axis tricks
tricks<-c(1:10)
axis(1, at=tricks,labels=FALSE)

# x-axis label
xlab<-c('H:H','H:UM','H:LM','H:L','UM:UM','UM:LM','UM:L','LM:LM','LM:L','L:L')
text(x=tricks+0.30,y=par("usr")[3]-max(dat.3$distance)*0.03,labels=xlab,xpd = NA,srt=30,font=1,cex=1.5,pos=2)

# to visualize the 'median value' for CGY:CGY in a red horizontal line
abline(h=CGY.median, col='red')

# to display a label for 'A median for CGY:CGY'
text(x=2.25,y=CGY.median*1.05,
     labels="A median for CGY:CGY",
     col='red',
     cex=1.3)
mtext('*',side=3,at=c(1:10),cex=2, col='dodgerblue3') # to display '*' symbols, where p < 0.01
