%% VISUALIZATION REMARKABLE DATE AND NUMBER OF SICK DUE TO COV-19 %%
%% ----- untuk kalangan sendiri ----- %%

clear
close all

%% PARAMETER TANGGAL
d1 = '01Mar2020'; %% hari ke-0 covid muncul di indo
d2 = '17Apr2020'; %% hari peak of new cases of covid di indo
dForm = 'ddmmmyyyy';
t = abs(datenum(d1,dForm) - datenum(d2,dForm));

%% GRAFIK INFECTED CASES
a = 0.1069; %% y = (a) x^(b) BENTUK UMUM DARI EXPONEN
b = 2.7638;
m = ((a)*t.^(b)); % mencari m (salah satu parameter transformasi)
x1a = [1:1:t];
x1c = [t:1:2*t];
y1a = a*x1a.^(b); %grafik origin
y1c = (2*m)-a*((2*t)-x1c).^(b); %% y1 dicerminkan 2x, kesamping dan ke atas 
y1aEnd = a*t.^(b); %ini berguna buat menentukan titik pencerminan grafik solved

%% GRAFIK SOLVED CASES
c = 0.0009; %% y = (c) x^(d) BENTUK UMUM DARI EXPONEN
d = 3.64061;
y2a = c*x1a.^(d);
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
plot(x1a,y1a);      % mencetak grafik origin
hold on;
plot(x1c,y1c);      % mencetak grafik origin kebalik
hold on;
plot(x1a,y2a);      % mencetak grafik solved
hold on;
plot(x2b,y2b);      % grafik solved interpolated
hold on;
plot(x2c,y2c);      % grafik solved terbalik
hold on;
plot(x6,y6);        % extended linear grafik infected case
hold on;

plot(x1a,(y1a-y2a));    % grafik sick a
hold on;

    y1cNew = (2*m)-a*((2*t)-x2b).^(b); % grafik y1c khusus buat pengurangan
plot(x2b,(y1cNew-y2b));    % grafik sick b
hold on;
    
    x2cNew = [t2b:1:2*t]; %x2c khusus untuk pengurangan
    y1cNew2 = (2*m)-a*((2*t)-x2cNew).^(b); % grafik y1c khusus buat pengurangan
    y2cNew2 = (2*m) - (c*((t4)-x2cNew).^(d));
plot(x2cNew,(y1cNew2-y2cNew2));    % grafik sick c 
hold on;

    y2cNew3 = (2*m) - (c*((t4)-x6).^(d));
plot(x6,(y6-y2cNew3));
hold on;

% END OF CODE -----------------------------------------------------------------


%{
plot (x5a,y5a);
hold on;
plot (x5b,y5b);
hold on;
plot (x5c,y5c);
hold on;
%}

%{
%% GRAFIK CURED CASES
e = 0.0011;
f = 3.3418;

x5a = [1:1:t]; %domain waktu dari awal sampai titik balik global
y5a = e*x5a.^(f); %fungsi grafik cured naik

t5b = ((y2b/e).^(1/f)); %titik dimana grafik mesti membalik
t5bTuned = t5b + (0.57); %ditune dulu soalnya biasanya ada ketidaktelitian
x5b = [t:1:t5bTuned]; %batas waktunya
y5b = e*x5b.^(f); %grafiknya
%{
t5c = 2*t5b;
x5c = [t5b:1:(t5c)];
y5c = 2*m - (e*((2*t5b)-x5c).^(f));
%}

%}

%{
  disp('JADI, Covid mungkin paling cepet kelar tanggal');
  disp(d3);
  disp('MUNGKIN, hehe');
%}
