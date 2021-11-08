# How to update material:

After making some changes in the local copy of this repo (`/nfs/cds/share/teaching`) **add** any change, **commit** and **push**:

```
#Add, commit and push changes

git pull
git add -A
git commit -m "Some informative but short message"
git push
```

A distiction needs to be made between the *source* directory with the markdown and necessary sphinx files, and a compiled folder with the actual website.

The main website (for courses run entirely by the lab, so block courses, IMB internal courses and any external courses we might host) is `/nfs/cds/share/teaching/home`, which is built with the material in its source directory `/nfs/cds/share/teaching/home_source`.

There is a separate website for the bioinformatics praktikum (`/nfs/cds/share/teaching/bioinformatics_praktikum` which is built from `/nfs/cds/share/teaching/bioinformatics_praktikum`).

This is important when building the website as the source and destination folders need to be properly specified. The main command to **build the website** is `./compile_website.sh source_dir destination_dir`. For example, to build any of the courses run entirely by the lab:

```
# Build the website

ml Sphinx
./compile_website.sh home_source home
```

Check that the changes were applied at the [Sunagawa Lab Teaching website](https://sunagawalab.ethz.ch/share/teaching/)

