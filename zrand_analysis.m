%path must point to the done folder
data_path = '/Volumes/PHOTO STORAGE/Data/done';

scans = dir(data_path);
scans = scans(~ismember({scans.name},{'.','..','.DS_Store'}));
scans = sort_nat({scans.name});

rand_data=[];

for scan = scans
    scan_dir = strcat(data_path,'/',char(scan));
    parc_types = dir(scan_dir);
    parc_types = parc_types(~ismember({parc_types.name},{'.','..','.DS_Store'}));
    parc_types = sort_nat({parc_types.name});
    for parc_type = parc_types
        parc_type_dir = strcat(scan_dir,'/',char(parc_type));
        parcs = dir(parc_type_dir);
        parcs = parcs(~ismember({parcs.name},{'.','..','.DS_Store'}));
        parcs = sort_nat({parcs.name});
        
        average = 0;
        
        %generate combinations of parcellations
        combinations = nchoosek(1:100,2);
        for n=1:nchoosek(100,2)
            comb = combinations(n,:);
            parc1name = parcs{1,comb(1)};
            parc2name = parcs{1,comb(2)};
            
            parc1_path = strcat(parc_type_dir,'/',char(parc1name))
            parc2_path = strcat(parc_type_dir,'/',char(parc2name))
            
            parc1 = importdata(parc1_path,'*');
            parc2 = importdata(parc2_path,'*');
            
            [zRand, SR] = zrand(parc1.data,parc2.data);
            SR
            average = average + SR;            
        end
        rand_data(end+1)=average/nchoosek(100,2)
    end
end





