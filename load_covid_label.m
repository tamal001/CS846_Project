function phu_label= load_covid_label(filename)
M = csvread(filename);
%[~, c] = size(M);
phu_label = M;