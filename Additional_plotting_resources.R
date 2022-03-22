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





###
data=read.csv('~/Desktop/Alex_fingerprinting/QPN_demo_with_fingerprinting_score_new.csv', stringsAsFactors = FALSE)

data2=read.csv('~/Desktop/Alex_fingerprinting/BD_RPQ_UPDATE_Neuropsy_PD.csv', na.strings = c('NA', "Na", '999'), stringsAsFactors = FALSE)

matched_id= data$SubjID[data$SubjID %in% data2$Patient..]

data$moca2[data$SubjID %in% data2$Patient.. ] =  plyr::mapvalues(data$SubjID[data$SubjID %in% data2$Patient..], matched_id[order(matched_id)], data2$MoCA..Raw.score.[data2$Patient.. %in% data$SubjID])
data$updrs2[data$SubjID %in% data2$Patient.. ] =  plyr::mapvalues(data$SubjID[data$SubjID %in% data2$Patient..], matched_id[order(matched_id)], data2$UPDRS.Score.part.3[data2$Patient.. %in% data$SubjID])

data$moca2=as.numeric(data$moca2)
data$updrs2=as.numeric(data$updrs2)

motion = read.csv('~/Desktop/Alex_fingerprinting/QPN_motion_12132021_jason.csv', na.strings = 'NaN', stringsAsFactors = FALSE)

matched_id2= data$SubjID[data$SubjID %in% motion$ID]


data$ECG[data$SubjID %in% motion$ID ] =  plyr::mapvalues(data$SubjID[data$SubjID %in% motion$ID], matched_id2[order(matched_id2)], motion$ECG[motion$ID %in% data$SubjID])

data$EOG[data$SubjID %in% motion$ID ] =  plyr::mapvalues(data$SubjID[data$SubjID %in% motion$ID], matched_id2[order(matched_id2)], motion$EOG[motion$ID %in% data$SubjID])


data$HLU[data$SubjID %in% motion$ID ] =  plyr::mapvalues(data$SubjID[data$SubjID %in% motion$ID], matched_id2[order(matched_id2)], motion$HLU[motion$ID %in% data$SubjID])


data$ECG=as.numeric(data$ECG)
data$EOG=as.numeric(data$EOG)
data$HLU=as.numeric(data$HLU)

diseasedur = read.csv('~/Desktop/Alex_fingerprinting/QPN_diseasedurations.csv', na.strings = 'NaN', stringsAsFactors = FALSE)
colnames(diseasedur)[1]="IDs"
matched_id2= data$SubjID[data$SubjID %in% diseasedur$IDs]

data$DiseaseDur[data$SubjID %in% diseasedur$IDs ] =  plyr::mapvalues(data$SubjID[data$SubjID %in% diseasedur$IDs], matched_id2[order(matched_id2)], diseasedur$DiseaseDurationSinceDiagnosis[diseasedur$IDs %in% data$SubjID])

data$DiseaseDur=as.numeric(data$DiseaseDur)



# Look at different metrics of differentiability (identifability)
data4reg=data[data$Group=='Parkinson',]

cor.test(data4reg$identifiability, data4reg$identifiability_PD)
cor.test(data4reg$identifiability, data4reg$identifiability_control)



ggplot(data4reg, aes(x=identifiability_PD , y = identifiability_control, fill=identifiability, colour = identifiability)) + 
  geom_jitter() + 
  stat_smooth(method = "lm", colour = 'black',fullrange = T) + viridis::scale_color_viridis(option = 'magma')+
  viridis::scale_fill_viridis(option = 'magma')+
  # labs(title = paste("Adj R2 = ", signif(summary(lm3)$adj.r.squared, 5),
  #                    "Intercept =", signif(lm3$coef[[1]],5 ),
  #                    " Slope =", signif(lm3$coef[[2]], 5),
  #                    " P =", signif(summary(lm3)$coef[2,4], 5) )) 
  theme_classic2() +   xlab("PD identifiability") + ylab("Clinical identifiability")+
  theme(axis.text=element_text(size=12),
        axis.title=element_text(size=14,face="bold"))#, legend.position = "none") 


ggsave('/Users/jasondsc/Desktop/Alex_fingerprinting/figure/All_kinds_of_selef_id_map_legend.pdf', device = "pdf", width=5, height=5, dpi=800)

data4reg$diff= data4reg$identifiability_PD- data4reg$identifiability_control
ggplot(data4reg, aes(x=diff , y = identifiability, fill=identifiability, colour = identifiability)) + 
  geom_jitter() + 
  stat_smooth(method = "lm", colour = 'black',fullrange = T) + viridis::scale_color_viridis(option = 'magma')+
  viridis::scale_fill_viridis(option = 'magma')+
  # labs(title = paste("Adj R2 = ", signif(summary(lm3)$adj.r.squared, 5),
  #                    "Intercept =", signif(lm3$coef[[1]],5 ),
  #                    " Slope =", signif(lm3$coef[[2]], 5),
  #                    " P =", signif(summary(lm3)$coef[2,4], 5) )) 
  theme_classic2() +   xlab("diff identifiability") + ylab("identifiability")+
  theme(axis.text=element_text(size=12),
        axis.title=element_text(size=14,face="bold"))#, legend.position = "none") 


ggsave('/Users/jasondsc/Desktop/Alex_fingerprinting/figure/All_kinds_of_selef_id_map_legend.pdf', device = "pdf", width=5, height=5, dpi=800)



# make histograms of correlations from participant confusion matrix
############

corr_mat= read.csv('~/Desktop/Alex_fingerprinting/NEW_predictions_corr_matrix.csv', header = FALSE)
corr_mat=as.matrix(corr_mat)
hist(c(corr_mat[1:75,1:75]))
hist(c(corr_mat[79:154,79:154]))

t.test(c(corr_mat[1:75,1:75]), c(corr_mat[76:154,76:154]) )
t.test(c(corr_mat[76:154,1:75]), c(corr_mat[76:154,76:154]) )

df= data.frame(corr= c(corr_mat[1:75,1:75], corr_mat[76:154,76:154], corr_mat[76:154,1:75], corr_mat[1:75, 76:154]), 
               label= c(rep('controls', 75*75), rep('PD', 79*79), rep('PC corr to control', 79*75), rep('controls corr to PD', 79*75)))

ggplot(df, aes(x=corr, color=label, fill=label))+
  geom_histogram(aes(y=..density..)) + theme_classic2() + scale_color_manual(values=cbbPalette) + scale_fill_manual(values=cbbPalette) +
  facet_wrap(~label)

ggsave('/Users/jasondsc/Desktop/Alex_fingerprinting/figure/hist_of_corrs.pdf', device = "pdf", width=10, height=5, dpi=800)



##### t-SNE representation 
library("scde")
library(M3C)

cbbPalette2 <- c( "#90319D","#E25987","#FFBF00","#3A3AA4", "#31CD71", "#F0792C", "#6C3ABF", '#d62976', '#005f60', '#249ea0',
                  '#161414', '#e5ac1b', '#285dc8', '#6667ab', '#9bca53', '#df88b7', '#9a83b1', '#6a1431', '#e9d945', '#ad0000')


target= read.csv('~/Desktop/Alex_fingerprinting/NEW_features_4_fingeprinting_target.csv', header = FALSE)

database= read.csv('~/Desktop/Alex_fingerprinting/NEW_features_4_fingeprinting_database.csv', header = FALSE)

target=target[-1,-30670]
database=database[-1,-30670]

target=target[,-1]
database=database[,-1]
target=as.matrix(target)
database=as.matrix(database)

tsne(t(target),labels=data$Group) + theme_classic2() +
  theme(legend.position = 'none') 

ggsave('/Users/jasondsc/Desktop/Alex_fingerprinting/figure/tSNE_map_all_subs.pdf', device = "pdf",width=5, height=5, dpi=800)


tsne(t(database-target),labels=data$Group) + theme_classic2() +
  theme(legend.position = 'none') 

ggsave('/Users/jasondsc/Desktop/Alex_fingerprinting/figure/tSNE_map_all_subs_diff.pdf', device = "pdf",width=5, height=5, dpi=800)


tsne(corr_mat,labels=data$Group)+ theme_classic2() +
  theme(legend.position = 'none') 

ggsave('/Users/jasondsc/Desktop/Alex_fingerprinting/figure/tSNE_map_all_subs_corss.pdf', device = "pdf",width=5, height=5, dpi=800)


full_data= rbind(database,target)
#tsne(t(full_data),labels=rep(data$SubjID,2)) + theme(legend.position = 'none')

tt=tsne(t(full_data),labels=rep(data$SubjID,2)) 
load('~/Desktop/Alex_fingerprinting/tSNE_map_data2.rds')
data4plot=tt$data
data4plot$Group = rep(data$Group,2)
data4plot$SubjID = rep(data$SubjID,2)
data4plot$identifiability = rep(data$identifiability,2)

ggplot(data4plot, aes(x= X1, y=X2, color= SubjID, fill= SubjID, shape=Group)) + geom_point() + theme(legend.position = 'none')

dist=sqrt((data4plot$X1[1:154]-data4plot$X1[155:308])^2 + (data4plot$X2[1:154]-data4plot$X2[155:308])^2)
cor.test(dist, data$identifiability)



t.test(log(dist[data$Group=='Parkinson']), log(dist[data$Group=='Control']))
t.test(dist[data$Group=='Parkinson'], dist[data$Group=='Control'])


Q <- quantile(dist[data$Group=='Parkinson'], probs=c(.25, .75), na.rm = FALSE)
iqr <- IQR(dist[data$Group=='Parkinson'])
up <-  Q[2]+1.5*iqr # Upper Range  
low<- Q[1]-1.5*iqr # Lower Range
pd_outlier_remove<- subset(dist[data$Group=='Parkinson'], dist[data$Group=='Parkinson'] > (Q[1] - 1.5*iqr) & dist[data$Group=='Parkinson'] < (Q[2]+1.5*iqr))
index_pd=dist[data$Group=='Parkinson'] > (Q[1] - 1.5*iqr) & dist[data$Group=='Parkinson'] < (Q[2]+1.5*iqr)


Q <- quantile(dist[data$Group=='Control'], probs=c(.25, .75), na.rm = FALSE)
iqr <- IQR(dist[data$Group=='Control'])
up <-  Q[2]+1.5*iqr # Upper Range  
low<- Q[1]-1.5*iqr # Lower Range
control_outlier_remove<- subset(dist[data$Group=='Control'], dist[data$Group=='Control'] > (Q[1] - 1.5*iqr) & dist[data$Group=='Control'] < (Q[2]+1.5*iqr))
index_c=dist[data$Group=='Control'] > (Q[1] - 1.5*iqr) & dist[data$Group=='Control'] < (Q[2]+1.5*iqr)
t.test(pd_outlier_remove, control_outlier_remove)

index_outlier=c(index_c,index_pd)


ggplot(data, aes(x=Group , y = log(dist), colour=Group, fill=Group)) + 
  geom_jitter() + geom_boxplot(color='black', width= 0.25) + scale_color_manual(values=cbbPalette) +
  scale_fill_manual(values=cbbPalette)  + theme_classic2() +   xlab(" ") + ylab("log distance in t-SNE space")+
  theme(axis.text=element_text(size=12),
        axis.title=element_text(size=14,face="bold"), legend.position = 'none') 

ggsave('/Users/jasondsc/Desktop/Alex_fingerprinting/figure/boxplot_tsne_distance_group_diff_log2.pdf', device = "pdf", width=5, height=5, dpi=800)


ggplot(data, aes(x=Group , y = dist, colour=Group, fill=Group)) + 
  geom_jitter() + geom_boxplot(color='black', width= 0.25) + scale_color_manual(values=cbbPalette) +
  scale_fill_manual(values=cbbPalette)  + theme_classic2() +   xlab(" ") + ylab("log distance in t-SNE space")+
  theme(axis.text=element_text(size=12),
        axis.title=element_text(size=14,face="bold"), legend.position = 'none') 

ggsave('/Users/jasondsc/Desktop/Alex_fingerprinting/figure/boxplot_tsne_distance_group_diff2.pdf', device = "pdf", width=5, height=5, dpi=800)

data4plot_out=data[index_outlier,]
ggplot(data4plot_out, aes(x=Group , y = dist[index_outlier], colour=Group, fill=Group)) + 
  geom_jitter() + geom_boxplot(color='black', width= 0.25) + scale_color_manual(values=cbbPalette) +
  scale_fill_manual(values=cbbPalette)  + theme_classic2() +   xlab(" ") + ylab("log distance in t-SNE space")+
  theme(axis.text=element_text(size=12),
        axis.title=element_text(size=14,face="bold"), legend.position = 'none') 

ggsave('/Users/jasondsc/Desktop/Alex_fingerprinting/figure/boxplot_tsne_distance_group_diff_outlier_removed2.pdf', device = "pdf", width=5, height=5, dpi=800)



lm3=lm(log(dist) ~ data$identifiability +1)
summary(lm3)
sjPlot::tab_model(lm3)

save(tt, file='~/Desktop/Alex_fingerprinting/tSNE_map_data2.rds')


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


ggsave('/Users/jasondsc/Desktop/Alex_fingerprinting/figure/t-SNE_distance_identifiability_regression2.pdf', device = "pdf", width=5, height=5, dpi=800)





ggplot(data4plot, aes(x= X1, y=X2, color= identifiability, fill= identifiability, group= SubjID, shape=Group)) + geom_point(size=5) + geom_line(linetype = "dashed") +theme_classic2() +
  viridis::scale_fill_viridis(option = 'magma') + viridis::scale_color_viridis(option = 'magma') 

ggsave('/Users/jasondsc/Desktop/Alex_fingerprinting/figure/tSNE_map_all_subs_identifiability22.pdf', device = "pdf",width=5, height=5, dpi=800)


ggplot(data4plot, aes(x= X1, y=X2, color= identifiability, fill= identifiability, group= SubjID, shape=Group)) + geom_point(size=5) + geom_line(linetype = "dashed") +theme_classic2() +
  theme(legend.position = 'none') +  viridis::scale_fill_viridis(option = 'magma') + viridis::scale_color_viridis(option = 'magma') 

ggsave('/Users/jasondsc/Desktop/Alex_fingerprinting/figure/tSNE_map_all_subs_identifiability_nolegend22.pdf', device = "pdf",width=5, height=5, dpi=800)


mean(dist[data4plot$Group =="Parkinson"], na.rm = TRUE)
sd(dist[data4plot$Group =="Parkinson"], na.rm = TRUE)
mean(dist[data4plot$Group =="Control"], na.rm = TRUE)
sd(dist[data4plot$Group =="Control"], na.rm = TRUE)

# plot a subset 
Controls=sample(1:75,10)
PD= sample(76:154,10)
Controls= c(Controls, PD+154)
PD= c(PD, PD+154)
index=c(Controls, PD)

# index based on high low diff
index= c(head(order(data$identifiability[data$Group=='Control']),10), tail(order(data$identifiability[data$Group=='Control']),10),
  head(order(data$identifiability[data$Group=='Parkinson']),10)+75, tail(order(data$identifiability[data$Group=='Parkinson']),10)+75)

index= c(index, index+154)
data4plot2=data4plot[index,]


ggplot(data4plot2, aes(x= X1, y=X2, color= identifiability, fill= identifiability, group= SubjID, shape=Group)) + geom_point(size=5) + geom_line(linetype = "dashed") +theme_classic2() +
  viridis::scale_fill_viridis(option = 'magma') + viridis::scale_color_viridis(option = 'magma') 

ggsave('/Users/jasondsc/Desktop/Alex_fingerprinting/figure/tSNE_map_subset_of_subj_identifiability_new2.pdf', device = "pdf",width=5, height=5, dpi=800)


ggplot(data4plot2, aes(x= X1, y=X2, color= identifiability, fill= identifiability, group= SubjID, shape=Group)) + geom_point(size=5) + geom_line(linetype = "dashed") + theme_classic2() +
  theme(legend.position = 'none') +  viridis::scale_fill_viridis(option = 'magma') + viridis::scale_color_viridis(option = 'magma') 


ggsave('/Users/jasondsc/Desktop/Alex_fingerprinting/figure/tSNE_map_subset_of_subj_identifiability_new_nolegend2.pdf', device = "pdf",width=5, height=5, dpi=800)


