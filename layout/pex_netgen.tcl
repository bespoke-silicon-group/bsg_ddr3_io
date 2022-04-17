# Tim's Cap-Res extraction procedure

set NAME [cellname list self];
select top cell;
# (Flattening improves resistance extraction)
#flatten -nolabels -dotoplabels "[list $NAME]_flat";
flatten "[list $NAME]_flat";
load "[list $NAME]_flat";
select top cell;

extract do resistance;
extract all;

ext2sim labels on;
ext2sim;

extresist tolerance 10;
extresist all;

ext2spice lvs;
ext2spice cthresh 0.1;
ext2spice rthresh 10
ext2spice extresist on;
ext2spice -o "pex_[list $NAME].spice";
