number_of_nn = 1

for mat_gen_ind= (-1*number_of_nn): 1 : number_of_nn
    mat_gen{mat_gen_ind+number_of_nn+1} = mat_gen_ind
end
    mat_generated = cell2mat(mat_gen);

combos = combntns(mat_generated, 2);
[f,g] = size(combos);
C(1:f,1:2) = combntns(mat_generated, 2);
C(f+1:f*2,1:2) = combntns(-1*mat_generated, 2);
for num_gen_ind= (-1*number_of_nn): 1 : number_of_nn
C(f*2+num_gen_ind+number_of_nn+1, 1:2) = [num_gen_ind num_gen_ind]
end

[a,b] = size(C)

x = 9, y = 9

initial_sum = zeros(x-number_of_nn, y-number_of_nn);

for l = number_of_nn+1:x-number_of_nn 
    for m = number_of_nn+1:y-number_of_nn
            for ind = 1:a
            new_img(l,m) = seg_compute_whole_image(l+(C(ind, 1)), m+(C(ind, 2))) + initial_sum(x-number_of_nn, y-number_of_nn)
            initial_sum(x-number_of_nn, y-number_of_nn) = new_img(l,m)
            end
            initial_sum = zeros(x-number_of_nn, y-number_of_nn);
        end
    end