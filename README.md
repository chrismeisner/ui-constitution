# UI Constitution

Opinionated, enforceable ruleset for building high-quality accessible interfaces with AI agents.

## Install

```bash
curl -fsSL https://ui-constitution.dev/install.sh | sh
```

Or manually copy `SKILL.md` to `~/.cursor/skills/ui-constitution/SKILL.md`

## Commands

| Command | Description |
|---------|-------------|
| `/ui build` | Generate UI with all constraints applied |
| `/ui review <file>` | Audit for violations with suggested fixes |
| `/ui fix <file>` | Apply safe automatic fixes |
| `/ui score <file>` | Get a quality score breakdown |

## What it enforces

- WCAG 2.1 accessibility requirements
- Keyboard and screen reader compatibility
- Performance-safe animations only
- Accessible component primitives (Radix, React Aria, Base UI)
- Tailwind best practices
- Opinionated design taste

## Hosting

This repo is designed to be hosted as a static site. The install script fetches `SKILL.md` from GitHub raw content.

### Deploy to Vercel

```bash
vercel
```

### Deploy to Netlify

```bash
netlify deploy --prod
```

### Deploy to GitHub Pages

Enable GitHub Pages in repo settings, pointing to the root directory.

## Customizing

Fork this repo and modify `SKILL.md` to match your team's standards. Update the URLs in `install.sh` and `index.html` to point to your fork.

## License

MIT
