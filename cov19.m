%% VISUALIZATION NUMBER OF SICK DUE TO COV-19

clear
close all

%% PARAMETER TANGGAL
d1 = '01 Mar 2020';   % hari ke-0 covid muncul di indo
d2 = '18 Jun 2020';   % hari peak of new cases of covid di indo
d6 = '18 Jun 2020';   % hari ini hehe
dForm = 'dd mmm yyyy';
t = abs(datenum(d1,dForm) - datenum(d2,dForm)); 

%% GRAFIK INFECTED CASES
a = 0.11017; %% y = (a) x^(b) BENTUK UMUM DARI EXPONEN
b = 2.76108;
m = ((a)*t.^(b)); % mencari m (salah satu parameter transformasi)
x1a = [1:1:t];
x1c = [t:1:2*t];
y1a = a*x1a.^(b); %grafik origin
y1c = (2*m)-a*((2*t)-x1c).^(b); %% y1 dicerminkan 2x, kesamping dan ke atas 
y1aEnd = a*t.^(b); %ini berguna buat menentukan titik pencerminan grafik solved

%% GRAFIK SOLVED CASES
c = 0.00139; %% y = (c) x^(d) BENTUK UMUM DARI EXPONEN
d = 3.49565;
y2a = c*x1a.^(d);                   % Grafik bagian 1
t2b = ((y1aEnd/c).^(1/d)); % nyari waktu dimana mencapai titik balik global
x2b = [t:1:t2b];
y2b = c*x2b.^(d);
t4 = 2*t2b;
x2c = [t2b:1:(t4)];
y2c = (2*m) - (c*((t4)-x2c).^(d));

%% GRAFIK EXTENDED INFECTED CASES
x6 = [2*t:1:t4];
y6 = m*2;

%% PENGGAMBARAN
hold on;
plot(x1a,y1a);  % mencetak grafik origin
hold on;
plot(x1c,y1c);  % mencetak grafik origin kebalik
hold on;

plot(x1a,y2a);  % mencetak grafik solved
hold on;
plot(x2b,y2b);  % grafik solved interpolated
hold on;
plot(x2c,y2c);  % grafik solved terbalik
    positivePeak = max(y2c);

hold on;

plot(x6,y6);    % extended linear grafik infected case
hold on;

plot(x1a,(y1a-y2a));        % grafik sick a
hold on;

    y1cNew = (2*m)-a*((2*t)-x2b).^(b);      % grafik y1c khusus buat pengurangan
    yPeak = y1cNew-y2b;
    plot(x2b,yPeak);                     % grafik sick b
    
    sickPeak = max(yPeak);
    indexPeak = find (yPeak == sickPeak);
    d3 = x2b(indexPeak); % hari infected peak
 %{  
    R = (yPeak(indexPeak)/yPeak(indexPeak-14));
    i = indexPeak;
    disp(indexPeak);
    while R>1
        i = i + 1;
        R = (yPeak(i)/yPeak(i-14));
    end
    disp(R);
    disp(i);
   
    d4 = d3 + i;              % hari ke PSBB kelar
%}
  
hold on;

    x2cNew = [t2b:1:2*t];                   %x2c khusus untuk pengurangan
    y1cNew2 = (2*m)-a*((2*t)-x2cNew).^(b);  % grafik y1c khusus buat pengurangan
    y2cNew2 = (2*m) - (c*((t4)-x2cNew).^(d));

plot(x2cNew,(y1cNew2-y2cNew2));             % grafik sick c 
hold on;

    y2cNew3 = (2*m) - (c*((t4)-x6).^(d));

plot(x6,(y6-y2cNew3));

    infMin = min(y6-y2cNew3);
    indexInfMin = find((y6-y2cNew3) == infMin);
    d5 = x6(indexInfMin); % hari inf Min

hold on;

%% NGEPRINT TANGGAL
format shortG

disp('-------------------------------------------');
disp('  PREDIKSI PRIMANTA TENTANG COVID DI INDO  ');
disp('-------------------------------------------');

fprintf('Hari ini       --> '); disp(d6);
fprintf('Puncak Active  --> '); disp(datestr((d3+datenum(d1,dForm)),dForm));
%fprintf('Akhir Lockdown --> '); disp(datestr((d3+datenum(d1,dForm)),dForm));
fprintf('Akhir COVID    --> '); disp(datestr((d5+datenum(d1,dForm)),dForm));
fprintf('\n');
fprintf('Jumlah active cases maksimal  '); disp(sickPeak);
fprintf('Jumlah positive cases maksimal'); disp(positivePeak);
disp('nb:');
disp('mekanisme perhitungan ini hanyalah prediksi');
disp('         kritik dan saran sangat diharapkan');
disp('-------------------------------------------');

%% END OF CODE -----------------------------------------------------------

%{    
date3 = datenum(d1,dForm)+d3;
    fullDate3 = datestr(d3,dForm);
    disp(date3);
    disp(fullDate3);
%}