for s_x = 1:x
    for s_y = 1:y
        if im4(s_x,s_y) == 254
           p1_y = s_x;           
           p1_x = s_y;   
        s_x = x;
        s_y = y;
        end
    end
end


for s_y = 1:y
    for s_x = 1:x
        if im4(s_x,s_y) == 254
           p2_y = s_y;           
           p2_x = s_x;   
        s_x = x;
        s_y = y;
        end
    end
end
    for s_x = floor(2*x/3):-1:floor(x/3)
        for s_y = floor(y/3):1:floor(2*y/3)
        if im4(s_x,s_y) == 254
           p5_y = s_x;           
           p5_x = s_y;   
        s_x = x;
        s_y = y;
        end
    end
    end



for s_x = floor(x/3):1:floor(2*x/3)
    for s_y = floor(2*y/3):-1:floor(y/3)
        if im4(s_x,s_y) == 254
           p6_y = s_y;           
           p6_x = s_x;   
        s_x = x;
        s_y = y;
        end
    end
end

for e_y = y:-1:1
    for e_x = x:-1:1
        if im4(e_x,e_y) == 254
           p3_y = e_x;           
           p3_x = e_y;   
        e_x = 1;
        e_y = 1;
        end
    end
end


for e_x = x:-1:1
    for e_y = y:-1:1
        if im4(e_x,e_y) == 254
           p4_y = e_x;           
           p4_x = e_y;   
        e_x = 1;
        e_y = 1;
        end
    end
end
% h = drawpolygon('FaceAlpha',0);
figure(1), 
subplot(1,3,1), imshow('plier_in_box.jpg');
subplot(1,3,2), imshow(im4);

subplot(1,3,3), imshow(im4)
my_vertices = [p1_x p1_y;p2_y p2_x;p6_y p6_x ;p5_x p5_y;p4_x p4_y ;p3_x p3_y];
% my_vertices = [p1_x p1_y];
% my_vertices = [p3_x p3_y];
% my_vertices = [p2_y p2_x];
% my_vertices = [p5_x p5_y];
% my_vertices = [p4_x p4_y];
% my_vertices = [p6_x p6_y];



h = impoly(gca,my_vertices);
addNewPositionCallback(h,@(p) title(mat2str(p,3)));
fcn = makeConstrainToRectFcn('impoly',get(gca,'XLim'),...
    get(gca,'YLim'));
setPositionConstraintFcn(h,fcn);

Xv = my_vertices(:,1);
Yv = my_vertices(:,2);
obj_area = polyarea(Xv,Yv);

Xo = [1,1,x,x]
Yo = [1,y,y,1]

Total_area = polyarea(Xo,Yo);

percentage = obj_area/Total_area * 100

X1 = [p2_x p2_y;p4_x p4_y];
dx1 = pdist(X1,'euclidean');
X2 = [p1_x p1_y;;p3_x p3_y];
dx2 = pdist(X2,'euclidean');
dx = (dx1+dx2)/2;

length = dx/sqrt(x^2+y^2)*34

Y1 = [p1_x p1_y;p2_x p2_y];
dy1 = pdist(Y1,'euclidean');
Y2 = [p3_x p3_y;p4_x p4_y];
dy2 = pdist(Y2,'euclidean');
dy = (dy1+dy2)/2;

width = dy/sqrt(x^2+y^2)*22

% [icondata,iconcmap] = imread('Bottlesimple.jpg'); 
% h=msgbox(strcat('Scan has detected an object with width = ', num2str(width), 'and length =' , num2str(length), '. The Total area showing low intensity in the scan is = ', num2str(percentage), '%'), 'Success','custom',icondata,iconcmap);