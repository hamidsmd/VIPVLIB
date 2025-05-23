%% Meteorological Data

Temperature = xlsread('Data/Temperature.xlsx'); % Air Temperature (°C)

G_top = xlsread('G_top.xlsx'); % Irradince, Top Surface (W/m^2)

G_back = xlsread('G_back.xlsx'); % Irradince, Back Surface (W/m^2)

G_right = xlsread('G_right.xlsx'); % Irradince, Right Surface (W/m^2)

G_left = xlsread('G_left.xlsx'); % Irradince, Left Surface (W/m^2)


windsp = xlsread('Data/Windspeed.xlsx'); % Wind Speed (m/s)

Speed = xlsread('Data/Speed.xlsx'); % Vehicle Speed (m/s)

hroof = 2.8; %  Roof Height (m)
windsp1 = windsp * (hroof / (10 ^ 0.2)); % This equation was used to adjust the wind speed data from climatological datasets, typically measured at 10 meters above ground, to correspond to roof height.


for i = 1:length(G_top)

if Speed(i,1)==0

windspeed(i,1) = windsp1(i,1);

else

windspeed(i,1) = Speed(i,1);

end

end

%% Thermal Model

NOCT = 48; % Nominal Operating Cell Temperature (°C)
T_amb = 20; % Ambient Air Temperature (°C)
Radation = 800; % (W/m^2)

U0 = 30.02; % (W/m^2 K)
U1 = 6.28; % (W/m^3 K)

for j = 1:length(G_top)

    Tft(j,1) = Temperature(j) + (G_top(j) / (U0 + (U1 * windspeed(j))));
    Tnt(j,1) = Temperature(j) + ((G_top(j) / Radation) * (NOCT - T_amb));

    Tfb(j,1) = Temperature(j) + (G_back(j) / (U0 + (U1 * windspeed(j))));
    Tnb(j,1) = Temperature(j) + ((G_back(j) / Radation) * (NOCT - T_amb));

    Tfr(j,1) = Temperature(j) + (G_right(j) / (U0 + (U1 * windspeed(j))));
    Tnr(j,1) = Temperature(j) + ((G_right(j) / Radation) * (NOCT - T_amb));

    Tfl(j,1) = Temperature(j) + (G_left(j) / (U0 + (U1 * windspeed(j))));
    Tnl(j,1) = Temperature(j) + ((G_left(j) / Radation) * (NOCT - T_amb));

end

T_Faiman = ones(length(G_top),4);


T_Faiman (:,1) = T_Faiman (:,1) * mean(Tft); % Average Temperature During Driving Cycle
T_Faiman (:,2) = T_Faiman (:,2) * mean(Tfb);
T_Faiman (:,3) = T_Faiman (:,3) * mean(Tfr);
T_Faiman (:,4) = T_Faiman (:,4) * mean(Tfl);

writematrix(T_Faiman, 'T_Faiman.xlsx');


T_NOCT = ones(length(G_top),4);

T_NOCT (:,1) = T_NOCT (:,1) * mean(Tnt); % Average Temperature During Driving Cycle
T_NOCT (:,2) = T_NOCT (:,2) * mean(Tnb);
T_NOCT (:,3) = T_NOCT (:,3) * mean(Tnr);
T_NOCT (:,4) = T_NOCT (:,4) * mean(Tnl);

writematrix(T_NOCT, 'T_NOCT.xlsx');


%% Plot

subplot(4,1,1)

plot(Tft, 'LineWidth', 1, 'Color', 'b')

hold on

plot(Tnt, 'LineWidth', 1, 'Color', 'r')

title('Top', 'FontName', 'Times New Roman', 'FontSize', 14)
ylabel('T (°C)', 'FontName', 'Times New Roman', 'FontSize', 14)

legend({'Faiman', 'NOCT'});

xlim([1, length(G_top)]); % X-axis range
ylim([0, 50]); % Y-axis range

% Apply font to axis tick values
ax = gca; % Get current axes
ax.FontName = 'Times New Roman'; % Set font name for tick values
ax.FontSize = 14; % Set font size for tick values

grid on;

subplot(4,1,2)

plot(Tfb, 'LineWidth', 1, 'Color', 'b')

hold on

plot(Tnb, 'LineWidth', 1, 'Color', 'r')

title('Back', 'FontName', 'Times New Roman', 'FontSize', 14)
ylabel('T (°C)', 'FontName', 'Times New Roman', 'FontSize', 14)

xlim([1, length(G_top)]); % X-axis range
ylim([0, 50]); % Y-axis range

% Apply font to axis tick values
ax = gca; % Get current axes
ax.FontName = 'Times New Roman'; % Set font name for tick values
ax.FontSize = 14; % Set font size for tick values

grid on;

subplot(4,1,3)

plot(Tfr, 'LineWidth', 1, 'Color', 'b')

hold on

plot(Tnr, 'LineWidth', 1, 'Color', 'r')

title('Right', 'FontName', 'Times New Roman', 'FontSize', 14)
ylabel('T (°C)', 'FontName', 'Times New Roman', 'FontSize', 14)

xlim([1, length(G_top)]); % X-axis range
ylim([0, 50]); % Y-axis range

% Apply font to axis tick values
ax = gca; % Get current axes
ax.FontName = 'Times New Roman'; % Set font name for tick values
ax.FontSize = 14; % Set font size for tick values

grid on;

subplot(4,1,4)

plot(Tfl, 'LineWidth', 1, 'Color', 'b')

hold on

plot(Tnl, 'LineWidth', 1, 'Color', 'r')

title('Left', 'FontName', 'Times New Roman', 'FontSize', 14)
xlabel('Time (s)', 'FontName', 'Times New Roman', 'FontSize', 14)
ylabel('T (°C)', 'FontName', 'Times New Roman', 'FontSize', 14)

xlim([1, length(G_top)]); % X-axis range
ylim([0, 50]); % Y-axis range

% Apply font to axis tick values
ax = gca; % Get current axes
ax.FontName = 'Times New Roman'; % Set font name for tick values
ax.FontSize = 14; % Set font size for tick values

grid on;
