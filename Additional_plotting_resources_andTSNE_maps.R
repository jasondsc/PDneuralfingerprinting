# load libraries
library(dplyr)
library(ggplot2)
library("ggpubr")
library(corrplot)
library(ggseg)

# set colour palette
cbbPalette <- c( "#90319D","#E25987","#FFBF00","#3A3AA4", "#31CD71", "#F0792C", "#6C3ABF")

# make a map of random activity based on a seed (i.e., some dist of real data) by adding random noise
PSDi = read.csv('~/Desktop/Alex_fingerprinting/PSDI_score.csv', header = FALSE)
PSDi= as.data.frame(scale(PSDi))

ROI=colMeans(PSDi) + (0.005*rnorm(68))

df=read.csv('~/Desktop/Alex_fingerprinting/PSD_ICC_orig_PD_new_PKD2.csv', header = FALSE, stringsAsFactors = FALSE)
colnames(df)[1]='region'
df=df[,1:2]
df$hemi =''
df$hemi[seq(2,68,2)] ='right'
df$hemi[seq(1,67,2)] ='left'
df$V2=ROI

someData2= df
colnames(someData2)[2]='Beta'
colnames(someData2)[1]='region'
colnames(someData2)[3]='hemi'

ggplot(someData2) +
  geom_brain(atlas = dk, 
             position = position_brain(hemi ~ side),
             aes(fill = `Beta`)) +
  #scale_fill_distiller(palette = "RdBu"
  #                     , limits = c(0.4, 0.9))+
  viridis::scale_fill_viridis(option = 'magma')+
  #scale_fill_gradient2(low="white", mid="#EC352F", high="#6C1917", 
  #                     midpoint=0.6,   
  #                     limits=c(0.4, 0.9 ))+
  theme_void() 

ggsave('/Users/jasondsc/Desktop/Alex_fingerprinting/figure4plot/example_brain.pdf', device = "pdf")

# plot an example of a brain map with a missing ROI
someData2= df
colnames(someData2)[2]='Beta'
colnames(someData2)[1]='region'
colnames(someData2)[3]='hemi'
someData2$Beta[63:64]= NA

ggplot(someData2) +
  geom_brain(atlas = dk, 
             position = position_brain(hemi ~ side),
             aes(fill = `Beta`)) +
  #scale_fill_distiller(palette = "RdBu"
  #                     , limits = c(0.4, 0.9))+
  viridis::scale_fill_viridis(option = 'magma')+
  #scale_fill_gradient2(low="white", mid="#EC352F", high="#6C1917", 
  #                     midpoint=0.6,   
  #                     limits=c(0.4, 0.9 ))+
  theme_void() 

ggsave('/Users/jasondsc/Desktop/Alex_fingerprinting/figure4plot/example_brain_missing_ROI.pdf', device = "pdf")

# plot just the pre central gyrus (works for any ROI)
someData2= df
colnames(someData2)[2]='Beta'
colnames(someData2)[1]='region'
colnames(someData2)[3]='hemi'
someData2$Beta[!(1:68 %in% 50)]= NA

ggplot(someData2) +
  geom_brain(atlas = dk, 
             position = position_brain(hemi ~ side),
             aes(fill = `Beta`)) +
  #scale_fill_distiller(palette = "RdBu"
  #                     , limits = c(0.4, 0.9))+
  viridis::scale_fill_viridis(option = 'magma')+
  #scale_fill_gradient2(low="white", mid="#EC352F", high="#6C1917", 
  #                     midpoint=0.6,   
  #                     limits=c(0.4, 0.9 ))+
  theme_void() 

ggsave('/Users/jasondsc/Desktop/Alex_fingerprinting/figure4plot/example_just_RPrecent.pdf', device = "pdf")




# plot example participant and PSD data
data_psd =read.csv('~/Desktop/Alex_fingerprinting/NEWspectraCTL/sub_00001_spectrum_training.csv', header = FALSE)
data_psd= data_psd[,1:451]

data_PSD_plot =cbind(paste(df$region,  df$hemi),stack(data_psd))
colnames(data_PSD_plot)[1]='region'

data_PSD_plot$ind = plyr::mapvalues(data_PSD_plot$ind , unique(data_PSD_plot$ind ), seq(0,150,1/3))

data_PSD_plot$ind= as.numeric(as.character(data_PSD_plot$ind))

ggplot(data_PSD_plot, aes(x= ind, y = log(values), colour= region)) +  viridis::scale_colour_viridis(discrete=TRUE, option = 'magma')+
  geom_line() + theme_minimal() + xlim(1,75) + theme(legend.position='none')

ggsave('/Users/jasondsc/Desktop/Alex_fingerprinting/figure4plot/example_PSD.pdf', device = "pdf")


data_PSD_plot$values[data_PSD_plot$ind > 8 & data_PSD_plot$ind<15 ]= NA

ggplot(data_PSD_plot, aes(x= ind, y = log(values), colour= region)) +  viridis::scale_colour_viridis(discrete=TRUE, option = 'magma')+
  geom_line() + theme_minimal() + xlim(1,75) + theme(legend.position='none')

ggsave('/Users/jasondsc/Desktop/Alex_fingerprinting/figure4plot/example_PSD_removed.pdf', device = "pdf")




##### t-SNE representation 
library(M3C)

cbbPalette2 <- c( "#90319D","#E25987","#FFBF00","#3A3AA4", "#31CD71", "#F0792C", "#6C3ABF", '#d62976', '#005f60', '#249ea0',
                  '#161414', '#e5ac1b', '#285dc8', '#6667ab', '#9bca53', '#df88b7', '#9a83b1', '#6a1431', '#e9d945', '#ad0000')

cbbPalette <- c( '#808080',"#90319D","#E25987","#FFBF00","#3A3AA4", "#31CD71", "#F0792C", "#6C3ABF")

# read data and compute data for demographic table
data=read.csv('~/Documents/PD_fingerprinting/QPN_demo_compiled.csv', stringsAsFactors = FALSE)

target= read.csv('~/Documents/PD_fingerprinting/features_4_fingeprinting_target.csv' )

database= read.csv('~/Documents/PD_fingerprinting/features_4_fingeprinting_database.csv' )

target=target[,-1]
database=database[,-1]

target=as.matrix(target)
database=as.matrix(database)

full_data= rbind(database,target)

tt=tsne(t(full_data),labels=rep(data$SubjID,2)) 
save(tt, file='~/Documents/PD_fingerprinting/tSNE_map_all_subs.rds')

load('~/Documents/PD_fingerprinting/tSNE_map_all_subs.rds')
data4plot=tt$data
data4plot$Group = rep(data$Group,2)
data4plot$SubjID = rep(data$SubjID,2)
data4plot$identifiability = rep(data$identifiability,2)

ggplot(data4plot, aes(x= X1, y=X2, color= SubjID, fill= SubjID, shape=Group)) + geom_point() + theme(legend.position = 'none')

dist=sqrt((data4plot$X1[1:133]-data4plot$X1[134:266])^2 + (data4plot$X2[1:133]-data4plot$X2[134:266])^2)
cor.test(dist, data$identifiability)


t.test(log(dist[data$Group=='Parkinson']), log(dist[data$Group=='Control']))
t.test(dist[data$Group=='Parkinson'], dist[data$Group=='Control'])


lm3=lm(log(dist) ~ data$corr +1)
summary(lm3)
sjPlot::tab_model(lm3)

lm3=lm(log(dist) ~ data$identifiability +1)
summary(lm3)
sjPlot::tab_model(lm3)


ggplot(data, aes(x=data$identifiability , y = log(dist), fill=cbbPalette[6])) + 
  geom_jitter(colour = cbbPalette[6]) + 
  stat_smooth(method = "lm", colour = 'black',fullrange = T) +
  labs(title = paste("Adj R2 = ", signif(summary(lm3)$adj.r.squared, 5),
                     "Intercept =", signif(lm3$coef[[1]],5 ),
                     " Slope =", signif(lm3$coef[[2]], 5),
                     " P =", signif(summary(lm3)$coef[2,4], 5) )) + scale_fill_manual(values=cbbPalette[6])  +
  theme_classic2() +   xlab("differentiability") + ylab("log distance in t-SNE space")+
  theme(axis.text=element_text(size=12),
        axis.title=element_text(size=14,face="bold"), legend.position = "none") 


ggsave('~/Documents/PD_fingerprinting/figure/t-SNE_distance_identifiability_regression2.pdf', device = "pdf", width=5, height=5, dpi=800)





ggplot(data4plot, aes(x= X1, y=X2, color= identifiability, fill= identifiability, group= SubjID, shape=Group)) + geom_point(size=5) + geom_line(linetype = "dashed") +theme_classic2() +
  viridis::scale_fill_viridis(option = 'magma') + viridis::scale_color_viridis(option = 'magma') 

ggsave('~/Documents/PD_fingerprinting/figure/tSNE_map_all_subs_identifiability22.pdf', device = "pdf",width=5, height=5, dpi=800)


ggplot(data4plot, aes(x= X1, y=X2, color= identifiability, fill= identifiability, group= SubjID, shape=Group)) + geom_point(size=5) + geom_line(linetype = "dashed") +theme_classic2() +
  theme(legend.position = 'none') +  viridis::scale_fill_viridis(option = 'magma') + viridis::scale_color_viridis(option = 'magma') 

ggsave('~/Documents/PD_fingerprinting/figure/tSNE_map_all_subs_identifiability22_nolegend.pdf', device = "pdf",width=5, height=5, dpi=800)

mean(dist[data4plot$Group =="Parkinson"], na.rm = TRUE)
sd(dist[data4plot$Group =="Parkinson"], na.rm = TRUE)
mean(dist[data4plot$Group =="Control"], na.rm = TRUE)
sd(dist[data4plot$Group =="Control"], na.rm = TRUE)

set.seed(1111)

# index based on high low diff
index= c(head(order(data$identifiability[data$Group=='Control']),10), tail(order(data$identifiability[data$Group=='Control']),10),
  head(order(data$identifiability[data$Group=='Parkinson']),10)+54, tail(order(data$identifiability[data$Group=='Parkinson']),10)+54)

index= c(index, index+133)
data4plot2=data4plot[index,]


ggplot(data4plot2, aes(x= X1, y=X2, color= identifiability, fill= identifiability, group= SubjID, shape=Group)) + geom_point(size=5) + geom_line(linetype = "dashed") +theme_classic2() +
  viridis::scale_fill_viridis(option = 'magma') + viridis::scale_color_viridis(option = 'magma') 

ggsave('~/Documents/PD_fingerprinting/figure/tSNE_map_subset_of_subj_identifiability_new2.pdf', device = "pdf",width=5, height=5, dpi=800)


ggplot(data4plot2, aes(x= X1, y=X2, color= identifiability, fill= identifiability, group= SubjID, shape=Group)) + geom_point(size=5) + geom_line(linetype = "dashed") + theme_classic2() +
  theme(legend.position = 'none') +  viridis::scale_fill_viridis(option = 'magma') + viridis::scale_color_viridis(option = 'magma') 


ggsave('~/Documents/PD_fingerprinting/figure/tSNE_map_subset_of_subj_identifiability_new_nolegend2.pdf', device = "pdf",width=5, height=5, dpi=800)




