setwd("C:/Users/myjac/OneDrive - University of Calgary/1. Jangwoo_WBE/3_Data_Analysis/a_WBE_Metagenomics/15_Global_SES")
data_folder = "GitHub"

############ to create a data set ('dat.1'), containing dissimilarity index between the cities with the different HDI categories, e.g., H-UM, H-LM, ...
dat<- read.delim(file.path(data_folder,"distance.matrix.results_v9.2_SES_Updated.csv"),sep=",",check.names = FALSE,,na.strings = "")
dat$`node1:node2`<-paste(dat$node1,dat$node2,sep=":") # to create a column - unique identifier for each pair

dat<-subset(dat,node1.detail!='This_Study' & node2.detail!='This_Study') # to eliminate the samples from this study - only samples from 'other studies' were considered for dat.1 and dat.2
dat<-subset(dat,dissim.distance!=0) # to eliminate diagonal axis - with '0' dissimilarity index

# the following code (L12-17) will create a data subset - for each comparison pair (H vs UM, H vs LM, ...)
dat.H.UM<-subset(dat,node1.HDI=='H' & node2.HDI=='UM')
dat.H.LM<-subset(dat,node1.HDI=='H' & node2.HDI=='LM')
dat.H.L<-subset(dat,node1.HDI=='H' & node2.HDI=='L')
dat.UM.LM<-subset(dat,node1.HDI=='UM' & node2.HDI=='LM')
dat.UM.L<-subset(dat,node1.HDI=='UM' & node2.HDI=='L')
dat.LM.L<-subset(dat,node1.HDI=='LM' & node2.HDI=='L')

# to create a list, containing '28' randomly selected comparison pairs
ls.dat.H.UM<-sample(dat.H.UM$`node1:node2`,28)
ls.dat.H.LM<-sample(dat.H.LM$`node1:node2`,28)
ls.dat.H.L<-sample(dat.H.L$`node1:node2`,28)
ls.dat.UM.LM<-sample(dat.UM.LM$`node1:node2`,28)
ls.dat.UM.L<-sample(dat.UM.L$`node1:node2`,28)
ls.dat.LM.L<-sample(dat.LM.L$`node1:node2`,28)

# to create a data subset, containing 28 randomly selected pairs only
sub.dat.H.UM<-dat.H.UM[dat.H.UM$`node1:node2` %in% ls.dat.H.UM,]
sub.dat.H.LM<-dat.H.LM[dat.H.LM$`node1:node2` %in% ls.dat.H.LM,]
sub.dat.H.L<-dat.H.L[dat.H.L$`node1:node2` %in% ls.dat.H.L,]
sub.dat.UM.LM<-dat.UM.LM[dat.UM.LM$`node1:node2` %in% ls.dat.UM.LM,]
sub.dat.UM.L<-dat.UM.L[dat.UM.L$`node1:node2` %in% ls.dat.UM.L,]
sub.dat.LM.L<-dat.LM.L[dat.LM.L$`node1:node2` %in% ls.dat.LM.L,]

## (optional) to take a median of dissimilarity distance for each data subset - if you want to check the value manually
#median((sub.dat.H.UM$dissim.distance))
#median((sub.dat.H.LM$dissim.distance))
#median((sub.dat.H.L$dissim.distance))
#median((sub.dat.UM.LM$dissim.distance))
#median((sub.dat.UM.L$dissim.distance))
#median((sub.dat.LM.L$dissim.distance))

# to create two lists, containing name of comparison pair (e.g., H:UM, H:LM, etc), and dissimilarity index values
name<-c(rep('H:UM',28),
        rep('H:LM',28),
        rep('H:L',28),
        rep('UM:LM',28),
        rep('UM:L',28),
        rep('LM:L',28)
)
distance<-c(sub.dat.H.UM$dissim.distance,
            sub.dat.H.LM$dissim.distance,
            sub.dat.H.L$dissim.distance,
            sub.dat.UM.LM$dissim.distance,
            sub.dat.UM.L$dissim.distance,
            sub.dat.LM.L$dissim.distance
)

# the following code (L64-66) merge two lists above ('name' and 'distance'), to create a merged data set 'dat.1'
dat.1<-cbind(name,distance)
dat.1<-as.data.frame(dat.1)
dat.1$distance<-as.numeric(dat.1$distance)

#boxplot(dat.1$distance~dat.1$name) # in case you want to check the results visually, using boxplot

############ to create a dataset (dat.2), containing dissimilarity index between the cities with the same HDI category, e.g., H-H, UM-UM, LM-LM, and L-L.
# the following code (L16-21) will create a data subset - for each comparison pair (H vs H, UM vs UM, ...)
dat.H.H<-subset(dat,node1.HDI=='H' & node2.HDI=='H')
dat.UM.UM<-subset(dat,node1.HDI=='UM' & node2.HDI=='UM')
dat.LM.LM<-subset(dat,node1.HDI=='LM' & node2.HDI=='LM')
dat.L.L<-subset(dat,node1.HDI=='L' & node2.HDI=='L')

# to create a list, containing '28' randomly selected comparison pairs
ls.dat.H.H<-sample(dat.H.H$`node1:node2`,28)
ls.dat.UM.UM<-sample(dat.UM.UM$`node1:node2`,28)
ls.dat.LM.LM<-sample(dat.LM.LM$`node1:node2`,28)
ls.dat.L.L<-sample(dat.L.L$`node1:node2`,28)

# to create a data subset, containing 28 randomly selected pairs only
sub.dat.H.H<-dat.H.H[dat.H.H$`node1:node2` %in% ls.dat.H.H,]
sub.dat.UM.UM<-dat.UM.UM[dat.UM.UM$`node1:node2` %in% ls.dat.UM.UM,]
sub.dat.LM.LM<-dat.LM.LM[dat.LM.LM$`node1:node2` %in% ls.dat.LM.LM,]
sub.dat.L.L<-dat.L.L[dat.L.L$`node1:node2` %in% ls.dat.L.L,]

## (optional) to take a median of dissimilarity distance for each data subset - if you want to check the value manually
#median((sub.dat.H.H$dissim.distance))
#median((sub.dat.UM.UM$dissim.distance))
#median((sub.dat.LM.LM$dissim.distance))
#median((sub.dat.L.L$dissim.distance))

# to create two lists, containing name of comparison pair (e.g., H:H, UM:UM, ...), and dissimilarity index values
name<-c(rep('H:H',28),
        rep('UM:UM',28),
        rep('LM:LM',28),
        rep('L:L',28)
)
distance<-c(sub.dat.H.H$dissim.distance,
            sub.dat.UM.UM$dissim.distance,
            sub.dat.LM.LM$dissim.distance,
            sub.dat.L.L$dissim.distance
)

# the following code (L104-106) merge two lists above ('name' and 'distance'), to create a merged data set 'dat.1'
dat.2<-cbind(name,distance)
dat.2<-as.data.frame(dat.2)
dat.2$distance<-as.numeric(dat.2$distance)

#boxplot(dat.2$distance~dat.2$name) # in case you want to check the results visually, using boxplot

########### to create a data set, containing dissimilarity index between neighborhoods (this study)
# to create a data subset, containing 28 pairs comparing between Calgary (CGY) neighborhoods
dat<- read.delim(file.path(data_folder,"distance.matrix.results_v9.2_SES_Updated.csv"),sep=",",check.names = FALSE,,na.strings = "")
dat.CGY<-subset(dat,node1.detail=='This_Study' & node2.detail=='This_Study')
dat.CGY<-subset(dat.CGY,dissim.distance!=0)

# to create two lists, containing name of comparison pair ('CGY:CGY'), and dissimilarity index values
name<-rep('CGY:CGY',28)
distance<-dat.CGY$dissim.distance

# the following codes (L121-123) will merge two lists ('name', 'distance'), and make it as a data frame
dat.3<-cbind(name,distance)
dat.3<-as.data.frame(dat.3)
dat.3$distance<-as.numeric(dat.3$distance)

dat.3$name  = factor(dat.3$name, levels=c('CGY:CGY','H:H','H:UM','H:LM','H:L','UM:UM','UM:LM','UM:L','LM:LM','LM:L','L:L')) # to order data by name

########### to merge all data sets created (dat.sum), dat.1 & dat.2 & dat.3
dat.sum<-rbind(dat.3,dat.1,dat.2)  

########### to visualize the merged data (dat.sum), using boxplot
par(mar = c(4, 5, 2, 2)) # margin = c(bottom, left, top, right)

boxplot(dat.sum$distance~dat.sum$name,
        outline=FALSE, 
        ylim=c(min(dat.sum$distance),max(dat.sum$distance)),
        xlab='',
        ylab='Dissimilarity Distance',
        xaxt="n",
        cex.axis=1.3,
        cex.lab=1.4
)

# x-axis tricks
tricks<-c(1:11)
axis(1, at=tricks,labels=FALSE)

# x-axis label
xlab<-c('CGY:CGY','H:H','H:UM','H:LM','H:L','UM:UM','UM:LM','UM:L','LM:LM','LM:L','L:L')
text(x=tricks+0.30,y=par("usr")[3]-max(dat.sum$distance)*0.045,labels=xlab,xpd = NA,srt=30,font=1,cex=1.45,pos=2)

# Figure title
mtext('Human Development Index',line=0.5, cex=2)

# to visualize data points (L155-197)
points(rep(1,length(dat.3$distance)),dat.3$distance,
       cex=1.5, 
       pch=21)

points(rep(2,length(sub.dat.H.H$dissim.distance)),sub.dat.H.H$dissim.distance,
       cex=1.5, 
       pch=21)

points(rep(3,length(sub.dat.H.UM$dissim.distance)),sub.dat.H.UM$dissim.distance,
       cex=1.5, 
       pch=21)

points(rep(4,length(sub.dat.H.LM$dissim.distance)),sub.dat.H.LM$dissim.distance,
       cex=1.5, 
       pch=21)

points(rep(5,length(sub.dat.H.L$dissim.distance)),sub.dat.H.L$dissim.distance,
       cex=1.5, 
       pch=21)

points(rep(6,length(sub.dat.UM.UM$dissim.distance)),sub.dat.UM.UM$dissim.distance,
       cex=1.5, 
       pch=21)

points(rep(7,length(sub.dat.UM.LM$dissim.distance)),sub.dat.UM.LM$dissim.distance,
       cex=1.5, 
       pch=21)

points(rep(8,length(sub.dat.UM.L$dissim.distance)),sub.dat.UM.L$dissim.distance,
       cex=1.5, 
       pch=21)

points(rep(9,length(sub.dat.LM.LM$dissim.distance)),sub.dat.LM.LM$dissim.distance,
       cex=1.5, 
       pch=21)

points(rep(10,length(sub.dat.LM.L$dissim.distance)),sub.dat.LM.L$dissim.distance,
       cex=1.5, 
       pch=21)

points(rep(11,length(sub.dat.L.L$dissim.distance)),sub.dat.L.L$dissim.distance,
       cex=1.5, 
       pch=21)

## (Optional)Figure title
# mtext('', side = 3, line = 0.5, cex = 1.2)
