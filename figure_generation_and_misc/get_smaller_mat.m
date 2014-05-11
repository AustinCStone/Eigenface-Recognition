function [ new_db ] = get_smaller_mat(db, start, num_to_load )

fields = fieldnames(db);
idx = 1;
img_i =1;
new_db = struct;
while(idx<=size(fields,1))
     finish=num_to_load+start;
      new_db.(fields{idx})=db.(fields{idx})(:,start:finish);
    %db.(fields{idx})=db.(fields{idx})(:,1:number_to_load);
    idx = idx+1;
end

