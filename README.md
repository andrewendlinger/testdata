# Test Data for the `hypermri` package


## How to add files:

There exists one folder for each sequence to be tested. Inside the `bruker` directory,
add a new folder named after the sequence, in here you can put the BrukerExp folders.

Next to the BrukerExp folders, general study related files are handled as follows:


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