# How to update material:

After making some changes in the local copy of this repo (`/nfs/cds/share/teaching_documents`):

```
# Add, commit and push changes
git pull
git add <files_to_be_added>
git commit -m "Some informative but short message"
git push

# Build the website
ml Python
bash update_teaching.sh
```

Check that the changes were applied at the [Sunagawa Lab Teaching website](https://sunagawalab.ethz.ch/share/Teaching/)

