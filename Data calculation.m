clear
close
clc

%% Read in csv file
data = csvread('TG_data.csv',1,0);

%% Plot certain frame
frame = 1;
time = data(frame, 1);
for line = 1:17
    row = (50*(line-1))+frame; % 1, 51, 101, ..., 801 
    temp(line,:) = data(row, 2:end);
end
subplot(2,2,1)
pcolor(temp); axis square
title( ['Frame: ', num2str(frame), '. At ', num2str(time), ' s'] )
colorbar

%% Average out all frames (0.01s)
time_ave = data(50, 1);
for p = 0:16
    temp_ave(p+1,:) = sum(data((1+50*p):50+50*p, 2:end))./50; % 1:50, 51:100, 101:150, ...
end
subplot(2,2,2)
pcolor(temp_ave); axis square
title(['Average out all 50 frames. ', 'In ', num2str(time_ave), ' s'])
colorbar

%% Add filter to calaulate area rate
filter = 41.3; %threshold
temp_ave(temp_ave<filter)=0;
temp_ave(temp_ave>=filter)=1;
rate=(sum(sum(temp_ave))/numel(temp_ave))*100;
subplot(2,2,4)
pcolor(temp_ave); axis square
colorbar
title(['Using filter: ', num2str(filter), '. Area rate: ', num2str(rate), ' %'])

