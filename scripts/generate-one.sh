scad_path=$1
base_path=`echo $scad_path | rev | cut -c13- | rev`
openscad --hardwarnings --render --o $base_path".png" $scad_path
openscad --hardwarnings --render --o $base_path".stl" $scad_path
