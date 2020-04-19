function [R_map, corner_reg] = corner_detection(Sx2, Sxy, Sy2)

[rr,cc]=size(Sx2);
corner_reg = zeros(rr,cc);
R_map = zeros(rr,cc); %R_map colorness map
k = 0.05;

for ii=1:rr
    for jj=1:cc
        % define at each pixel x,y the matrix M
        M = [Sx2(ii,jj), Sxy(ii,jj); Sxy(ii,jj), Sy2(ii,jj)];
        % compute the response of the detector at each pixel
        R = det(M) - k*(trace(M).^2);
        R_map(ii,jj) = R;
    end
end

% Compute max value of R map
M = max(R_map, [], 'all');

% Threshold for the corner regions using M
for ii=1:rr
    for jj=1:cc
        if R_map(ii,jj) > 0.3*M
            corner_reg(ii,jj) = 1;
        end
    end
end

end