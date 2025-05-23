% Irradiance

G_top = xlsread('G_top.xlsx'); % Irradince, Top Surface

G_back = xlsread('G_back.xlsx'); % Irradince, Back Surface

G_right = xlsread('G_right.xlsx'); % Irradince, Right Surface

G_left = xlsread('G_left.xlsx'); % Irradince, Left Surface

% Temperature

T_Faiman = xlsread('T_Faiman.xlsx'); % Average Temperature

%% Electrical

etaCo = 0.96; % Efficiency of the Power Converter
etaPV = 0.216; % Efficiency of the PV Module
kco = -0.0047; % Temperature Coefficient of the PV Module
T_ref = 25; % Reference Temperature

At = 7.218; % Area of the PV Array, Top Surface
Ab = 4.0278; % Area of the PV Array, Back Surface
Ar = 6.5565; % Area of the PV Array, Right Surface
Al = 8.1956; % Area of the PV Array, Left Surface

for i=1:length(G_top)

% Top 

    Wft(i,1) = etaCo * etaPV * At * G_top(i) * (1 + (kco * (T_Faiman(i,1) - T_ref)));

% Back 

    Wfb(i,1) = etaCo * etaPV * Ab * G_back(i) * (1 + (kco * (T_Faiman(i,2) - T_ref)));

% Right 

    Wfr(i,1) = etaCo * etaPV * Ar * G_right(i) * (1 + (kco * (T_Faiman(i,3) - T_ref)));

% Left 

    Wfl(i,1) = etaCo * etaPV * Al * G_left(i) * (1 + (kco * (T_Faiman(i,4) - T_ref)));
    
end

%% Plot

subplot(4,1,1)

plot(Wft, 'LineWidth', 1, 'Color', 'b')

title('Top', 'FontName', 'Times New Roman', 'FontSize', 14)
ylabel('E (W)', 'FontName', 'Times New Roman', 'FontSize', 14)

xlim([1, length(G_top)]); % X-axis range
ylim([0, 1000]); % Y-axis range

% Apply font to axis tick values
ax = gca; % Get current axes
ax.FontName = 'Times New Roman'; % Set font name for tick values
ax.FontSize = 14; % Set font size for tick values

grid on;

subplot(4,1,2)

plot(Wfb, 'LineWidth', 1, 'Color', 'b')

title('Back', 'FontName', 'Times New Roman', 'FontSize', 14)
ylabel('E (W)', 'FontName', 'Times New Roman', 'FontSize', 14)

xlim([1, length(G_top)]); % X-axis range
ylim([0, 1000]); % Y-axis range

% Apply font to axis tick values
ax = gca; % Get current axes
ax.FontName = 'Times New Roman'; % Set font name for tick values
ax.FontSize = 14; % Set font size for tick values

grid on;

subplot(4,1,3)

plot(Wfr, 'LineWidth', 1, 'Color', 'b')

title('Right', 'FontName', 'Times New Roman', 'FontSize', 14)
ylabel('E (W)', 'FontName', 'Times New Roman', 'FontSize', 14)

xlim([1, length(G_top)]); % X-axis range
ylim([0, 1000]); % Y-axis range

% Apply font to axis tick values
ax = gca; % Get current axes
ax.FontName = 'Times New Roman'; % Set font name for tick values
ax.FontSize = 14; % Set font size for tick values

grid on;

subplot(4,1,4)

plot(Wfl, 'LineWidth', 1, 'Color', 'b')

title('Left', 'FontName', 'Times New Roman', 'FontSize', 14)
xlabel('Time (s)', 'FontName', 'Times New Roman', 'FontSize', 14)
ylabel('E (W)', 'FontName', 'Times New Roman', 'FontSize', 14)

xlim([1, length(G_top)]); % X-axis range
ylim([0, 1000]); % Y-axis range

% Apply font to axis tick values
ax = gca; % Get current axes
ax.FontName = 'Times New Roman'; % Set font name for tick values
ax.FontSize = 14; % Set font size for tick values

grid on;