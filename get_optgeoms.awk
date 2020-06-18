BEGIN{igeom=0}
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
        igeom++
}
END{
        ngeom=igeom-1
        nat=iat
        for (igeom=0; igeom<ngeom; igeom++) {
                filename=sprintf("geom_%03i.xyz", igeom+1)
                printf("%4i\n\n",nat)                                >> filename
                for (iat=1; iat<=nat; iat++) {
                        q = geoms[igeom, iat, "Z"]
                        x = geoms[igeom, iat, "x"]
                        y = geoms[igeom, iat, "y"]
                        z = geoms[igeom, iat, "z"]
                        if (q==1) {q="H"}
                        if (q==6) {q="C"}
                        if (q==7) {q="N"}
                        if (q==8) {q="O"}
                        printf("%3s %14.6f %14.6f %14.6f\n",q,x,y,z) >> filename
                }
        }
}
