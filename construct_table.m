% by Chuhang Zou
% modifyied by GUANG
% 2013.6.11

function [Polygontab]= construct_table(inter,Polygon)
% construct the linked table
% naive version
%
% Input:        inter: table of intersactions,
%                      1st line: x-coordinate,2nd line: y-coordinate,3rd
%                      line: in-point or out-point
%               Polgon: table of the vertex of the polygon
% Output:       Polgontab: linked table
%

nPolyVertex = size(Polygon,2);
nInterVertex = size(inter,2);

Polygontab=zeros(3,nPolyVertex+nInterVertex);

polygonindex = 1;
index = 1;

Polygontab(1,index) =  Polygon(1,polygonindex);
Polygontab(2,index) =  Polygon(2,polygonindex);
Polygontab(3,index) =  0;

while polygonindex<nPolyVertex
    %   for  i = 1 : (nPolyVertex-1)
    Polygontabtemp = [];
    intercount = 0;
    
    for j = 1 : nInterVertex
        if  isinline( inter(1,j),inter(2,j),Polygon(:,polygonindex),Polygon(:,polygonindex+1) )
            if online(inter(1,j),inter(2,j),Polygon(:,polygonindex),Polygon(:,polygonindex+1))
                intercount = intercount +1;
                Polygontabtemp(1,intercount) =  inter(1,j);
                Polygontabtemp(2,intercount) =  inter(2,j);
                Polygontabtemp(3,intercount) =  inter(3,j);
                
            end
        end
    end
    
    if intercount>0
        Distance=zeros(1,intercount);
        for j=1:intercount
            Distance(j)=(Polygon(1,polygonindex)-Polygontabtemp(1,j))^2+(Polygon(2,polygonindex)-Polygontabtemp(2,j))^2;
        end
        
        [~,order]=sort(Distance);
        Polygontabtemp=Polygontabtemp(:,order);
        
        
        Polygontab(:,index+1:index+intercount) = Polygontabtemp(:,:);
        index=index+intercount;
    end
    
    Polygontab(1,index+1) =  Polygon(1,polygonindex+1);
    Polygontab(2,index+1) =  Polygon(2,polygonindex+1);
    Polygontab(3,index+1) =  0;
    
    polygonindex = polygonindex +1;
    index = index +1;
    
end

%     % Delete Duplicate
%     nPolyVertex = size (Polygontab,2);
%     Polygontab2 = Polygontab(:,1);
%     index = 1;
%     for i = 1:(nPolyVertex-1)
%         if Polygontab(1,i) ~= Polygontab(1,i+1) || Polygontab(2,i) ~= Polygontab(2,i+1) || Polygontab(3,i) ~= Polygontab(3,i+1)
%             index = index +1;
%         end
%            Polygontab2(:,index) = Polygontab(:,i+1);
%     end

end