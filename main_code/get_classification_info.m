function [pca_stats] = get_classification_info(db, num_pc_to_save)
%Computes statistics about the images in db
%it stores each image's vector projection onto the eigenfaces, principal
%components for each orientation, the variance explained by each component,
%and mean normalized image for each orientation

%figure out each image's principal components and save that 
fields = fieldnames(db);
index = 1;
pca_stats=struct;
while(index<=size(fields,1))
    disp(index);
    [pc, y, var_pc] = pca_by_svd(db.(fields{index})', num_pc_to_save);
    pca_stats.(fields{index}).pc = pc;
    pca_stats.(fields{index}).var_pc=var_pc;
    pca_stats.(fields{index}).pc_proj = y;
    %projections are on rows, want them normalized 
    %pca_stats.(fields{index}).pc_proj= normr(y);
    %pca_stats.(fields{index}).mean = mean(db.(fields{index}),2);
    pca_stats.(fields{index}).mean = mean(normc(db.(fields{index})),2);

    
    index = index+1;
end


end

