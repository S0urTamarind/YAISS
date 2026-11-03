# PNG Image Optimization

YAISS uses hand-drawn PNG files for its 2D artwork. Keeping these files
lossless is important: the game should retain the original resolution,
transparency, sprite-sheet layout, and pixel data while avoiding unnecessary
repository growth.

## Recommended approach

For this project, a full image-processing pipeline is not necessary at the
start. Use **Oxipng** as a lossless cleanup tool:

1. Run it on the existing PNG assets once.
2. Review the file-size changes and check the affected assets in Godot.
3. Commit the optimized PNGs.
4. Repeat the process when a significant batch of new artwork is added.

Lossless optimization changes PNG compression rather than the image itself.
It does not reduce dimensions or resolution. It should also preserve
transparency, which is important for sprites and other game textures.

The optional `--strip safe` setting removes metadata that is considered safe
to discard. Do not use that option if an asset's metadata is needed for an
external art workflow.

## Install and run Oxipng manually

The simplest option is to install Oxipng from its GitHub releases page:

1. Download the Windows `oxipng` executable from the
   [Oxipng releases](https://github.com/oxipng/oxipng/releases) page.
2. Put `oxipng.exe` in a directory on your `PATH`, or run it using its full
   path.
3. Confirm that it is available:

```powershell
oxipng --version
```

From the repository root, optimize all tracked PNG assets with:

```powershell
Get-ChildItem -Path . -Recurse -Filter *.png -File |
  ForEach-Object { oxipng -o 4 --strip safe --alpha $_.FullName }
```

To optimize one file only:

```powershell
oxipng -o 4 --strip safe --alpha .\Assets\notebookBg.png
```

Review the changed files and test the affected assets in Godot before
committing:

```powershell
git status --short
git diff --stat
```

## Working with multiple contributors

When optimization is performed, contributors should:

- Optimize only the PNG files they intend to change.
- Avoid editing the same binary asset concurrently where possible.
- Open important sprites or sprite sheets in Godot after optimization.
- Leave Godot `.png.import` files alone unless Godot regenerates them.
- Review the resulting diff and file sizes before committing.

Oxipng does not remove large files from previous Git commits. It prevents
unnecessary growth in future commits, but old versions remain in the
repository history.

## Automating it later

If PNGs are added frequently, the process can be automated with
[pre-commit](https://pre-commit.com/). A future `.pre-commit-config.yaml` can
pin Oxipng to a known version so every contributor uses the same settings:

```yaml
repos:
  - repo: https://github.com/oxipng/oxipng
    rev: v10.0.0
    hooks:
      - id: oxipng
        args: ["-o", "4", "--strip", "safe", "--alpha"]
```

After that configuration is added, install pre-commit with Python and pip:

```powershell
py -m pip install pre-commit
pre-commit --version
```

Then, from the repository root, install the Git hook:

```powershell
pre-commit install
```

The initial repository-wide cleanup can be run with:

```powershell
pre-commit run --all-files
```

To run the hook only against files staged for a commit:

```powershell
pre-commit run
```

The hook then checks relevant files during normal commits. If it changes a
PNG, the contributor should stage the optimized file and commit it.

### CI enforcement

To cover contributors who have not installed the local hook, a future GitHub
Actions workflow can run:

```powershell
pre-commit run --all-files
```

The workflow should run on pull requests and fail when files need
optimization, rather than silently committing changes to a contributor's
branch. This provides a consistent check without making the CI job rewrite
someone else's work.

Start with the manual workflow for the current small asset set. Add the
pre-commit hook and CI check when asset additions become frequent or when
unoptimized files begin appearing in pull requests.

## When to consider Git LFS

Git LFS is not required merely because the project contains PNGs. Consider it
only if individual assets become very large, the repository exceeds practical
clone sizes, or large binary files change frequently. Introducing Git LFS is a
team-wide decision because contributors need Git LFS installed and existing
files may require coordinated migration.
