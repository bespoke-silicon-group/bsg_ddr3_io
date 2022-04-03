# Sky130 PDK instillation

If you need to install the pdk yourself, clone the [open_pdks repo](https://github.com/RTimothyEdwards/open_pdks).

The dependencies for the tool instillation are also the dependencies for pdk installation. So make sure you have all of those packages first.

One extra thing is magic is actually a dependency to build the pdk. This can be added by building magic from this repo and adding the binary to PATH.

### Script to install sky130A
```
# start root of this repo to install magic
make install-magic
export PATH="`pwd`tools/magic-install/bin:$PATH"

# Move to open_pdks repo to build and install PDK
cd <OPEN_PDKS_DIR>
./configure --enable-sky130-pdk --with-sky130-variants=A --datarootdir=<PDK_INSTALL_DIR>
make && make install
```

The PDK will be installed at `PDK_INSTALL_DIR/pdk/sky130A`.

After installation, update the Makefile in this repo to point to the PDK.    
`PDKSPATH` should point the the `PDK_INSTALL_DIR/pdk` directory   
`PDKNAME` should be the name of the specific PDK directory you want (in this example sky130A.)
