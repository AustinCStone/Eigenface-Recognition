function [ face_odds] = odds_of_face(direction_stats,classif_stats, new_img)
%computes the odds of the new_img being a face, i.e. the liklihood it is a
%face divided by the liklihood it is not a face. direction stats is a field
%of pca_stats. classif_stats are the classification statistics output by
%get_classification_stats
N = size(direction_stats.pc_proj,1);

[mean_dist, min_dist, max_dist, mean_sd] = get_dist_stats(new_img,direction_stats);
%fprintf('mean distance is: ');
%disp(mean_dist);
%fprintf('min distance is: ');
%disp(min_dist);
%fprintf('mean sd is : ');
%disp(mean_sd);
%     z_score_mean = sqrt((mean_dist-classif_stats.new_face.average)^2)/(classif_stats.new_face.sd/sqrt(N));
%     z_score_min = sqrt((min_dist-classif_stats.new_face.min_dist)^2)/classif_stats.new_face.min_dist_sd;
%     fprintf('z_score_mean: ');
%     disp(z_score_mean);
%     fprintf('z scaore min is ');
%     disp(z_score_min);
%     fprintf('liklihood is: ');
    face_liklihood_min=normpdf(min_dist,classif_stats.new_face.min_dist,classif_stats.new_face.min_dist_sd);
    face_liklihood_mean = normpdf(mean_dist,classif_stats.new_face.average,classif_stats.new_face.sd/sqrt(N));
    face_liklihood_max=normpdf(max_dist,classif_stats.new_face.max_dist,classif_stats.new_face.max_dist_sd);
    
    
    non_face_liklihood_min=normpdf(min_dist,classif_stats.non_face.min_dist,classif_stats.new_face.min_dist_sd);
    non_face_liklihood_mean = normpdf(mean_dist,classif_stats.non_face.average,classif_stats.new_face.sd/sqrt(N));
    non_face_liklihood_max=normpdf(max_dist,classif_stats.non_face.max_dist,classif_stats.new_face.max_dist_sd);
%     fprintf('liklihood min is :');
%     disp(liklihood_min);
%     fprintf('liklihood mean is: ');
%     disp(liklihood_mean);
%     fprintf('liklihood max is: ');
%     disp(liklihood_max);
    face_liklihood = face_liklihood_min+face_liklihood_mean+face_liklihood_max;
%     fprintf('face liklihood');
%     disp(face_liklihood);
    non_face_liklihood = non_face_liklihood_min+non_face_liklihood_mean+non_face_liklihood_max;
%     fprintf('non face liklihood');
%     disp(non_face_liklihood);
%     if(non_face_liklihood>face_liklihood)
%         disp('NOT A FACE');
%     else
%         disp('IS A FACE');
%     end
   face_odds = face_liklihood/non_face_liklihood;
end

