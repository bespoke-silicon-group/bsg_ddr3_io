extract all;
ext2spice pex;
# ext2spice hierarchy off;
ext2spice cthresh 0.01
ext2spice rthresh 1
ext2spice subcircuit on;
select top cell;
ext2spice -o "pex_[cellname list self].spice";
# Replace names with:
# sed -i "s/sky130_fd_sc_hd__/extr_sky130_fd_sc_hd__/g" lvs_SSTL.spice