   
ds = 'wind_data'    % observation data

ws_obs = xlsread(ds, 'E2:E50');     % wind speed
wd_obs = xlsread(ds, 'F2:F50');     % wind direction

fetch_l = xlsread(ds, 'H2:H5');     % fetch length
fetch_d = xlsread(ds, 'I2:I5');     % fetch direction

g = 10 ;    % gravity
p = 1 : length(ws_obs) ;    % data lenghth 
z = p' ;

Rt = 1.10 ;
v = Rt.*ws_obs ;
ws_obs_cor = 0.71*v.^1.23 ; % wind speed correction 

% Fetch effectif
fetch_eff = sum(fetch_l.*cos(fetch_d))/sum(cos(fetch_d));

%Inversion calculation
G6    = [z.^0 z z.^2 z.^3 z.^4 z.^5 z.^6] ;
m6    = inv(G6'*G6)*G6'*ws_obs_cor(p) ;
ws_cal_o6 = G6*m6 ;

G8    = [z.^0 z z.^2 z.^3 z.^4 z.^5 z.^6 z.^7 z.^8] ;
m8    = inv(G8'*G8)*G8'*ws_obs_cor(p) ;
ws_cal_o8 = G8*m8 ;

G10    = [z.^0 z z.^2 z.^3 z.^4 z.^5 z.^6 z.^7 z.^8 z.^9 z.^10] ;
m10    = inv(G10'*G10)*G10'*ws_obs_cor(p) ;
ws_cal_o10 = G10*m10 ;

%{
use this for trial & error,
[z.^0 z z.^2 z.^3 z.^4 z.^5 z.^6 z.^7 z.^8 z.^9 z.^10 z.^11 z.^12 z.^13 z.^14 z.^15 z.^16 z.^17 z.^18 z.^19 z.^20]
%}

% Wave height alculation
wh_obs = 1.6*10^-3*((fetch_eff^1/3.*ws_obs_cor.^2)/g) ;
wh_cal_o6 = 1.6*10^-3*((fetch_eff^1/3.*ws_cal_o6.^2)/g) ;
wh_cal_o8 = 1.6*10^-3*((fetch_eff^1/3.*ws_cal_o8.^2)/g) ;
wh_cal_o10 = 1.6*10^-3*((fetch_eff^1/3.*ws_cal_o10.^2)/g) ;

% Wave period calculation
wp_obs = (0.2857*((fetch_eff^1/3*ws_obs_cor.^2)/g)) ;
wp_cal_o6 = (0.2857*((fetch_eff^1/3*ws_cal_o6.^2)/g)) ;
wp_cal_o8 = (0.2857*((fetch_eff^1/3*ws_cal_o8.^2)/g)) ;
wp_cal_o10 = (0.2857*((fetch_eff^1/3*ws_cal_o10.^2)/g)) ;


% RMSE calculation
RMSE_wh_o6 = mean((sum((wh_cal_o6-wh_obs).^2)/length(wh_obs)).^0.5);
RMSE_wh_o8 = mean((sum((wh_cal_o8-wh_obs).^2)/length(wh_obs)).^0.5);
RMSE_wh_o10 = mean((sum((wh_cal_o10-wh_obs).^2)/length(wh_obs)).^0.5);

RMSE_wp_o6 = mean((sum((wp_cal_o6-wp_obs).^2)/length(wh_obs)).^0.5);
RMSE_wp_o8 = mean((sum((wp_cal_o8-wp_obs).^2)/length(wh_obs)).^0.5);
RMSE_wp_o10 = mean((sum((wp_cal_o10-wp_obs).^2)/length(wh_obs)).^0.5);

figure(1)
subplot(121)
plot(wh_obs)
hold on
plot(wh_cal_o6)
plot(wh_cal_o8)
plot(wh_cal_o10)
title('Significan Wave Height')
xlabel('t(hour)')
ylabel('H(m)')
legend({'Obs','Cal (order 6)', 'Cal (order 8)', 'Cal (order 10)'}, 'Location', 'northwest')

subplot(122)
plot(wp_obs)
hold on
plot(wp_cal_o6)
plot(wp_cal_o8)
plot(wp_cal_o10)
title('Significan Wave Period')
xlabel('t(hour)')
ylabel('P(s)')
legend({'Obs','Cal (order 6)', 'Cal (order 8)', 'Cal (order 10)'}, 'Location', 'northwest')


% Hindcasting 
timestep = 0 : 51 ; % hours
x = timestep' ;

y6 = m6(7, 1)*x.^6 + m6(6, 1)*x.^5 + m6(5, 1)*x.^4 + m6(4, 1)*x.^3 + m6(3, 1)*x.^2 + m6(2, 1)*x + m6(1, 1) ;
y8 = m8(9, 1)*x.^8 + m8(8, 1)*x.^7 + m8(7, 1)*x.^6 + m8(6, 1)*x.^5 + m8(5, 1)*x.^4 + m8(4, 1)*x.^3 + m8(3, 1)*x.^2 + m8(2, 1)*x + m8(1, 1) ;
y10 = m10(11, 1)*x.^10 + m10(10, 1)*x.^9 + m10(9, 1)*x.^8 + m10(8, 1)*x.^7 + m10(7, 1)*x.^6 + m10(6, 1)*x.^5 + m10(5, 1)*x.^4 + m10(4, 1)*x.^3 + m10(3, 1)*x.^2 + m10(2, 1)*x + m10(1, 1) ;

% Wave height hindcasting
wh_calH_o6 = 1.6*10^-3*((fetch_eff^1/3.*y6.^2)/g) ;
wh_calH_o8 = 1.6*10^-3*((fetch_eff^1/3.*y8.^2)/g) ;
wh_calH_o10 = 1.6*10^-3*((fetch_eff^1/3.*y10.^2)/g) ;

% Wave period hindcasting
wp_calH_o6 = (0.2857*((fetch_eff^1/3*y6.^2)/g)) ;
wp_calH_o8 = (0.2857*((fetch_eff^1/3*y8.^2)/g)) ;
wp_calH_o10 = (0.2857*((fetch_eff^1/3*y10.^2)/g)) ;

figure(2)
subplot(131)
plot(wh_calH_o6)
hold on
plot(wh_calH_o8)
plot(wh_calH_o10)
title('Wave Height Hindcasting')
xlabel('t(hour)')
ylabel('H(m)')
legend({'inv order 6', 'inv order 8', 'inv order 10'}, 'Location', 'northwest')

subplot(132)
plot(wp_calH_o6)
hold on
plot(wp_calH_o8)
plot(wp_calH_o10)
title('Wave Period Hindcasting')
xlabel('t(hour)')
ylabel('P(s)')
legend({'inv order 6', 'inv order 8', 'inv order 10'}, 'Location', 'northwest')

subplot(133)
plot(y6)
hold on 
plot(y8)
plot(y10)
title('Wind Wave Hindcasting')
xlabel('t(hour)')
ylabel('v(km/hour)')
legend({'inv order 6', 'inv order 8', 'inv order 10'}, 'Location', 'northwest')


labels = {'Order 6', 'Order 8', 'Order 10'};
rmse_wh = [RMSE_wh_o6, RMSE_wh_o8, RMSE_wh_o10];
rmse_wp = [RMSE_wp_o6, RMSE_wp_o8, RMSE_wp_o10];

figure(3)
subplot(1, 2, 1);
bar(rmse_wh, 'FaceColor', [0.53, 0.81, 0.92]); % c=skyblue
title('RMSE Wave Height');
ylabel('H(m)');
set(gca, 'XTickLabel', labels);

subplot(1, 2, 2);
bar(rmse_wp, 'FaceColor', [1.00, 0.45, 0.45]); % c=salmon
title('RMSE Wave Periode');
ylabel('P(s)');
set(gca, 'XTickLabel', labels);
%sgtitle('RMSE Tinggi dan Periode');

