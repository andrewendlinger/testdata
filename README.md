# Test Data for the `hypermri` package


### Open Questions

1. Do we need the following to be included?:

|  Type  |          Name              |  Keep?  |
|--------|----------------------------|---------|
| Folder | AdjResults                 | No      |
| Folder | Mapshim                    | No      |
| File   | AdjStatePerStudy           | No      |
| File   | ScanProgram.scanProgram    | No      |
| File   | subject                    | **Yes** |
| File   | ResultState                | No      |


---


#### Steps done to create this repo

1. Init git lfs

```bash
❯ git lfs install
```

2. Create config file to list binary files to track
```bash
❯ touch .gitattributes
```

3. Inside .gitattributes write:
```
fid filter=lfs diff=lfs merge=lfs -text
2dseq filter=lfs diff=lfs merge=lfs -text
```

4. Commit and push
``` bash
git add -A
git commit -m "Configure Git LFS to track fid and 2dseq files"
git push origin main
```