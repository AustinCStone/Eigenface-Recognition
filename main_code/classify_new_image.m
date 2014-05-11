function [is_face] = classify_new_image(pca_stats,new_img, classif_stats)
%pca_stats is the pca_stats object used throughout this project.
%classif_stats is the mean, min, and max distance and sd stats structure returned by
%get_classification_stats. new_img is the new image to be classified,
%assumed to already be normalized


%lots of unused variables - I plan on modifying this function in the future
%and wanted to keep them around to spark my memory
is_face = 0;
closest_face = 0;
%db should contain fields sorted from least to greatest 
fields = fieldnames(pca_stats);
max_idx = size(fields,1);
min_idx = 1;
idx = 1;
prev_liklihood = 0; 
max=0;
max_field = fields(idx);
%used to evaluate with only forward facing images
% face_odds = odds_of_face(pca_stats.mat_pos0,classif_stats.mat_pos0,new_img);
%  if(face_odds>1)
%          is_face=1;
%  end

while(idx<=size(fields,1))
   
    face_odds = odds_of_face(pca_stats.(fields{idx}),classif_stats.(fields{idx}),new_img);
    if(face_odds>1)
        is_face=1;
        break
    end
%     if(face_odds>=max)
%         max =face_odds;
%         max_field = fields(idx);
%     end
  
   
    idx = idx+1;
end
% fprintf('winner is: ');
% disp(max_field);
%binary search
% idx = floor(size(fields,1)/2);
% while(found==false)
% %B and L for Big and Little...
%  [B_min_dist, B_max_dist, B_mean_dist, B_mean_sd] = get_dist_stats(new_img,pca_stats.(fields{max_idx}));
%  [L_min_dist, L_max_dist, L_mean_dist, L_mean_sd] = get_dist_stats(new_img,pca_stats.(fields{min_idx}));
%      
%  %check which basis represented the image better
%  if(B_mean_dist<=L_mean_dist)
%      
%  end
%  
%end
end

