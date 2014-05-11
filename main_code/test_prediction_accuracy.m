function [ true_positive, true_negative, false_positive, false_negative ] = test_prediction_accuracy(new_faces, non_faces, pca_stats, classif_stats)
%new faces is a structure containing unknown images of faces at all the
%orientations. non is a matrix of non facial images. pca_stats is the
%structure output by get_classification_info, classif_stats is the
%structure output by get_classification_stats

%determines classification of all images in new_faces and all images in
%non_faces. Reports back the true positive, false positive, true negative,
%and false negative


fields = fieldnames(new_faces);
num_non_face_trials = size(non_faces,2);
present_positives = 0;
present_negatives = 0;
absent_positives = 0;
absent_negatives = 0;
idx = 1;
idx2 = 1;
while(idx<=size(fields,1))
    disp(idx);
    while(idx2<=size(new_faces.(fields{1}),2))
        new_img = new_faces.(fields{idx})(:,idx2);
        [is_face] = classify_new_image(pca_stats,new_img, classif_stats);
        if(is_face)
            present_positives = present_positives+1;
        else
         %   fprintf('wtf');
          
          %  imshow((vec2mat(new_img,640).*1000));
            present_negatives = present_negatives+1;
        end
        idx2=idx2+1;
    end
    idx2 = 1;
    idx = idx+1;
    
end
idx =1;
while(idx<=num_non_face_trials)
    new_img = non_faces(:,idx);
    [is_face] = classify_new_image(pca_stats,new_img, classif_stats);
    if(is_face)
        absent_positives = absent_positives+1;
    else
        absent_negatives = absent_negatives+1;
         
    end
    idx = idx+1;
end
false_positive = absent_positives/(absent_positives+absent_negatives);
true_positive = present_positives/(present_positives+present_negatives);
false_negative = present_negatives/(present_negatives+present_positives);
true_negative = absent_negatives/(absent_positives+absent_negatives);

end

