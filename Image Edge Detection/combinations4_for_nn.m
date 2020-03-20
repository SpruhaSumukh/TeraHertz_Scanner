function thresh_im = combinations4_for_nn( image,  number_of_nn)
%COMBINATIONS Summary of this function goes here
%   Detailed explanation goes here
% number_of_nn = 1

[x,y] = size(image);
% new_img = zeros(x, y);
new_img = image;
% image = (image - min(abs(image(:)))) / (max(abs(image(:))) - min(abs(image(:))) );
% 
% new_img(1:number_of_nn, 1:end) = image(1:number_of_nn, 1:end);
% new_img(1:end, 1:number_of_nn) = image(1:end, 1:number_of_nn);
% new_img(x-1:x, 1:end) = image(x-1:x, 1:end);
% new_img(1:end, y-1:y) = image(1:end, y-1:y);



for mat_gen_ind= (-1*number_of_nn): 1 : number_of_nn
    mat_gen{mat_gen_ind+number_of_nn+1} = mat_gen_ind
end
    mat_generated = cell2mat(mat_gen);

combos = combntns(mat_generated, 2);
[f,g] = size(combos);
C(1:f,1:2) = combntns(mat_generated, 2);
C(f+1:f*2,1:2) = combntns(-1*mat_generated, 2);
for num_gen_ind= (-1*number_of_nn): 1 : number_of_nn
C(f*2+num_gen_ind+number_of_nn+1, 1:2) = [num_gen_ind num_gen_ind];
end

[a,b] = size(C);


initial_sum = zeros(x-number_of_nn, y-number_of_nn);


for l = number_of_nn+1:x-number_of_nn 
    for m = number_of_nn+1:y-number_of_nn
            for ind = 1:a
            new_img_intr(1:a) = image(l+(C(ind, 1)), m+(C(ind, 2)));
            new_img(l,m) = (max(new_img_intr(1:a)) - min(new_img_intr(1:a)))/2;
            mm(l,m) = new_img(l,m);
            if(mm(l,m)>image(l,m))
                thresh_im(l,m) = 0;
            else thresh_im(l,m) = 255;
            end
    end
end
end



end
