function Direct = Direct_Surface(DNI, surftilt, surfaz, sunzen, sunaz)

% AOI

[AOI] = pvl_getaoi(surftilt, surfaz, sunzen, sunaz);

teta = AOI*(pi/180);

for i = 1:length(teta)

Direct(i,1) = DNI(i).*cos(teta(i));

if Direct(i,1) < 0
    Direct(i,1) = 0;
end

end

end