# This program will load a system of droplet and calulate the volmap densities
# at specific times to see how droplets change shape. We are try to find
# instanteous shape of droplets. Overall the droplet has a smooth isotropic
# shape when averaged and combined over all time frames. Instaneous snapshots
# could reveal aniostropy.

mol load psf calc.psf dcd calc.dcd

#parameters for sampling trajectory
set step 50 ; # 5 ns
set res1 OCT ;# resnames
set res2 EST
set start 600 ;# start sampleing once equilibration has occured
set system "2"
set div 10 ;# number of frames for 1 ns
set resol 1.0 ;# resolution in Angs
set nf [molinfo top get numframes] ;# totla number of frames

for {set fr $start} {$fr < $nf} {set fr [expr $fr + $step]} {
	molinfo top set frame $fr
	set tns [expr $fr/$div] ; # calculate time in ns

	# sample droplet of octanes
	set out1 "$res1-sys$system-$tns.dx"
	volmap density [atomselect top "resname $res1"] -res $resol -weight mass -mol top -o $out1

	# sample ester molecules on surface
	set out2 "$res2-sys$system-$tns.dx"
	volmap density [atomselect top "resname $res2"] -res $resol -weight mass -mol top -o $out2
}
exit
