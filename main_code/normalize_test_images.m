function [ db_test_normalized ] = normalize_test_images(db_test)
%normalizes all images, assumes images are columns of db_test fields
db_test_normalized=db_test;
fields = fieldnames(db_test);
idx = 1;
while(idx<=size(fields,1))
    db_test_normalized.(fields{idx})=normc(db_test.(fields{idx}));
    idx = idx+1;
end


end

