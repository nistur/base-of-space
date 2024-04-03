#!/bin/bash

TARGET=${1:-BFG}

QUIET="-q"

if [ -z "${SCAD}" ] ; then
       SCAD=$(which openscad)
fi
if [ -z "${SCAD}" ] ; then
    echo "Unable to find OpenSCAD. Try setting environment SCAD to it. Eg SCAD=/usr/bin/scad $0"
    exit 1
fi
[ ${QUIET} ] || echo "Using SCAD=${SCAD}"

. config/${TARGET}.cfg
mkdir -p ${TARGET}
for i in ${SIZES[@]} ; do
    echo -n "Creating base ${i}mm"
    FILENAME="${TARGET}/${FORWARD_ARC}-${i}mm${SUFFIX}.stl"
    echo " -->  ${FILENAME}"
    ${SCAD} -o "${FILENAME}" -D base_diameter=${i} \
	    -D base_height=${HEIGHT} \
	    -D arc_angle=${FORWARD_ARC} \
	    -D peg_diameter=${PEG_DIAMETER} \
	    -D peg_height=${PEG_HEIGHT} \
	    -D nubbin_height=${NUBBIN_HEIGHT} \
	    ${QUIET} base.scad
done

if [ ${STEMS} ] ; then
    for i in ${STEMS[@]} ; do
	echo "Creating stem ${i}mm"
	FILENAME="${TARGET}/stem_${i}mm.stl"
	echo " --> ${FILENAME}"
	${SCAD} -o "${FILENAME}" -D stem_height=${i} \
		-D stem_diameter=${STEM_DIAMETER} \
		-D stem_taper=${STEM_TAPER} \
		-D peg_diameter=${PEG_DIAMETER} \
		-D peg_height=${PEG_HEIGHT} \
		-D pin_diameter=${PIN_DIAMETER} \
		${QUIET} stem.scad
    done
fi
