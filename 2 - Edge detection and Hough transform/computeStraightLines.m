% Marco Demutti
% 4389233
% Matteo Dicenzi
% 4342944

% The function finds and displays the straight lines in an image
% Input: edge map BW, peaks matrix P, theta T, rho R, grayscale image, and
% parameters for 'houghlines' function

function computeStraightLines(BW,P,T,R,img,fillGap,minLength)

[rr,cc]=size(img);
figure,subplot(2,1,1),imagesc(BW),title("Straight lines with fillgap = "+fillGap+" and minLength = "+ minLength),
hold on

for k=1:length(P)
    if T(P(k,2))>-45 && T(P(k,2))<45
        x1=R(P(k,1))/cos(deg2rad(T(P(k,2)))) - 1*tan(deg2rad(T(P(k,2))));
        x2=R(P(k,1))/cos(deg2rad(T(P(k,2)))) - cc*tan(deg2rad(T(P(k,2))));
        plot([x1,x2],[1 cc],'LineWidth',2,'Color','yellow');
    else
        y1=R(P(k,1))/sin(deg2rad(T(P(k,2)))) - 1/tan(deg2rad(T(P(k,2))));
        y2=R(P(k,1))/sin(deg2rad(T(P(k,2)))) - rr/tan(deg2rad(T(P(k,2))));
        plot([1,rr],[y1 y2],'LineWidth',2,'Color','red');
    end
end

% Find line segments and plot them
lines = houghlines(BW,T,R,P,'FillGap',fillGap,'MinLength',minLength);
subplot(2,1,2),imshow(uint8(img)),title("Line segments with fillgap = "+fillGap+" and minLength = "+ minLength),
hold on
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
end
end