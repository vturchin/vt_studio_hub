# VT Studio Hub

Launcher and dashboard for the three VT AI Studio tools.

| Tool | Repo | Port | Description |
|------|------|------|-------------|
| **VeeVee** | [vt_VeeVee](https://github.com/vturchin/vt_VeeVee) | 5173 | Node-based visual AI workflow studio |
| **Stage Director** | [stage-director](https://github.com/vturchin/stage-director) | 5174 | 3D scene capture and conditioning for GenAI render |
| **FAL Studio** | [vt_fal_studio](https://github.com/vturchin/vt_fal_studio) | 5175 | Single-panel / chain-timeline fal.ai generator |

## Launch

**Windows:**
```
launch_all.bat
```

**Mac / Linux:**
```bash
chmod +x launch_all.sh
./launch_all.sh
```

Both scripts kill stale processes on ports 5173/5174/5175, start each tool in its own terminal window, and open `index.html` — a status dashboard showing which servers are live.

## Repo map

```
E:\git_git\
  vt_VeeVee\          ← github.com/vturchin/vt_VeeVee     (main)
  vt_fal_studio\      ← github.com/vturchin/vt_fal_studio (master)
  stage-director\     ← github.com/vturchin/stage-director (master)
  vt_studio_hub\      ← github.com/vturchin/vt_studio_hub  (main)  ← YOU ARE HERE
```

Each tool is a fully independent repo. This hub only contains launchers and the dashboard — no shared code.
