BEGIN{igeom=0}
/Done/{e=$5}
/Center     Atomic      Atomic             Coordinates \(Angstroms\)/,/Rotational constants/{
        if ($1 ~ /[0-9]+/) {
                iat=$1
                geoms[igeom, iat, "Z"]=$2
                geoms[igeom, iat, "x"]=$4
                geoms[igeom, iat, "y"]=$5
                geoms[igeom, iat, "z"]=$6
        }
}
/Stationary point found./{
	energy[igeom] = e
        igeom++
}
END{
        ngeom=igeom-1
        nat=iat
        for (igeom=0; igeom<=ngeom; igeom++) {
		e = energy[igeom]
                filename=sprintf("geom_%03i.xyz", igeom+1)
                printf("%4i\n%s\n",nat,e)                                >> filename
                for (iat=1; iat<=nat; iat++) {
                        q = geoms[igeom, iat, "Z"]
                        x = geoms[igeom, iat, "x"]
                        y = geoms[igeom, iat, "y"]
                        z = geoms[igeom, iat, "z"]
                        if (q==1) {q="H"}
                        if (q==6) {q="C"}
                        if (q==7) {q="N"}
                        if (q==8) {q="O"}
                        if (q==17) {q="Cl"}
                        printf("%3s %14.6f %14.6f %14.6f\n",q,x,y,z) >> filename
                }
        }
}
