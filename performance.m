%% Haversine Data

i1gn = [0.1092 0.1067 0.0916	0.0965 0.0901 0.9227 0.9004 0.9921 0.8740 0.8970];
i1gl = [0.0921	0.0970	0.1058	0.0928	0.1026	0.9329	0.9180	0.8828	0.8748	0.8737];
i1gc = [0.0927	0.0929	0.0952	0.1055	0.0998	0.9464	0.9020	0.8785	0.8989	0.8984];

i10gn = [0.1826	0.1923	0.1869	0.1675	0.1726	1.5796	1.4369	1.5470	1.5436	1.5332];
i10gl = [0.1870	0.1695	0.1805	0.1765	0.1621	1.7985	1.5295	1.4279	1.3908	1.4051];
i10gc = [0.1686	0.1662	0.1707	0.1643	0.1682	1.5159	1.4271	1.4095	1.4072	1.4120];

i50gn = [0.2223	0.2158	0.2082	0.2073	0.2064	1.6629	1.5418	1.5088	1.4903	1.5606];
i50gl = [0.2133 	0.2126	0.2101	0.2097	0.2123	1.6073	1.5667	1.5341	1.5067	1.5639];
i50gc = [0.2051	0.2099	0.2091	0.2174	0.2131	1.5833	1.5433	1.4883	1.4824	1.5597];

i100gn = [0.2690	0.2653	0.2619	0.2625	0.2662	1.5759	1.6611	1.5162	1.5361	1.5244];
i100gl = [0.2764	0.2826	0.2539	0.2708	0.2745	1.5817	1.6787	1.5785	1.5692	1.5848];
i100gc = [0.2628	0.2708	0.2842	0.2722	0.2755	1.7226	1.5430	1.5106	1.6775	1.4751];

i200gn = [0.3739	0.3631	0.3696	0.3678	0.3803	1.7157	1.5499	1.5890	1.5931	1.6059];
i200gl = [0.3883	0.3809	0.3708	0.3860	0.3702	1.6217	1.6118	1.6006	1.5730	1.7670];
i200gc = [0.3848	0.3795	0.3785	0.3724	0.3742	1.6205	1.6186	1.6296	1.5370	1.5305];

i500gn = [0.7353	0.7409	0.7165	0.7425	0.7197	1.7466	1.8314	1.8111	1.7186	1.7770];
i500gl = [0.7662	0.7397	0.7528	0.7333	0.7269	2.0991	1.8149	1.7127	1.7103	1.7650];
i500gc = [0.8278	0.7379	0.7523	0.7503	0.7456	1.7537	1.6653	1.7491	1.7580	1.7831];

i750gn = [1.0907	1.0970	1.0402	1.0286	1.0339	1.8628	1.9317	1.8657	1.9137	1.8495];
i750gl = [1.0690	1.0590	1.0311	1.0404	1.0276	1.7581	1.8766	1.7889	1.9004	1.7866];
i750gc = [1.1383	1.1019	1.1001	1.0706	1.0730	1.9976	1.9241	1.8470	1.8350	1.8640];

i1000gn = [1.5726	1.5346	1.5620	1.5839	1.5887	1.9623	1.9264	1.9086	1.9432	1.9355];
i1000gl = [1.6389	1.5223	1.5460	1.5948	1.5672	2.0040	1.8989	1.9096	1.9101	1.9451];
i1000gc = [1.4126	1.4505	1.5869	1.6410	1.6406	1.9420	1.9641	1.9632	1.9080	1.9452];

i1550gn = [2.0370	2.0581	1.9816	2.0002	2.0149	2.3793	2.2156	2.2775	2.2246	2.2150];
i1550gl = [2.1529	2.0541	2.0146	2.0316	2.3672	2.3319	2.2713	2.2899	2.2790	2.2651];
i1550gc = [2.1084	2.0772	2.0114	2.0766	2.2406	2.2961	2.2742	2.2515	2.2833	2.2698];

%% Vincenty Data

i1vn = [0.1237	0.1169	0.1126	0.1115	0.1196	0.9339	0.9072	0.9511	0.9159	0.9117];
i1vl = [0.1298	0.1246	0.1143	0.1235	0.1149	0.9875	0.9303	0.9076	0.9199	0.9066];
i1vc = [0.1146	0.1330	0.1180	0.1176	0.1199	1.0015	0.9315	0.9221	0.9178	0.9153];

i10vn = [0.2236	0.2200	0.2464	0.2383	0.2324	1.5830 	1.5479	1.5274	1.5022	1.4784];
i10vl = [0.2196	0.2295	0.2305	0.2447	0.2228	1.5216	1.4942	1.4905	1.5959	1.5327];
i10vc = [0.2298	0.2319	0.2141	0.2179	0.2264	1.5612	1.6006	1.5021	1.5060	1.5566];

i50vn = [0.2680	0.2738	0.2719	0.2789	0.2819	1.7575	1.7767	1.7066	1.6833	1.9605];
i50vl = [0.2827	0.2835	0.2726	0.2746	0.2750	1.7273	1.6006	1.7433	1.6220	1.6420];
i50vc = [0.3049	0.2804	0.2913	0.2720	0.2894	1.6997	1.5778	1.6190	1.6493	1.6741];

i100vn = [0.3772	0.3389	0.3453	0.3390	0.3383	1.6950	1.7234	1.8223	1.6285	1.6861];
i100vl = [0.3536	0.3417	0.3411	0.3492	0.3568	1.9594	1.6193	1.6525	1.6625	1.6078];
i100vc = [0.3868	0.3612	0.3433	0.3566	0.3401	1.6741	1.6439	1.6581	1.6172	1.7096];

i200vn = [0.4807	0.5043	0.4793	0.4937	0.5136	1.7510	1.6827	1.7133	1.7028	1.6948];
i200vl = [0.4816	0.5195	0.4836	0.5199	0.4921	1.8166	1.6349	1.6877	1.7516	1.7061];
i200vc = [0.5189	0.4984	0.4881	0.4993	0.4952	1.7265	1.8809	1.7838	1.6691	1.7171];

i500vn = [0.9293	0.9952	0.9301	0.9247	0.9323	1.8843	1.8476	1.8312	1.8872	1.8835];
i500vl = [1.0819	1.0243	0.9771	0.9283	0.9664	1.8819	1.8683	1.8399	1.9372	1.8211];
i500vc = [1.0062	0.9750	0.9428	0.9494	0.9509	1.9963	1.8485	1.8309	1.8894	1.9124];

i750vn = [1.2772	1.2664	1.2909	1.3029	1.3121	2.0436	1.9677	2.0233	2.0206	2.0059];
i750vl = [1.4158	1.3771	1.3907	1.3309	1.3142	2.0273	2.0926	1.9777	1.9795	2.0152];
i750vc = [1.4961	1.3458	1.3374	1.3773	1.3849	2.0956	2.0622	2.0002	2.0865	2.0993];

i1000vn = [1.6745	1.7150	1.7338	1.7587	1.7163	2.3644	2.1927	2.2227	2.2284	2.2891];
i1000vl = [1.6848	1.7419	1.7851	1.7059	1.7481	2.1947	2.2121	2.2009	2.1579	2.1332];
i1000vc = [1.7183	1.7795	1.8248	1.7333	1.7514	2.2356	2.1951	2.1888	2.2039	2.2167];

i1550vn = [2.4332	2.4392	2.5547	2.5094	2.5282	2.5285	2.5784	2.4660	2.5071	2.6538];
i1550vl = [2.4349	2.4843	2.5397	2.5149	2.4890	2.5481	2.6099	2.5859	2.4979	2.5002];
i1550vc = [2.5890	2.5325	2.5688	2.6835	2.5717	2.6984	2.6692	2.6641	2.5750	2.5633];

%% Find means

% Haversine

m1gn = mean(i1gn(1:5));
m10gn = mean(i10gn(1:5));
m50gn = mean(i50gn(1:5));
m100gn = mean(i100gn(1:5));
m200gn = mean(i200gn(1:5));
m500gn = mean(i500gn(1:5));
m750gn = mean(i750gn(1:5));
m1000gn = mean(i1000gn(1:5));
m1550gn = mean(i1550gn(1:5));

m1gl = mean(i1gl(1:5));
m10gl = mean(i10gl(1:5));
m50gl = mean(i50gl(1:5));
m100gl = mean(i100gl(1:5));
m200gl = mean(i200gl(1:5));
m500gl = mean(i500gl(1:5));
m750gl = mean(i750gl(1:5));
m1000gl = mean(i1000gl(1:5));
m1550gl = mean(i1550gl(1:5));

m1gc = mean(i1gc(1:5));
m10gc = mean(i10gc(1:5));
m50gc = mean(i50gc(1:5));
m100gc = mean(i100gc(1:5));
m200gc = mean(i200gc(1:5));
m500gc = mean(i500gc(1:5));
m750gc = mean(i750gc(1:5));
m1000gc = mean(i1000gc(1:5));
m1550gc = mean(i1550gc(1:5));

% Haversine parallel

m1gnp = mean(i1gn(6:10));
m10gnp = mean(i10gn(6:10));
m50gnp = mean(i50gn(6:10));
m100gnp = mean(i100gn(6:10));
m200gnp = mean(i200gn(6:10));
m500gnp = mean(i500gn(6:10));
m750gnp = mean(i750gn(6:10));
m1000gnp = mean(i1000gn(6:10));
m1550gnp = mean(i1550gn(6:10));

m1glp = mean(i1gl(6:10));
m10glp = mean(i10gl(6:10));
m50glp = mean(i50gl(6:10));
m100glp = mean(i100gl(6:10));
m200glp = mean(i200gl(6:10));
m500glp = mean(i500gl(6:10));
m750glp = mean(i750gl(6:10));
m1000glp = mean(i1000gl(6:10));
m1550glp = mean(i1550gl(6:10));

m1gcp = mean(i1gc(6:10));
m10gcp = mean(i10gc(6:10));
m50gcp = mean(i50gc(6:10));
m100gcp = mean(i100gc(6:10));
m200gcp = mean(i200gc(6:10));
m500gcp = mean(i500gc(6:10));
m750gcp = mean(i750gc(6:10));
m1000gcp = mean(i1000gc(6:10));
m1550gcp = mean(i1550gc(6:10));

% Vincenty

m1vn = mean(i1vn(1:5));
m10vn = mean(i10vn(1:5));
m50vn = mean(i50vn(1:5));
m100vn = mean(i100vn(1:5));
m200vn = mean(i200vn(1:5));
m500vn = mean(i500vn(1:5));
m750vn = mean(i750vn(1:5));
m1000vn = mean(i1000vn(1:5));
m1550vn = mean(i1550vn(1:5));

m1vl = mean(i1vl(1:5));
m10vl = mean(i10vl(1:5));
m50vl = mean(i50vl(1:5));
m100vl = mean(i100vl(1:5));
m200vl = mean(i200vl(1:5));
m500vl = mean(i500vl(1:5));
m750vl = mean(i750vl(1:5));
m1000vl = mean(i1000vl(1:5));
m1550vl = mean(i1550vl(1:5));

m1vc = mean(i1vc(1:5));
m10vc = mean(i10vc(1:5));
m50vc = mean(i50vc(1:5));
m100vc = mean(i100vc(1:5));
m200vc = mean(i200vc(1:5));
m500vc = mean(i500vc(1:5));
m750vc = mean(i750vc(1:5));
m1000vc = mean(i1000vc(1:5));
m1550vc = mean(i1550vc(1:5));

% Vincenty parallel

m1vnp = mean(i1vn(6:10));
m10vnp = mean(i10vn(6:10));
m50vnp = mean(i50vn(6:10));
m100vnp = mean(i100vn(6:10));
m200vnp = mean(i200vn(6:10));
m500vnp = mean(i500vn(6:10));
m750vnp = mean(i750vn(6:10));
m1000vnp = mean(i1000vn(6:10));
m1550vnp = mean(i1550vn(6:10));

m1vlp = mean(i1vl(6:10));
m10vlp = mean(i10vl(6:10));
m50vlp = mean(i50vl(6:10));
m100vlp = mean(i100vl(6:10));
m200vlp = mean(i200vl(6:10));
m500vlp = mean(i500vl(6:10));
m750vlp = mean(i750vl(6:10));
m1000vlp = mean(i1000vl(6:10));
m1550vlp = mean(i1550vl(6:10));

m1vcp = mean(i1vc(6:10));
m10vcp = mean(i10vc(6:10));
m50vcp = mean(i50vc(6:10));
m100vcp = mean(i100vc(6:10));
m200vcp = mean(i200vc(6:10));
m500vcp = mean(i500vc(6:10));
m750vcp = mean(i750vc(6:10));
m1000vcp = mean(i1000vc(6:10));
m1550vcp = mean(i1550vc(6:10));


%% Bar Charts

% Plot vars

xvals = [1 10 50 100 200 500 750 1000 1550];
xvalsx = [1 10 50 100 200 500 750 1000 1550 1750 2000 2500];
x = {'1' ,'10', '50' ,'100', '200', '500', '750', '1000', '1550'};

gnvals = [m1gn m1gl m1gc;m10gn m10gl m10gc;m50gn m50gl m50gc; ...
        m100gn m100gl m100gc;m200gn m200gl m200gc;m500gn m500gl m500gc;...
        m750gn m750gl m750gc;m1000gn m1000gl m1000gc;m1550gn m1550gl m1550gc];
    
gpvals = [m1gnp m1glp m1gcp;m10gnp m10glp m10gcp;m50gnp m50glp m50gcp; ...
        m100gnp m100glp m100gcp;m200gnp m200glp m200gcp;m500gnp m500glp m500gcp;...
        m750gnp m750glp m750gcp;m1000gnp m1000glp m1000gcp;m1550gnp m1550glp m1550gcp];
    
vnvals = [m1vn m1vl m1vc;m10vn m10vl m10vc;m50vn m50vl m50vc; ...
        m100vn m100vl m100vc;m200vn m200vl m200vc;m500vn m500vl m500vc;...
        m750vn m750vl m750vc;m1000vn m1000vl m1000vc;m1550vn m1550vl m1550vc];
    
vpvals = [m1vnp m1vlp m1vcp;m10vnp m10vlp m10vcp;m50vnp m50vlp m50vcp; ...
        m100vnp m100vlp m100vcp;m200vnp m200vlp m200vcp;m500vnp m500vlp m500vcp;...
        m750vnp m750vlp m750vcp;m1000vnp m1000vlp m1000vcp;m1550vnp m1550vlp m1550vcp];    

ygn = gnvals(:,3).'; 
ygp = gpvals(:,3).';
yvn = vnvals(:,3).';
yvp = vpvals(:,3).';

%Interpolation

fgn = polyfit(xvals,ygn,2);
fgp = polyfit(xvals,ygp,2);    
fvn = polyfit(xvals,yvn,2);
fvp = polyfit(xvals,yvp,2);

yfgn = polyval(fgn,xvalsx);
yfgp = polyval(fgp,xvalsx);
yfvn = polyval(fvn,xvalsx);
yfvp = polyval(fvp,xvalsx);

% % Haversine Normal
% 
% figure('Color','white');    
% b = bar(gnvals,'FaceColor','flat');
% grid on
% 
% % Labels
% set(gca,'xticklabel',x);
% xlabel('Number of Pairs');
% ylabel('Profile Extraction Time (s)');
% title('Haversine Method Profile Extraction Time');
% legend({'Nearest Neighbour','Linear','Cubic'},'Location','northwest')
% 
% %Colours
% b(1).FaceColor = [0 0.4470 0.7410];
% b(2).FaceColor = [0.3010 0.7450 0.9330];
% b(3).FaceColor = [.1 .6 .6];
% 
% % Haversine Parallel
% 
% figure('Color','white');    
% b = bar(gpvals,'FaceColor','flat');
% grid on
% 
% % Labels
% set(gca,'xticklabel',x);
% xlabel('Number of Pairs');
% ylabel('Profile Extraction Time (s)');
% title('Parallelized Haversine Method Profile Extraction Time');
% legend({'Nearest Neighbour','Linear','Cubic'},'Location','northwest')
% 
% %Colours
% b(1).FaceColor = [0 0.4470 0.7410];
% b(2).FaceColor = [0.3010 0.7450 0.9330];
% b(3).FaceColor = [.1 .6 .6];
% 
% % Vincenty Normal
% figure('Color','white');    
% bv = bar(vnvals,'FaceColor','flat');
% grid on
% 
% % Labels
% set(gca,'xticklabel',x);
% xlabel('Number of Pairs');
% ylabel('Profile Extraction Time (s)');
% title('Vincenty Method Profile Extraction Time');
% legend({'Nearest Neighbour','Linear','Cubic'},'Location','northwest')
% 
% %Colours
% bv(1).FaceColor = [0 0.4470 0.7410];
% bv(2).FaceColor = [0.3010 0.7450 0.9330];
% bv(3).FaceColor = [.1 .6 .6];
% 
% 
% % Vincenty Parallel
% figure('Color','white');    
% bv = bar(vpvals,'FaceColor','flat');
% grid on
% 
% % Labels
% set(gca,'xticklabel',x);
% xlabel('Number of Pairs');
% ylabel('Profile Extraction Time (s)');
% title('Parallelized Vincenty Method Profile Extraction Time');
% legend({'Nearest Neighbour','Linear','Cubic'},'Location','northwest')
% 
% %Colours
% bv(1).FaceColor = [0 0.4470 0.7410];
% bv(2).FaceColor = [0.3010 0.7450 0.9330];
% bv(3).FaceColor = [.1 .6 .6];


%% Line Charts (parallel)

figure('Color','white');

p = plot(xvalsx, yfgn, xvalsx, yfgp, xvalsx, yfvn, xvalsx, yfvp, 'LineWidth', 2);
grid on

set(p(1), 'color', [.7 0.5 0.9]);
set(p(2), 'color', [1 0.5 0.7]);
set(p(3), 'color', [0.1 0.8 0.9]); 
set(p(4), 'color', [0.2 0.8 0.7]);

xlabel('Number of Pairs');
ylabel('Profile Extraction Time (s)');
title('Comparison of Profile Extraction Times');
legend({'Haversine','Parallel Haversine','Vincenty','Parallel Vincenty'},...
       'Location','northwest');










