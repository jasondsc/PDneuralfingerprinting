clear all
clc
load('/media/jdscasta/Jason_drive/Alex_fingerprint/QPN_epoch_DKAtlassourcePSDfullspectrum_export_07162021.mat')


%% full spectra

count2=1;
count=1;


for i=1:length(HC_dirs)
    
    count2=1;
    temp=squeeze(HC_data(:,:,:,i));
    temp=reshape(rmmissing(temp(:)), [68,901, length(rmmissing(temp(:)))/61268]);
    
    if size (temp,3) > 50

    training=squeeze(mean(temp(:,:,1:floor(size(temp,3)/2)),3));
    validation=squeeze(mean(temp(:,:,floor(size(temp,3)/2)+1:end),3));
    csvwrite(strcat('/export03/data/PD_finger/2023_data/fullspectra/sub_',sprintf('%05d',count), '_spectrum_training.csv'), training)
    csvwrite(strcat('/export03/data/PD_finger/2023_data/fullspectra/sub_',sprintf('%05d',count), '_spectrum_validation.csv'), validation)
    count2=count2+1;
    count=count+1;
    end
end


for i=1:length(PD_dirs)
    

    count2=1;
    temp=squeeze(PD_data(:,:,:,i));
    temp=reshape(rmmissing(temp(:)), [68,901, length(rmmissing(temp(:)))/61268]);
    
    if size (temp,3) > 50
    training=squeeze(mean(temp(:,:,1:floor(size(temp,3)/2)),3));
    validation=squeeze(mean(temp(:,:,floor(size(temp,3)/2)+1:end),3));
    csvwrite(strcat('/export03/data/PD_finger/2023_data/fullspectra/sub_',sprintf('%05d',count), '_spectrum_training.csv'), training)
    csvwrite(strcat('/export03/data/PD_finger/2023_data/fullspectra/sub_',sprintf('%05d',count), '_spectrum_validation.csv'), validation)
    count2=count2+1;
    count=count+1;
     end
    
end



%% SHORT

count=1;
for i=1:length(HC_dirs)
    
    count2=1;
    temp=squeeze(HC_data(:,:,:,i));
    temp=reshape(rmmissing(temp(:)), [68,901, length(rmmissing(temp(:)))/61268]);
   
    if size (temp,3) > 50
    for j= 1:13
    training=squeeze(mean(temp(:,:,(((j-1)*5)+1):(j*5)),3));
    csvwrite(strcat('/export03/data/PD_finger/2023_data/short_fullspectra/sub_',sprintf('%05d',count), '_spectrum_training_',int2str(count2),'.csv'), training)
    count2=count2+1;
    end
    count=count+1;
    end
    
end

for i=1:length(PD_dirs)
    

    count2=1;
    temp=squeeze(PD_data(:,:,:,i));
    temp=reshape(rmmissing(temp(:)), [68,901, length(rmmissing(temp(:)))/61268]);
    
    if size (temp,3) > 50
    for j= 1:13
    training=squeeze(mean(temp(:,:,(((j-1)*5)+1):(j*5)),3));
    csvwrite(strcat('/export03/data/PD_finger/2023_data/short_fullspectra/sub_',sprintf('%05d',count), '_spectrum_training_',int2str(count2),'.csv'), training)
    count2=count2+1;
    end
    count=count+1;
    end
    
end


%%clear all
clc
load('/media/jdscasta/Jason_drive/Alex_fingerprint/QPN_epoch_DKAtlassourceFOOOF_export_11302021.mat')


%% full spectra


count2=1;
count=1;


for i=1:length(HC_dirs)
    
    count2=1;
    temp=squeeze(HC_apfit(:,:,:,i));
    temp=reshape(rmmissing(temp(:)), [68,115, length(rmmissing(temp(:)))/7820]);
    
     if size (temp,3) > 50
    training=squeeze(mean(temp(:,:,1:floor(size(temp,3)/2)),3));
    validation=squeeze(mean(temp(:,:,floor(size(temp,3)/2)+1:end),3));
    csvwrite(strcat('/export03/data/PD_finger/2023_data/aperiodic/sub_',sprintf('%05d',count), '_spectrum_training.csv'), training)
    csvwrite(strcat('/export03/data/PD_finger/2023_data/aperiodic/sub_',sprintf('%05d',count), '_spectrum_validation.csv'), validation)
    count2=count2+1;
    count=count+1;
     end
end


for i=1:length(PD_dirs)
    

    count2=1;
    temp=squeeze(PD_apfit(:,:,:,i));
    temp=reshape(rmmissing(temp(:)), [68,115, length(rmmissing(temp(:)))/7820]);
    
     if size (temp,3) > 50
    training=squeeze(mean(temp(:,:,1:floor(size(temp,3)/2)),3));
    validation=squeeze(mean(temp(:,:,floor(size(temp,3)/2)+1:end),3));
    csvwrite(strcat('/export03/data/PD_finger/2023_data/aperiodic/sub_',sprintf('%05d',count), '_spectrum_training.csv'), training)
    csvwrite(strcat('/export03/data/PD_finger/2023_data/aperiodic/sub_',sprintf('%05d',count), '_spectrum_validation.csv'), validation)
    count2=count2+1;
    count=count+1;
     end
    
end



%% SHORT

count=1;
for i=1:length(HC_dirs)
    
    count2=1;
    temp=squeeze(HC_apfit(:,:,:,i));
    temp=reshape(rmmissing(temp(:)), [68,115, length(rmmissing(temp(:)))/7820]);
   
    if size (temp,3) > 50
    for j= 1:13
    training=squeeze(mean(temp(:,:,(((j-1)*5)+1):(j*5)),3));
    csvwrite(strcat('/export03/data/PD_finger/2023_data/short_aperiodic/sub_',sprintf('%05d',count), '_spectrum_training_',int2str(count2),'.csv'), training)
    count2=count2+1;
    end
    count=count+1;
    end
    
end

for i=1:length(PD_dirs)
    

    count2=1;
    temp=squeeze(PD_apfit(:,:,:,i));
    temp=reshape(rmmissing(temp(:)), [68,115, length(rmmissing(temp(:)))/7820]);
    
    if size (temp,3) > 50
    for j= 1:13
    training=squeeze(mean(temp(:,:,(((j-1)*5)+1):(j*5)),3));
    csvwrite(strcat('/export03/data/PD_finger/2023_data/short_aperiodic/sub_',sprintf('%05d',count), '_spectrum_training_',int2str(count2),'.csv'), training)
    count2=count2+1;
    end
    count=count+1;
    end
    
end


%%

clear
load('/media/jdscasta/Jason_drive/Alex_fingerprint/QPN_epoch_DKAtlassourceFOOOF_peakfit_export_01242022.mat')


count=1;
for i=1:length(HC_dirs)
    
    count2=1;
    temp=squeeze(HC_r2(:,:,i));
    temp=reshape(rmmissing(temp(:)), [68, length(rmmissing(temp(:)))/68]);
    
   
    if size (temp,2) > 50
    for jj= 1:13
        training(count,jj,:)=squeeze(mean(temp(:,(((jj-1)*5)+1):(jj*5)),2));
        count2=count2+1;
    end
    count=count+1;
    end
    
end

for i=1:length(PD_dirs)
    
    count2=1;
    temp=squeeze(PD_r2(:,:,i));
       temp=reshape(rmmissing(temp(:)), [68, length(rmmissing(temp(:)))/68]);
    
  
    if size (temp,2) > 50
    for jj= 1:13
        training(count,jj,:)=squeeze(mean(temp(:,(((jj-1)*5)+1):(jj*5)),2));
        count2=count2+1;
    end
    count=count+1;
    end
    
end

save('/export03/data/PD_finger/2023_data/R2_fits.mat', 'training')
writematrix(mean(training,3), '/export03/data/PD_finger/2023_data/R2_fits.csv')

%%

clear all
clc
load('/media/jdscasta/Jason_drive/Alex_fingerprint/QPN_epoch_DKAtlassourcePSDfullspectrum_export_07162021.mat')
load('/media/jdscasta/Jason_drive/Alex_fingerprint/QPN_epoch_DKAtlassourceFOOOF_export_11302021.mat')




count2=1;
count=1;


for i=1:length(HC_dirs)
    
    count2=1;
    temp=squeeze(HC_data(:,:,:,i));
    temp=reshape(rmmissing(temp(:)), [68,901, length(rmmissing(temp(:)))/61268]);

    temp2=squeeze(HC_apfit(:,:,:,i));
    temp2=reshape(rmmissing(temp2(:)), [68,115, length(rmmissing(temp2(:)))/7820]);
    
    if size (temp,3) > 50

    training=squeeze(mean(temp(:,:,1:floor(size(temp,3)/2)),3));
    training2=squeeze(mean(temp2(:,:,1:floor(size(temp2,3)/2)),3));
    trainingnolog=training(:,7:121)-training2;
    training10=log10(training(:,7:121))-log10(training2);

    csvwrite(strcat('/export03/data/PD_finger/2023_data/corrspectra/sub_',sprintf('%05d',count), '_spectrum_training.csv'), trainingnolog)
    csvwrite(strcat('/export03/data/PD_finger/2023_data/corrspectraLOG/sub_',sprintf('%05d',count), '_spectrum_training.csv'), training10)
    
    validation=squeeze(mean(temp(:,:,floor(size(temp,3)/2)+1:end),3));
    validation2=squeeze(mean(temp2(:,:,floor(size(temp2,3)/2)+1:end),3));
    validationnolog=validation(:,7:121)-validation2;
    validation10=log10(validation(:,7:121))-log10(validation2);

    csvwrite(strcat('/export03/data/PD_finger/2023_data/corrspectra/sub_',sprintf('%05d',count), '_spectrum_validation.csv'), validationnolog)
    csvwrite(strcat('/export03/data/PD_finger/2023_data/corrspectraLOG/sub_',sprintf('%05d',count), '_spectrum_validation.csv'), validation10)
    

    
    count2=count2+1;
    count=count+1;
    end
end


for i=1:length(PD_dirs)
    

    count2=1;
    temp=squeeze(PD_data(:,:,:,i));
    temp=reshape(rmmissing(temp(:)), [68,901, length(rmmissing(temp(:)))/61268]);

    temp2=squeeze(PD_apfit(:,:,:,i));
    temp2=reshape(rmmissing(temp2(:)), [68,115, length(rmmissing(temp2(:)))/7820]);
    
    if size (temp,3) > 50

    training=squeeze(mean(temp(:,:,1:floor(size(temp,3)/2)),3));
    training2=squeeze(mean(temp2(:,:,1:floor(size(temp2,3)/2)),3));
    trainingnolog=training(:,7:121)-training2;
    training10=log10(training(:,7:121))-log10(training2);

    csvwrite(strcat('/export03/data/PD_finger/2023_data/corrspectra/sub_',sprintf('%05d',count), '_spectrum_training.csv'), trainingnolog)
    csvwrite(strcat('/export03/data/PD_finger/2023_data/corrspectraLOG/sub_',sprintf('%05d',count), '_spectrum_training.csv'), training10)
    
    validation=squeeze(mean(temp(:,:,floor(size(temp,3)/2)+1:end),3));
    validation2=squeeze(mean(temp2(:,:,floor(size(temp2,3)/2)+1:end),3));
    validationnolog=validation(:,7:121)-validation2;
    validation10=log10(validation(:,7:121))-log10(validation2);

    csvwrite(strcat('/export03/data/PD_finger/2023_data/corrspectra/sub_',sprintf('%05d',count), '_spectrum_validation.csv'), validationnolog)
    csvwrite(strcat('/export03/data/PD_finger/2023_data/corrspectraLOG/sub_',sprintf('%05d',count), '_spectrum_validation.csv'), validation10)
    
    count2=count2+1;
    count=count+1;
     end
    
end



%% SHORT

count=1;
for i=1:length(HC_dirs)
    
    count2=1;
    temp=squeeze(HC_data(:,:,:,i));
    temp=reshape(rmmissing(temp(:)), [68,901, length(rmmissing(temp(:)))/61268]);

    temp2=squeeze(HC_apfit(:,:,:,i));
    temp2=reshape(rmmissing(temp2(:)), [68,115, length(rmmissing(temp2(:)))/7820]);
   
    if size (temp,3) > 50
    for j= 1:13

    training=squeeze(mean(temp(:,:,(((j-1)*5)+1):(j*5)),3));
    training2=squeeze(mean(temp2(:,:,(((j-1)*5)+1):(j*5)),3));

    trainingnolog=training(:,7:121)-training2;
    training10=log10(training(:,7:121))-log10(training2);

    csvwrite(strcat('/export03/data/PD_finger/2023_data/short_corrspectra/sub_',sprintf('%05d',count), '_spectrum_training_',int2str(count2),'.csv'), trainingnolog)
    csvwrite(strcat('/export03/data/PD_finger/2023_data/short_corrspectraLOG/sub_',sprintf('%05d',count), '_spectrum_training_',int2str(count2),'.csv'), training10)
    
    count2=count2+1;
    
    
    end
    count=count+1;
    end
    
end

for i=1:length(PD_dirs)
    

    count2=1;
    temp=squeeze(PD_data(:,:,:,i));
    temp=reshape(rmmissing(temp(:)), [68,901, length(rmmissing(temp(:)))/61268]);

    temp2=squeeze(PD_apfit(:,:,:,i));
    temp2=reshape(rmmissing(temp2(:)), [68,115, length(rmmissing(temp2(:)))/7820]);
   
    if size (temp,3) > 50
    for j= 1:13

    training=squeeze(mean(temp(:,:,(((j-1)*5)+1):(j*5)),3));
    training2=squeeze(mean(temp2(:,:,(((j-1)*5)+1):(j*5)),3));

    trainingnolog=training(:,7:121)-training2;
    training10=log10(training(:,7:121))-log10(training2);

    csvwrite(strcat('/export03/data/PD_finger/2023_data/short_corrspectra/sub_',sprintf('%05d',count), '_spectrum_training_',int2str(count2),'.csv'), trainingnolog)
    csvwrite(strcat('/export03/data/PD_finger/2023_data/short_corrspectraLOG/sub_',sprintf('%05d',count), '_spectrum_training_',int2str(count2),'.csv'), training10)
    
    count2=count2+1;
    
    
    end
    count=count+1;
    end
    
end

