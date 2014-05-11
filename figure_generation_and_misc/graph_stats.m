function [] = graph_stats( stats )
%takes as input stats object, plots 3 bar graphs.
%It plots min distance, max distance, average distance, and their standard
%devitions per field (angle increment) for unknown faces, non facial images,
%and facial images taht have been seen before 




fields = fieldnames(stats);
idx = 1;
%plot for new, unknown faces
data = zeros(size(fields,1),2);
while(idx<=size(fields,1))
    data(idx,1)=stats.(fields{idx}).new_face.max_dist;
    data(idx,2)=stats.(fields{idx}).non_face.max_dist;
    %data(idx,3)=stats.(fields{idx}).new_face.max_dist;
    idx = idx+1;
end
y = data(1:size(fields,1),:);
bar(y);
set(gca,'XTickLabel',{'-90'; '-65';'-40';'-15'; ...
   '5';'30';'55';'80'});
%set(gca,'XTickLabel',{'-90','0','90'});  
xlabel('orientation in degrees');
ylabel('max distance');
%title('Standard Deviation without Normalization');
hleg1 = legend('Faces','Non Faces');

end

