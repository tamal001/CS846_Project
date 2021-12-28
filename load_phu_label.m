function phu_label= load_phu_label(filename)
M = csvread(filename);
[~, c] = size(M);
phu_label = M;
min = 0;
max = 0;
for i = 1:c
    if phu_label(i) ~= 0
        phu_label(i) = log10(phu_label(i));
        if phu_label(i) > max
            max = phu_label(i);
        end
    end
end
scales = (max-min)/10;
for i = 1:c
    if phu_label(i) < scales
        phu_label(i) = 1;
    elseif phu_label(i) < scales *2
        phu_label(i) = 2;
    elseif phu_label(i) < scales *3
        phu_label(i) = 3;
    elseif phu_label(i) < scales *4
        phu_label(i) = 4;
        elseif phu_label(i) < scales *5
        phu_label(i) = 5;
        elseif phu_label(i) < scales *6
        phu_label(i) = 6;
        elseif phu_label(i) < scales *7
        phu_label(i) = 7;
        elseif phu_label(i) < scales *8
        phu_label(i) = 8;
        elseif phu_label(i) < scales *9
        phu_label(i) = 9;
    else
        phu_label(i) = 10;
    end
end
