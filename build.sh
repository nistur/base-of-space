#!/bin/bash

ABS_FORWARD_ARC=45
BFG_FORWARD_ARC=90

ABS_SIZES="25 30 40 60"
BFG_SIZES="32 60"

if [ -z "${SCAD}" ] ; then
       SCAD=$(which openscad)
fi
if [ -z "${SCAD}" ] ; then
    echo "Unable to find OpenSCAD. Try setting environment SCAD to it. Eg SCAD=/usr/bin/scad $0"
    exit 1
fi
echo "Using SCAD=${SCAD}"


mkdir -p ABS
for i in ${ABS_SIZES} ; do
    ${SCAD} -o ABS/${ABS_FORWARD_ARC}-${i}mm.stl -D base_diameter=${i} -D arc_angle=${ABS_FORWARD_ARC} base.scad
done

mkdir -p BFG
for i in ${BFG_SIZES} ; do
    ${SCAD} -o BFG/${BFG_FORWARD_ARC}-${i}mm.stl -D base_diameter=${i} -D arc_angle=${BFG_FORWARD_ARC} base.scad
done
