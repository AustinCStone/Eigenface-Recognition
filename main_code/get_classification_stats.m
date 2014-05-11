function [stats] = get_classification_stats(seen_faces,new_faces, non_faces, pca_stats, num_trials)
%computes statistics for threshholding during classification. Assumes that
%new_faces and seen_faces are structured into fields by angle. Assumes that
%non_faces is just an image matrix of 

%stats.mat_*.face_min_dist = average minimum distance of a new facial image
%not in the training set projected onto the eigenface vectors to any face
%in the database

%stats.mat*.face_max_dist = average max distance of a new facial image
%not in the training set projected onto the eigenface vectors to any face
%in the database

%stats.mat*.face_max_dist_sd = standard dev of max distance of a new facial image
%not in the training set projected onto the eigenface vectors to any face
%in the database

%stats.mat*.face_min_dist_sd = standard dev of min distance of a new facial image
%not in the training set projected onto the eigenface vectors to any face
%in the database

%stats.mat*.face_avg_dist = average distance from all the images in the
%database

%stats.mat*.face_avg_sd = standard deviation of the average distance


%stats.mat*.non_face_min_dist = average minimum distance of a new non facial image
%not in the training set projected onto the eigenface vectors to any face
%in the database

%stats.mat*.non_face_max_dist = average max distance of a new non facial image
%not in the training set projected onto the eigenface vectors to any face
%in the database

%stats.mat*.non_face_max_dist_sd = standard dev of max distance of a new non facial image
%not in the training set projected onto the eigenface vectors to any face
%in the database

%stats.mat*.non_face_min_dist_sd = standard dev of min distance of a new non facial image
%not in the training set projected onto the eigenface vectors to any face
%in the database

%stats.mat*.non_face_avg_dist = average distance from all the images in the
%database

%stats.mat*.non_face_avg_sd = standard deviation of the average distance

%assume at least 30 images in each of the new_faces, seen_faces, and
%non_faces. assume both new_faces and seen_faces have the right structure

stats = struct;
fields = fieldnames(seen_faces);
field_idx = 1;
trials = 1;

while(field_idx<=size(fields,1))
    disp(field_idx);
    %init new fields in stats struct
    stats.(fields{field_idx}).new_face.average=0;
    stats.(fields{field_idx}).new_face.sd = 0;
    stats.(fields{field_idx}).new_face.min_dist = 0;
    stats.(fields{field_idx}).new_face.min_dist_sd = 0;
    stats.(fields{field_idx}).new_face.max_dist = 0;
    stats.(fields{field_idx}).new_face.max_dist_sd = 0;
    
    stats.(fields{field_idx}).seen_face.average=0;
    stats.(fields{field_idx}).seen_face.sd = 0;
    stats.(fields{field_idx}).seen_face.min_dist = 0;
    stats.(fields{field_idx}).seen_face.min_dist_sd = 0;
    stats.(fields{field_idx}).seen_face.max_dist = 0;
    stats.(fields{field_idx}).seen_face.max_dist_sd = 0;
    
    stats.(fields{field_idx}).non_face.average=0;
    stats.(fields{field_idx}).non_face.sd = 0;
    stats.(fields{field_idx}).non_face.min_dist = 0;
    stats.(fields{field_idx}).non_face.min_dist_sd = 0;
    stats.(fields{field_idx}).non_face.max_dist = 0;
    stats.(fields{field_idx}).non_face.max_dist_sd = 0;
    
    
    %since the sd of the max and min require multiple samples, auxiliary
    %vectors have to be created to store the max and min from each sample
    min_vec_seen = zeros(1,num_trials);
    max_vec_seen=  zeros(1,num_trials);
    
    min_vec_new = zeros(1,num_trials);
    max_vec_new =  zeros(1,num_trials);
    
    min_vec_non = zeros(1,num_trials);
    max_vec_non =  zeros(1,num_trials);
    db_field_pc = pca_stats.(fields{field_idx}).pc;
    db_field_mean = pca_stats.(fields{field_idx}).mean;
    db_img_pc_proj = pca_stats.(fields{field_idx}).pc_proj;
    
    while(trials<=num_trials)
        new_face = new_faces.(fields{field_idx})(:,trials);
        non_face = non_faces(:,trials);
        %seen_face = seen_faces.(fields{field_idx})(:,trials);
        seen_face =zeros(size(non_face,1),1); %just settting seen face to zeros for now since we don't have data for this
        
        %normalize the new faces
        new_face = new_face./norm(new_face);
        non_face=non_face./norm(non_face);
        
        %get projection of test images onto eigenbasis 
        new_face_proj = (new_face-db_field_mean)'*db_field_pc;
        seen_face_proj = (seen_face-db_field_mean)'*db_field_pc;
        non_face_proj = (non_face-db_field_mean)'*db_field_pc;
        
        %normalize these projections to account for lighting differences
        %and increase accuracy 
%         new_face_proj = new_face_proj./norm(new_face_proj);
%         seen_face_proj = seen_face_proj./norm(seen_face_proj);
%         non_face_proj =non_face_proj./norm(non_face_proj);
        
        %find distance from all other images 
        dist_vec_new = sqrt(sum((bsxfun(@minus, db_img_pc_proj, new_face_proj).^2),2));
        dist_vec_seen = sqrt(sum((bsxfun(@minus, db_img_pc_proj, seen_face_proj).^2),2));
        dist_vec_non = sqrt(sum((bsxfun(@minus, db_img_pc_proj, non_face_proj).^2),2));
        
        %update new face stats
        stats.(fields{field_idx}).new_face.average = stats.(fields{field_idx}).new_face.average+mean(dist_vec_new)/num_trials;
        stats.(fields{field_idx}).new_face.min_dist = stats.(fields{field_idx}).new_face.min_dist + min(dist_vec_new)/num_trials;
        stats.(fields{field_idx}).new_face.max_dist = stats.(fields{field_idx}).new_face.max_dist + max(dist_vec_new)/num_trials;
        stats.(fields{field_idx}).new_face.sd = stats.(fields{field_idx}).new_face.sd + std(dist_vec_new)/num_trials;
        
        %update seen face stats
        stats.(fields{field_idx}).seen_face.average = stats.(fields{field_idx}).seen_face.average+mean(dist_vec_seen)/num_trials;
        stats.(fields{field_idx}).seen_face.min_dist = stats.(fields{field_idx}).seen_face.min_dist + min(dist_vec_seen)/num_trials;
        stats.(fields{field_idx}).seen_face.max_dist = stats.(fields{field_idx}).seen_face.max_dist + max(dist_vec_seen)/num_trials;
        stats.(fields{field_idx}).seen_face.sd = stats.(fields{field_idx}).seen_face.sd + std(dist_vec_seen)/num_trials;
        
        %update non face stats
        stats.(fields{field_idx}).non_face.average = stats.(fields{field_idx}).non_face.average+mean(dist_vec_non)/num_trials;
        stats.(fields{field_idx}).non_face.min_dist = stats.(fields{field_idx}).non_face.min_dist + min(dist_vec_non)/num_trials;
        stats.(fields{field_idx}).non_face.max_dist = stats.(fields{field_idx}).non_face.max_dist + max(dist_vec_non)/num_trials;
        stats.(fields{field_idx}).non_face.sd = stats.(fields{field_idx}).non_face.sd + std(dist_vec_non)/num_trials;
        
        %used to compute the standard deviation of min and max distances
        min_vec_seen(trials)=min(dist_vec_seen);
        max_vec_seen(trials)=max(dist_vec_seen);
        
        min_vec_new(trials)=min(dist_vec_new);
        max_vec_new(trials)=max(dist_vec_new);
        
        min_vec_non(trials)=min(dist_vec_non);
        max_vec_non(trials)=max(dist_vec_non);
        trials = trials+1;
    end
    %compute standard deviation of min and max distances
    stats.(fields{field_idx}).new_face.max_dist_sd = std(max_vec_new);
    stats.(fields{field_idx}).new_face.min_dist_sd =  std(min_vec_new);
    
    stats.(fields{field_idx}).seen_face.max_dist_sd = std(max_vec_seen);
    stats.(fields{field_idx}).seen_face.min_dist_sd = std(min_vec_seen);
    
    
    stats.(fields{field_idx}).non_face.max_dist_sd = std(max_vec_non);
    stats.(fields{field_idx}).non_face.min_dist_sd = std(min_vec_non);
    
    trials = 1;
    field_idx=field_idx+1;
    
    
 
end

