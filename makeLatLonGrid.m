%% Azimuthal Equidistant

lat0 = 0;
lon0 = 0;

m.lat = -90:90;
m.lon = (-180:15:180)';
[m.lon, m.lat] = meshgrid(m.lon, m.lat);
[m.x, m.y] = flatmap.project.azimuthalEquidistant(m.lat, m.lon, lat0, lon0, 1);

p.lat = (-90:15:90)';
p.lon = -180:180;
[p.lat, p.lon] = meshgrid(p.lat, p.lon);
[p.x, p.y] = flatmap.project.azimuthalEquidistant(p.lat, p.lon, lat0, lon0, 1);

figure
plot(m.x, m.y, 'k')
hold on
plot(p.x, p.y, 'r')
