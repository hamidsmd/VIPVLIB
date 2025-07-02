%% Location

Loc = xlsread('Data/Location.xlsx'); % Location: Latitude, Longitude
Location.latitude = Loc(:,1);
Location.longitude = Loc(:,2);

%% Azimuth

Azimuth = xlsread('Data/Azimuth.xlsx'); % Azimuth: Top, Back, Right, Left Surfaces

%% Time

Tim = xlsread('Data/Time.xlsx'); % Time: Year, Month, Day, Hour, Minute, Second, UTC Offset

Time.year = Tim(:,1);
Time.month = Tim(:,2);
Time.day = Tim(:,3);
Time.hour = Tim(:,4);
Time.minute = Tim(:,5);
Time.second = Tim(:,6);

Time.UTCOffset = Tim(:,7); % UTC 

% For DOY

Year = Time.year;
Month = Time.month;
Day = Time.day;

%% Meteorological

% P, T

Pressure = xlsread('Data/Pressure.xlsx');

Temperature = xlsread('Data/Temperature.xlsx');

% GHI, DNI, DHI

Irr = xlsread('Data/Irradiance.xlsx');

GHI = Irr(:,1);

DNI = Irr(:,2);

DHI = Irr(:,3);

%% PVLIB

addpath('Functions\');

[doy] = pvl_date2doy(Year, Month, Day); % Day of year

[Ea] = pvl_extraradiation(doy); % Extraterrestrial normal irradiance

[SunAz, ApparentSunEl] = pvl_ephemeris(Time, Location, Pressure, Temperature); % Solar Position
sunaz = SunAz;

HExtra = Ea ; % Extraterrestrial normal irradiance

z = 90 - ApparentSunEl; % Apparent zenith
sunzen = z;
SunZen = z;

[AM] = pvl_relativeairmass(z); % Relative airmass

%% Top surface

% Direct

surftilt = zeros(length(Azimuth),1);
surfaz = Azimuth(:,1);

[Direct] = Direct_Surface(DNI, surftilt, surfaz, sunzen, sunaz);

DNIt = Direct;

% Diffuse

SurfTilt = zeros(length(Azimuth),1);
SurfAz = Azimuth(:,1);

[SkyDiffuse] = pvl_perez(SurfTilt, SurfAz, DHI, DNI, HExtra, SunZen, SunAz, AM);

DHIt = SkyDiffuse;

%% Back surface

% Direct

surftilt = ones(length(Azimuth),1)*90;
surfaz = Azimuth(:,2);

[Direct] = Direct_Surface(DNI, surftilt, surfaz, sunzen, sunaz);

DNIb = Direct;

% Diffuse

SurfTilt = ones(length(Azimuth),1)*90;
SurfAz = Azimuth(:,2);

[SkyDiffuse] = pvl_perez(SurfTilt, SurfAz, DHI, DNI, HExtra, SunZen, SunAz, AM);

DHIb = SkyDiffuse;

%% Right surface

% Direct

surftilt = ones(length(Azimuth),1)*90;
surfaz = Azimuth(:,3);

[Direct] = Direct_Surface(DNI, surftilt, surfaz, sunzen, sunaz);

DNIr = Direct;

% Diffuse

SurfTilt = ones(length(Azimuth),1)*90;
SurfAz = Azimuth(:,3);

[SkyDiffuse] = pvl_perez(SurfTilt, SurfAz, DHI, DNI, HExtra, SunZen, SunAz, AM);

DHIr = SkyDiffuse;

%% Left surface

% Direct

surftilt = ones(length(Azimuth),1)*90;
surfaz = Azimuth(:,4);

[Direct] = Direct_Surface(DNI, surftilt, surfaz, sunzen, sunaz);

DNIl = Direct;

% Diffuse

SurfTilt = ones(length(Azimuth),1)*90;
SurfAz = Azimuth(:,4);

[SkyDiffuse] = pvl_perez(SurfTilt, SurfAz, DHI, DNI, HExtra, SunZen, SunAz, AM);

DHIl = SkyDiffuse;

%% GHI Total

etaShade = 0.75; % Shading effiency
CFF = 0.9; % Curve Correction Factor

G_top = ((DNIt*etaShade)+DHIt)*CFF;
writematrix(G_top, 'G_top.xlsx');

G_back = ((DNIb*etaShade)+DHIb)*CFF;
writematrix(G_back, 'G_back.xlsx');

G_right = ((DNIr*etaShade)+DHIr)*CFF;
writematrix(G_right, 'G_right.xlsx');

G_left = ((DNIl*etaShade)+DHIl)*CFF;
writematrix(G_left, 'G_left.xlsx');

%% Plot

subplot(4,1,1)

plot(G_top, 'LineWidth', 1, 'Color', 'b')

title('Top', 'FontName', 'Times New Roman', 'FontSize', 14)
ylabel('G (W/m^2)', 'FontName', 'Times New Roman', 'FontSize', 14)

xlim([1, length(Azimuth)]); % X-axis range
ylim([0, 800]); % Y-axis range

% Apply font to axis tick values
ax = gca; % Get current axes
ax.FontName = 'Times New Roman'; % Set font name for tick values
ax.FontSize = 14; % Set font size for tick values

grid on;

subplot(4,1,2)

plot(G_back, 'LineWidth', 1, 'Color', 'b')

title('Back', 'FontName', 'Times New Roman', 'FontSize', 14)
ylabel('G (W/m^2)', 'FontName', 'Times New Roman', 'FontSize', 14)

xlim([1, length(Azimuth)]); % X-axis range
ylim([0, 800]); % Y-axis range

% Apply font to axis tick values
ax = gca; % Get current axes
ax.FontName = 'Times New Roman'; % Set font name for tick values
ax.FontSize = 14; % Set font size for tick values

grid on;

subplot(4,1,3)

plot(G_right, 'LineWidth', 1, 'Color', 'b')

title('Right', 'FontName', 'Times New Roman', 'FontSize', 14)
ylabel('G (W/m^2)', 'FontName', 'Times New Roman', 'FontSize', 14)

xlim([1, length(Azimuth)]); % X-axis range
ylim([0, 800]); % Y-axis range

% Apply font to axis tick values
ax = gca; % Get current axes
ax.FontName = 'Times New Roman'; % Set font name for tick values
ax.FontSize = 14; % Set font size for tick values

grid on;

subplot(4,1,4)

plot(G_left, 'LineWidth', 1, 'Color', 'b')

title('Left', 'FontName', 'Times New Roman', 'FontSize', 14)
xlabel('Time (s)', 'FontName', 'Times New Roman', 'FontSize', 14)
ylabel('G (W/m^2)', 'FontName', 'Times New Roman', 'FontSize', 14)

xlim([1, length(Azimuth)]); % X-axis range
ylim([0, 800]); % Y-axis range

% Apply font to axis tick values
ax = gca; % Get current axes
ax.FontName = 'Times New Roman'; % Set font name for tick values
ax.FontSize = 14; % Set font size for tick values

grid on;
