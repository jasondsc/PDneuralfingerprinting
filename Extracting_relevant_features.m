clear all
close all
clc

%% Spectra
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load('QPN_epoch_DKAtlassourcePSDfullspectrum_export_07162021.mat')
count=1;

for i=[58 69]
    
    count2=1;
    temp=squeeze(PD_data(:,:,:,i));
    temp=reshape(rmmissing(temp(:)), [68,901, length(rmmissing(temp(:)))/61268]);
    
    for j= 1:9
    training=squeeze(mean(temp(:,:,(((j-1)*5)+1):(j*5)),3));
    csvwrite(strcat('/media/jdscasta/Jason_drive/Alex_fingerprint/output/sub_',sprintf('%05d',count), '_spectrum_training_',int2str(count2),'.csv'), training)
    count2=count2+1;
    end
    count=count+1;
end



for i=1:length(HC_dirs)
    
    count2=1;
    temp=squeeze(HC_data(:,:,:,i));
    temp=reshape(rmmissing(temp(:)), [68,901, length(rmmissing(temp(:)))/61268]);
    
    for j= 1:7
    training=squeeze(mean(temp(:,:,(((j-1)*5)+1):(j*5)),3));
    csvwrite(strcat('/media/jdscasta/Jason_drive/Alex_fingerprint/output/full_spectra30s/sub_',sprintf('%05d',count), '_spectrum_training_',int2str(count2),'.csv'), training)
    count2=count2+1;
    end
    count=count+1;
end

for i=1:length(PD_dirs)
    

    count2=1;
    temp=squeeze(PD_data(:,:,:,i));
    temp=reshape(rmmissing(temp(:)), [68,901, length(rmmissing(temp(:)))/61268]);
    
    for j= 1:7
    training=squeeze(mean(temp(:,:,(((j-1)*5)+1):(j*5)),3));
    csvwrite(strcat('/media/jdscasta/Jason_drive/Alex_fingerprint/output/full_spectra30s/sub_',sprintf('%05d',count), '_spectrum_training_',int2str(count2),'.csv'), training)
    count2=count2+1;
    end
    count=count+1;
    
end


count2=1;
count=1;


for i=1:length(HC_dirs)
    
    count2=1;
    temp=squeeze(HC_data(:,:,:,i));
    temp=reshape(rmmissing(temp(:)), [68,901, length(rmmissing(temp(:)))/61268]);
    
    training=squeeze(mean(temp(:,:,1:floor(size(temp,3)/2)),3));
    validation=squeeze(mean(temp(:,:,floor(size(temp,3)/2)+1:end),3));
    csvwrite(strcat('/media/jdscasta/Jason_drive/Alex_fingerprint/output/full_spectra/sub_',sprintf('%05d',count), '_spectrum_training.csv'), training)
    csvwrite(strcat('/media/jdscasta/Jason_drive/Alex_fingerprint/output/full_spectra/sub_',sprintf('%05d',count), '_spectrum_validation.csv'), validation)
    count2=count2+1;
    count=count+1;
end


for i=1:length(PD_dirs)
    

    count2=1;
    temp=squeeze(PD_data(:,:,:,i));
    temp=reshape(rmmissing(temp(:)), [68,901, length(rmmissing(temp(:)))/61268]);
    
    training=squeeze(mean(temp(:,:,1:floor(size(temp,3)/2)),3));
    validation=squeeze(mean(temp(:,:,floor(size(temp,3)/2)+1:end),3));
    csvwrite(strcat('/media/jdscasta/Jason_drive/Alex_fingerprint/output/full_spectra/sub_',sprintf('%05d',count), '_spectrum_training.csv'), training)
    csvwrite(strcat('/media/jdscasta/Jason_drive/Alex_fingerprint/output/full_spectra/sub_',sprintf('%05d',count), '_spectrum_validation.csv'), validation)
    count2=count2+1;
    count=count+1;
    
end

%% Specparam
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
clc
load('/media/jdscasta/Elements/QPN_epoch_DKAtlassourceFOOOF_export_11302021.mat')

count=1;
for i=1:length(HC_dirs)
    
    
    temp=squeeze(HC_apfit(:,:,:,i));
    temp=reshape(rmmissing(temp(:)), [68,115, length(rmmissing(temp(:)))/7820]);
    
    training=squeeze(mean(temp(:,:,1:floor(size(temp,3)/2)),3));
    validation=squeeze(mean(temp(:,:,floor(size(temp,3)/2)+1:end),3));
    
    csvwrite(strcat('/media/jdscasta/Jason_drive/Alex_fingerprint/aperiodic/sub_',sprintf('%05d',count), '_spectrum_training.csv'), training)
    csvwrite(strcat('/media/jdscasta/Jason_drive/Alex_fingerprint/aperiodic/sub_',sprintf('%05d',count), '_spectrum_validation.csv'), validation)
    
    temp=squeeze(HC_offset(:,:,:,i));
    temp=reshape(rmmissing(temp(:)), [68, length(rmmissing(temp(:)))/68]);
    
    HC_training_offset(:,i)=squeeze(mean(temp(:,1:floor(size(temp,3)/2)),2));
    HC_validation_offset(:,i)=squeeze(mean(temp(:,floor(size(temp,3)/2)+1:end),2));
    
    temp=squeeze(HC_slope(:,:,:,i));
    temp=reshape(rmmissing(temp(:)), [68, length(rmmissing(temp(:)))/68]);
    
    HC_training_slope(:,i)=squeeze(mean(temp(:,1:floor(size(temp,3)/2)),2));
    HC_validation_slope(:,i)=squeeze(mean(temp(:,floor(size(temp,3)/2)+1:end),2));
    
    count=count+1;
end


for i=1:length(PD_dirs)
    
        
    temp=squeeze(PD_apfit(:,:,:,i));
    temp=reshape(rmmissing(temp(:)), [68,115, length(rmmissing(temp(:)))/7820]);
    
    training=squeeze(mean(temp(:,:,1:floor(size(temp,3)/2)),3));
    validation=squeeze(mean(temp(:,:,floor(size(temp,3)/2)+1:end),3));
    
    csvwrite(strcat('/media/jdscasta/Jason_drive/Alex_fingerprint/aperiodic/sub_',sprintf('%05d',count), '_spectrum_training.csv'), training)
    csvwrite(strcat('/media/jdscasta/Jason_drive/Alex_fingerprint/aperiodic/sub_',sprintf('%05d',count), '_spectrum_validation.csv'), validation)
    
    temp=squeeze(PD_offset(:,:,:,i));
    temp=reshape(rmmissing(temp(:)), [68,length(rmmissing(temp(:)))/68]);
    
    PD_training_offset(:,i)=squeeze(mean(temp(:,1:floor(size(temp,2)/2)),2));
    PD_validation_offset(:,i)=squeeze(mean(temp(:,floor(size(temp,2)/2)+1:end),2));
    
    temp=squeeze(PD_slope(:,:,:,i));
    temp=reshape(rmmissing(temp(:)), [68,length(rmmissing(temp(:)))/68]);
    
    PD_training_slope(:,i)=squeeze(mean(temp(:,1:floor(size(temp,2)/2)),2));
    PD_validation_slope(:,i)=squeeze(mean(temp(:,floor(size(temp,2)/2)+1:end),2));
    
    
    count=count+1;
    
end

%previous PD or HC validation files for slope and offset were recording
%average (not split up) 

    csvwrite('/media/jdscasta/Jason_drive/Alex_fingerprint/HC_validation_offset.csv', HC_validation_offset)
     csvwrite('/media/jdscasta/Jason_drive/Alex_fingerprint/HC_validation_slope.csv', HC_validation_slope)
        csvwrite('/media/jdscasta/Jason_drive/Alex_fingerprint/PD_validation_offset.csv', PD_validation_offset)
     csvwrite('/media/jdscasta/Jason_drive/Alex_fingerprint/PD_validation_slope.csv', PD_validation_slope)
  

     
     
    
%% Cortical thickness 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load('/media/jdscasta/Elements/QPN_corticalthickness_DKAtlasnative_jason_12092021.mat')


csvwrite('/media/jdscasta/Jason_drive/Alex_fingerprint/PD_ID_cortical_thiccnes.csv', PD_IDs');

csvwrite('/media/jdscasta/Jason_drive/Alex_fingerprint/Cortical_thiccness.csv', thickness_data_PD);


periodic

clear all
clc
load('/media/jdscasta/Jason_drive/Alex_fingerprint/QPN_epoch_DKAtlassourceFOOOF_peakfit_export_01242022.mat')

count=1;
for i=1:length(HC_dirs)
    
    
    temp=squeeze(HC_peakfit(:,:,:,i));
    temp=reshape(rmmissing(temp(:)), [68,115, length(rmmissing(temp(:)))/7820]);
    
    training=squeeze(mean(temp(:,:,1:floor(size(temp,3)/2)),3));
    validation=squeeze(mean(temp(:,:,floor(size(temp,3)/2)+1:end),3));
    
    csvwrite(strcat('/media/jdscasta/Jason_drive/Alex_fingerprint/periodic/sub_',sprintf('%05d',count), '_spectrum_training.csv'), training)
    csvwrite(strcat('/media/jdscasta/Jason_drive/Alex_fingerprint/periodic/sub_',sprintf('%05d',count), '_spectrum_validation.csv'), validation)
    
    temp=squeeze(HC_r2(:,:,i));
    temp=reshape(rmmissing(temp(:)), [68, length(rmmissing(temp(:)))/68]);
    
    HC_training_r(:,i)=squeeze(mean(temp(:,1:floor(size(temp,2)/2)),2));
    HC_validation_r(:,i)=squeeze(mean(temp(:,floor(size(temp,2)/2)+1:end),2));
    
    
    count=count+1;
end


for i=1:length(PD_dirs)
    
        
    temp=squeeze(PD_peakfit(:,:,:,i));
    temp=reshape(rmmissing(temp(:)), [68,115, length(rmmissing(temp(:)))/7820]);
    
    training=squeeze(mean(temp(:,:,1:floor(size(temp,3)/2)),3));
    validation=squeeze(mean(temp(:,:,floor(size(temp,3)/2)+1:end),3));
    
    csvwrite(strcat('/media/jdscasta/Jason_drive/Alex_fingerprint/periodic/sub_',sprintf('%05d',count), '_spectrum_training.csv'), training)
    csvwrite(strcat('/media/jdscasta/Jason_drive/Alex_fingerprint/periodic/sub_',sprintf('%05d',count), '_spectrum_validation.csv'), validation)
    
    temp=squeeze(PD_r2(:,:,i));
    temp=reshape(rmmissing(temp(:)), [68,length(rmmissing(temp(:)))/68]);
    
    PD_training_r(:,i)=squeeze(mean(temp(:,1:floor(size(temp,2)/2)),2));
    PD_validation_r(:,i)=squeeze(mean(temp(:,floor(size(temp,2)/2)+1:end),2));
   
    
    count=count+1;
    
end

csvwrite('/media/jdscasta/Jason_drive/Alex_fingerprint/HC_training_R2.csv', HC_training_r)
csvwrite('/media/jdscasta/Jason_drive/Alex_fingerprint/HC_validation_R2.csv', HC_validation_r)

  
csvwrite('/media/jdscasta/Jason_drive/Alex_fingerprint/PD_training_R2.csv', PD_training_r)
csvwrite('/media/jdscasta/Jason_drive/Alex_fingerprint/PD_validation_R2.csv', PD_validation_r)

  

%% Empty Rooms
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
clc
load('~/Desktop/Alex_fingerprinting/QPN_epoch_DKAtlas_EmptyRoom_PSDs_export_03172022.mat')

count=1;
for i=1:length(HC_IDs)
    
    
    temp=squeeze(HC_TF_dat(:,:,:,i));
    temp=reshape(rmmissing(temp(:)), [68,901, length(rmmissing(temp(:)))/61268]);
    disp(size(temp,3))
    training=squeeze(mean(temp(:,:,:),3));
    
    csvwrite(strcat('/Users/jasondsc/Desktop/Alex_fingerprinting/emptyroom/sub_',sprintf('%05d',count), '_spectrum_training.csv'), training)
    csvwrite(strcat('/Users/jasondsc/Desktop/Alex_fingerprinting/emptyroom2/sub_',sprintf('%05d',count), '_spectrum_validation.csv'), training)
    num_wind(count)=size(temp,3);
    count=count+1;
end


for i=1:length(PD_IDs)
    
        
    temp=squeeze(PD_TF_dat(:,:,:,i));
    temp=reshape(rmmissing(temp(:)), [68,901, length(rmmissing(temp(:)))/61268]);
    disp(size(temp,3))
    training=squeeze(mean(temp(:,:,:),3));
    
    csvwrite(strcat('/Users/jasondsc/Desktop/Alex_fingerprinting/emptyroom/sub_',sprintf('%05d',count), '_spectrum_training.csv'), training)
    csvwrite(strcat('/Users/jasondsc/Desktop/Alex_fingerprinting/emptyroom2/sub_',sprintf('%05d',count), '_spectrum_validation.csv'), training)
    num_wind(count)=size(temp,3);
    count=count+1;
    
end


csvwrite('/Users/jasondsc/Desktop/Alex_fingerprinting/emptyroom_window_num.csv', num_wind)

