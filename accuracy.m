%% Accuracy Performance

% Google Maps

gms = 1540;
gml = 77380;

vsc = 1543.26353302214;
vsl = 1543.26353302214;
vsn = 1543.26353302214;

vlc = 77234.2429423838;
vll = 77234.2429423838;
vln = 77234.2429423838;

hsc = 1546.23561003113;
hsl = 1546.23561003113;
hsn = 1546.23561003113;

hlc = 77384.4461047293;
hll = 77384.4461047293;
hln = 77384.4461047293;

fsc = 1543.14641977403;
fsl = 1543.14641977403;
fsn = 1543.14641977403;

flc = 77228.5570718058;
fll = 77228.5570718058;
fln = 77228.5570718058;

%% Accuracy calc.

avsc = abs(((vsc-gms)/gms))*100;

avlc = abs(((vlc-gml)/gml))*100;

ahsc = abs(((hsc-gms)/gms))*100;

ahlc = abs(((hlc-gml)/gml))*100;

afsc = abs(((fsc-gms)/gms))*100;

aflc = abs(((flc-gml)/gml))*100;

%% Bar

x = {'Vincenty' ,'Haversine' ,'Flat Earth'};
y = [avsc avlc; ahsc ahlc; afsc aflc];

figure('Color','white');    
b = bar(y,'FaceColor','flat');
grid on

% Labels
set(gca,'xticklabel',x);
xlabel('Geographic Approximation Method');
ylabel('Percentage Error (%)');
title('Distance Error for Distance and Method Combinations');
legend({'Long Distance','Short Distance'})

%Colours
b(1).FaceColor = [0 1 0.8];
b(2).FaceColor = [.2 .8 .7];


