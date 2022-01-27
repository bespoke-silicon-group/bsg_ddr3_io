extract all;
ext2spice lvs;
# ext2spice hierarchy off;
select top cell;
ext2spice -o "lvs_[cellname list self].spice";