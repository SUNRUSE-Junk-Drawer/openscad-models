git clean -fdX
find ./models -type f -name *.render.scad -print0 |
xargs -P0 -0 -n1 sh ./scripts/generate_one.sh ||
exit 1