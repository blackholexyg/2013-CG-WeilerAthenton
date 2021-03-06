%% by GUANG
% 2013.6.11

function [flag]= judgeinout( P ,Polygon,Clipwin,i,j)
% Judge whether the point is in-point or out-point
% Move the intersection point clock-wise, if the moved point is in the
% polygon, then in-point, othterwise out-point
% naive version - may have wrong
%
% Input:        P: the intersection one
%               i: Polygon index
%               j: Clipwin index
% Output:       flag: 1  - in point
%                     -1 - out point
%                     0 - special case, viewed as neither
%

%if p2 = p; vertex of the polygon is on the clipwindow
P=P(1:2)
P1=Polygon(:,i);
P2=Polygon(:,i+1);
P3=Polygon(:,1+ mod(i+1,size(Polygon,2)-1) );

A=Clipwin(:,j);
B=Clipwin(:,j+1);
C=Clipwin(:,1+ mod(j+1,size(Clipwin,2)-1) );

if norm(P-B)==0
    linetest(P1(1),P1(2),A,B)
    linetest(P2(1),P2(2),B,C)
    if linetest(P1(1),P1(2),A,B) * linetest(P2(1),P2(2),B,C) >0
        flag=0;
        return;
    end
end

if linetest(P2(1),P2(2),A,B)==0
    if  linetest(P1(1),P1(2),A,B) ==0 
        if norm(P2-P)<1e-10
            flag=0;            
        else
            flag=-1;
        end
    elseif linetest(P1(1),P1(2),A,B)<0
        if linetest(P3(1),P3(2),A,B)<0
            flag=0;
        end
        if linetest(P3(1),P3(2),A,B)>=0
            flag=1;
        end
    else
        if linetest(P3(1),P3(2),A,B)>=0
            flag=0;
        end
        if linetest(P3(1),P3(2),A,B)<0
            flag=-1;
        end
    end
    return;
end

if  linetest(P2(1),P2(2),A,B) < 0
    flag=-1;
    return;
end

if  linetest(P2(1),P2(2),A,B) > 0
    flag=1;
    return;
end

end

function [sign]= linetest(X,Y,A,B)
sign=(B(2)-A(2))*(X-A(1))-(Y-A(2))*(B(1)-A(1));
end
