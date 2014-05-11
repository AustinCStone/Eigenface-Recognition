function [mean_dist, min_dist, max_dist, mean_sd] = get_dist_stats(new_img,direction_stats) 
%mean centers each image and then it calculates distance stats 
%direction stats is a field (i.e. facial orientation) of pca_stats

new_img_proj = (new_img-direction_stats.mean)'*direction_stats.pc;
dist_vec = sqrt(sum((bsxfun(@minus, direction_stats.pc_proj, new_img_proj).^2),2));
min_dist = min(dist_vec);
max_dist = max(dist_vec);
mean_dist = mean(dist_vec);
mean_sd = std(dist_vec);


end

