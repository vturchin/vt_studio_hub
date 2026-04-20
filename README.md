# VT Studio Hub

Launch dashboard and scripts for the four VT AI Studio tools.

---

## The Four Tools

| Folder | GitHub Repo | Branch | Port | What it is |
|--------|------------|--------|------|-----------|
| `vt_VeeVee/` | [vturchin/vt_VeeVee](https://github.com/vturchin/vt_VeeVee) | `main` | **5173** | Node-based visual AI workflow studio ← primary dev |
| `stage-director/` | [vturchin/stage-director](https://github.com/vturchin/stage-director) | `master` | **5174** | 3D scene capture + ControlNet conditioning |
| `vt_fal_studio/` | [vturchin/vt_fal_studio](https://github.com/vturchin/vt_fal_studio) | `master` | **5175** | FAL Studio — TypeScript rewrite |
| `vt_fal_studio_app/` | [vturchin/vt_fal_studio](https://github.com/vturchin/vt_fal_studio) | `experimental` | **3737** | FAL Studio — legacy Express/JSX version |
| `vt_studio_hub/` | [vturchin/vt_studio_hub](https://github.com/vturchin/vt_studio_hub) | `master` | — | **This repo** — launchers + dashboard only |

> `vt_fal_studio/` and `vt_fal_studio_app/` are two local checkouts of the **same** GitHub repo on different branches.

---

## Launch

**Windows** — double-click or run:
```
launch_all.bat
```

**Mac / Linux:**
```bash
chmod +x launch_all.sh
./launch_all.sh
```

Both scripts: kill stale processes on ports 5173/5174/5175/3737, start each tool in its own terminal window, then open `index.html` — a live status dashboard (green dot = running).

**Dashboard URL:** `file:///E:/git_git/vt_studio_hub/index.html`

---

## Git Workflow — Push, Pull, Branch

### Normal daily flow

```
# Start of session — pull latest in each repo
cd E:\git_git\vt_VeeVee       && git pull origin main
cd E:\git_git\stage-director  && git pull origin master
cd E:\git_git\vt_fal_studio   && git pull origin master
cd E:\git_git\vt_fal_studio_app && git pull origin experimental
cd E:\git_git\vt_studio_hub   && git pull origin master

# Work, then push each repo independently
cd E:\git_git\vt_VeeVee       && git add -p && git commit -m "what changed" && git push origin main
cd E:\git_git\stage-director  && git add -p && git commit -m "what changed" && git push origin master
# ... etc
```

### Mac ↔ PC sync

Each tool is its own repo so you only push/pull what you changed:

```bash
# On Mac — push VeeVee changes
cd ~/git_git/vt_VeeVee && git add . && git commit -m "…" && git push origin main

# On PC — pull those same changes
cd E:\git_git\vt_VeeVee && git pull origin main
```

### Feature branches (optional, for bigger experiments)

```bash
# Create a branch for a new feature
git checkout -b feature/my-feature

# Push it to GitHub (doesn't affect main)
git push origin feature/my-feature

# When ready, merge back (or open a PR)
git checkout main && git merge feature/my-feature
git push origin main
```

### Rules to stay sane

| Rule | Why |
|------|-----|
| Each folder = one tool, one `origin` | No more cross-pointing remotes |
| `vt_fal_studio/` = `master` branch | The new TypeScript version |
| `vt_fal_studio_app/` = `experimental` branch | The legacy JSX version |
| Never push `vt_fal_studio_app` to `master` | That would overwrite the TS version |
| This hub (`vt_studio_hub`) = launchers only | No app code here |

---

## Directory Map

```
E:\git_git\
  vt_VeeVee\          ← origin → github.com/vturchin/vt_VeeVee          (main)
  stage-director\     ← origin → github.com/vturchin/stage-director      (master)
  vt_fal_studio\      ← origin → github.com/vturchin/vt_fal_studio       (master)
  vt_fal_studio_app\  ← origin → github.com/vturchin/vt_fal_studio       (experimental)
  vt_studio_hub\      ← origin → github.com/vturchin/vt_studio_hub       (master)  ← YOU ARE HERE
```
