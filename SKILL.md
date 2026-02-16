---
name: ui-constitution
description: Opinionated, enforceable UI ruleset for Cursor agents.
version: 4.0.0
---

# UI Constitution

When the user invokes `/ui`, apply these rules to everything you build or review.

---

## Behavior

- **Building UI?** → Follow all rules. Never violate MUST/NEVER constraints.
- **Reviewing code?** → Find violations, explain why they matter, suggest fixes.
- **Asked to fix?** → Apply safe fixes only (see Auto-Fix Policy below).

Be strict. Be specific. No vague advice.

---

## Rules

### Accessibility (CRITICAL)
- Images need `alt` text
- Icon-only buttons need `aria-label`
- Form inputs need labels
- No `div onClick` — use `button`
- No links without `href`
- Do not suppress native keyboard focus visibility (`outline: none` without replacement)
- High-visibility/custom focus outlines are opt-in (only when explicitly requested or a high-visibility setting is enabled)
- Touch targets: 44×44px minimum

### Components
- Use accessible primitives (Radix, React Aria, Base UI)
- Use project's existing components first
- Never mix component libraries in same surface
- Never rebuild keyboard/focus behavior by hand

### Interaction
- Destructive actions need AlertDialog confirmation
- Use skeletons for loading states
- Use `h-dvh` not `h-screen`
- Show errors next to the action
- Never block paste

### Animation
Use only Tailwind's built-in transition utilities. No animation unless explicitly requested.

**Transition Property**:
`transition-none` `transition-all` `transition-colors` `transition-opacity` `transition-shadow` `transition-transform`

**Duration** (use these, not `duration-[400ms]`):
`duration-75` `duration-100` `duration-150` `duration-200` `duration-300` `duration-500` `duration-700` `duration-1000`
- Use `duration-150` or `duration-200` for interaction feedback (hover, focus)

**Easing**:
`ease-linear` `ease-in` `ease-out` `ease-in-out`
- Use `ease-out` for entrances
- Use `ease-in` for exits

**Transform** (safe to animate):
`scale-*` `rotate-*` `translate-x-*` `translate-y-*`

**Opacity** (safe to animate):
`opacity-0` `opacity-5` `opacity-10` ... `opacity-100`

**Rules**:
- Only animate `transform` and `opacity` (compositor properties)
- Never animate `width`, `height`, `top`, `left`, `margin`, `padding`
- Respect `prefers-reduced-motion` with `motion-safe:` and `motion-reduce:` variants

**Do NOT use**:
- Arbitrary durations: `duration-[400ms]`, `duration-[0.3s]`
- Custom easing: `ease-[cubic-bezier(0.4,0,0.2,1)]`

### Typography
Use only Tailwind's built-in typography utilities. No arbitrary values. Always use Inter.

**Font Family**:
- Use `font-sans` only (configured to Inter)
- Inter must be the only font in the project
- Configure in Tailwind: `fontFamily: { sans: ['Inter', ...defaultTheme.fontFamily.sans] }`

**Do NOT use**:
- Custom font imports (`@font-face`, Google Fonts for other typefaces)
- Other font families: `font-serif`, `font-mono` (unless for actual code blocks)
- Arbitrary font-family: `font-['Helvetica']`, `font-[system-ui]`
- Display/decorative fonts

---

#### Core Type Scale

This is the source of truth for typography across all pages. When auditing or building, text must map to one of these roles.

| Role | Classes | Use For |
|------|---------|---------|
| **Display** | `text-5xl font-bold leading-tight text-balance` | Hero headlines, landing pages, marketing |
| **Heading 1** | `text-4xl font-semibold leading-tight text-balance` | Page titles, primary sections |
| **Heading 2** | `text-2xl font-semibold leading-snug text-balance` | Section headers, card titles |
| **Heading 3** | `text-xl font-semibold leading-snug text-balance` | Subsection headers, group labels |
| **Heading 4** | `text-lg font-medium leading-snug` | Minor headings, list headers |
| **Body Large** | `text-lg font-normal leading-relaxed text-pretty` | Introductions, featured paragraphs |
| **Body** | `text-base font-normal leading-normal text-pretty` | Default paragraph text |
| **Body Small** | `text-sm font-normal leading-normal` | Secondary content, descriptions |
| **Caption** | `text-xs font-normal leading-normal` | Timestamps, metadata, footnotes |
| **Label** | `text-sm font-medium leading-none` | Form labels, UI labels, badges |
| **Overline** | `text-xs font-medium uppercase tracking-wide leading-none` | Section overlines, category tags |
| **Code** | `text-sm font-mono leading-normal` | Inline code, technical values |

**Type Scale Rules**:
- Every text element must map to a role from the scale above
- Do not mix-and-match — use the exact class combination for each role
- Headings (Display–H4) must use `text-balance`
- Body text (Body Large, Body) must use `text-pretty`
- Numbers in tables, prices, stats must add `tabular-nums`
- Code blocks are the only exception for `font-mono`

**Color Pairing** (apply with type roles):
| Role | Light Mode | Dark Mode |
|------|------------|-----------|
| Primary text | `text-neutral-900` | `dark:text-neutral-100` |
| Secondary text | `text-neutral-600` | `dark:text-neutral-400` |
| Muted text | `text-neutral-500` | `dark:text-neutral-500` |
| Disabled text | `text-neutral-400` | `dark:text-neutral-600` |

**Complete Examples**:
```
<!-- Heading 1 -->
<h1 class="text-4xl font-semibold leading-tight text-balance text-neutral-900 dark:text-neutral-100">
  Page Title
</h1>

<!-- Body -->
<p class="text-base font-normal leading-normal text-pretty text-neutral-600 dark:text-neutral-400">
  Paragraph content here.
</p>

<!-- Label -->
<label class="text-sm font-medium leading-none text-neutral-900 dark:text-neutral-100">
  Email
</label>

<!-- Caption -->
<span class="text-xs font-normal leading-normal text-neutral-500 dark:text-neutral-500">
  Updated 2 hours ago
</span>
```

---

#### Allowed Utilities Reference

**Font Size** (use these, not `text-[14px]`):
`text-xs` `text-sm` `text-base` `text-lg` `text-xl` `text-2xl` `text-3xl` `text-4xl` `text-5xl` `text-6xl` `text-7xl` `text-8xl` `text-9xl`

**Font Weight** (use these, not `font-[500]`):
`font-thin` `font-extralight` `font-light` `font-normal` `font-medium` `font-semibold` `font-bold` `font-extrabold` `font-black`

**Line Height**:
`leading-none` `leading-tight` `leading-snug` `leading-normal` `leading-relaxed` `leading-loose`
Or numeric: `leading-3` through `leading-10`

**Text Wrap**:
- `text-balance` — use on headings
- `text-pretty` — use on body text
- `text-nowrap` — prevent wrapping

**Numeric**:
- `tabular-nums` — use on numbers, prices, tables

**Do NOT use**:
- Arbitrary font sizes: `text-[14px]`, `text-[1.25rem]`
- Arbitrary font weights: `font-[500]`, `font-[450]`
- Arbitrary line heights: `leading-[1.2]`, `leading-[22px]`
- Letter spacing changes: `tracking-tight`, `tracking-wide` (except Overline role)
- Custom fonts: any font other than Inter
- Font family utilities: `font-serif`, `font-mono` (except for code blocks)
- Arbitrary font-family: `font-['Roboto']`, `font-[system-ui]`
- Ad-hoc combinations — always use the Core Type Scale roles

### Layout
Use only Tailwind's built-in layout utilities. No arbitrary values.

**Z-Index** (use these, not `z-[999]`):
`z-0` `z-10` `z-20` `z-30` `z-40` `z-50`

**Sizing**:
- Use `size-*` for squares: `size-4` `size-6` `size-8` `size-10` `size-12` etc.
- Width/Height scale: `w-0` through `w-96`, `w-full`, `w-screen`, `w-fit`
- Use `h-dvh` not `h-screen` for full viewport height
- Max width: `max-w-xs` `max-w-sm` `max-w-md` `max-w-lg` `max-w-xl` `max-w-2xl` through `max-w-7xl` `max-w-prose` `max-w-full`

**Spacing** (padding/margin/gap):
`0` `px` `0.5` `1` `1.5` `2` `2.5` `3` `3.5` `4` `5` `6` `7` `8` `9` `10` `11` `12` `14` `16` `20` `24` `28` `32` `36` `40` `44` `48` `52` `56` `60` `64` `72` `80` `96`

**Flex/Grid Gap**:
Use `gap-*` with spacing scale above. Not `gap-[13px]`.

**Do NOT use**:
- Arbitrary z-index: `z-[100]`, `z-[9999]`
- Arbitrary sizing: `w-[320px]`, `h-[47px]`
- Arbitrary spacing: `p-[13px]`, `m-[22px]`, `gap-[15px]`

### Performance
- No large `blur()` or `backdrop-filter` animations
- No `will-change` outside active animations
- No `useEffect` for render logic

### Design
Use only Tailwind's built-in design utilities. No arbitrary values.

**Border Radius**:
Prefer subtle, small radii. Avoid large, pill-shaped corners.

Allowed:
`rounded-none` `rounded-sm` `rounded` `rounded-md`

Use sparingly (only for specific UI like avatars, badges, pills):
`rounded-lg` `rounded-full`

Do NOT use (too rounded):
`rounded-xl` `rounded-2xl` `rounded-3xl`

**Shadows** (use these, not `shadow-[0_4px_12px_rgba...]`):
`shadow-sm` `shadow` `shadow-md` `shadow-lg` `shadow-xl` `shadow-2xl` `shadow-none`

**Opacity**:
`opacity-0` `opacity-5` `opacity-10` `opacity-20` `opacity-25` `opacity-30` `opacity-40` `opacity-50` `opacity-60` `opacity-70` `opacity-75` `opacity-80` `opacity-90` `opacity-95` `opacity-100`

**Colors**:
- **Greyscale**: Always use `neutral` — never `slate`, `gray`, `zinc`, or `stone`
- **Other colors**: `red`, `orange`, `amber`, `yellow`, `lime`, `green`, `emerald`, `teal`, `cyan`, `sky`, `blue`, `indigo`, `violet`, `purple`, `fuchsia`, `pink`, `rose`
- Use shade scale: `50` `100` `200` `300` `400` `500` `600` `700` `800` `900` `950`
- Example: `bg-neutral-100`, `text-neutral-900`, `border-blue-500`

**Rules**:
- No gradients unless requested
- No purple/multicolor gradients ever
- No glow effects (`shadow-[0_0_20px_...]`) as primary affordances
- Empty states need one clear action
- One accent color per view max

**Do NOT use**:
- Other greyscale palettes: `slate-*`, `gray-*`, `zinc-*`, `stone-*` (always use `neutral-*`)
- Arbitrary colors: `bg-[#1a1a1a]`, `text-[rgb(50,50,50)]`
- Arbitrary shadows: `shadow-[0_2px_8px_rgba(0,0,0,0.1)]`
- Arbitrary radius: `rounded-[10px]`, `rounded-[0.5rem]`
- Arbitrary opacity: `opacity-[0.85]`
- Large border radius: `rounded-xl`, `rounded-2xl`, `rounded-3xl` (cards, buttons, containers should use `rounded-md` or smaller)

### Dark Mode
All UI must support both light and dark modes using Tailwind's `dark:` variant.

**Configuration**:
- Use class-based dark mode: `darkMode: 'class'` in Tailwind config
- Toggle via `class="dark"` on `<html>` element
- Respect `prefers-color-scheme` for initial state

**Color Pairing** (light → dark):
| Light Mode | Dark Mode | Usage |
|------------|-----------|-------|
| `bg-white` | `dark:bg-neutral-900` | Page background |
| `bg-neutral-50` | `dark:bg-neutral-800` | Card/section background |
| `bg-neutral-100` | `dark:bg-neutral-700` | Hover states, subtle backgrounds |
| `text-neutral-900` | `dark:text-neutral-100` | Primary text |
| `text-neutral-600` | `dark:text-neutral-400` | Secondary text |
| `text-neutral-500` | `dark:text-neutral-500` | Muted/placeholder text |
| `border-neutral-200` | `dark:border-neutral-700` | Borders |
| `border-neutral-300` | `dark:border-neutral-600` | Input borders |

**Accent Colors** (same in both modes, adjust shade if needed):
- Primary actions: Use `500`-`600` shades (work in both modes)
- Example: `bg-blue-600 dark:bg-blue-500`

**Shadows**:
- Light: Use standard shadows (`shadow-sm`, `shadow`, `shadow-md`)
- Dark: Shadows are less visible; rely more on borders or subtle background shifts
- Example: `shadow-md dark:shadow-none dark:border dark:border-neutral-700`

**Rules**:
- Every color utility MUST have a `dark:` counterpart
- Never hardcode colors that only work in one mode
- Test both modes — don't ship light-only or dark-only UI
- Use semantic color naming in components when possible
- Maintain WCAG AA contrast in both modes (4.5:1 for text)

**Implementation Pattern**:
```
<!-- Correct: paired light/dark -->
<div class="bg-white dark:bg-neutral-900 text-neutral-900 dark:text-neutral-100">

<!-- Correct: input with border adjustment -->
<input class="bg-white dark:bg-neutral-800 border-neutral-300 dark:border-neutral-600">

<!-- Correct: card with shadow/border swap -->
<div class="bg-white dark:bg-neutral-800 shadow-md dark:shadow-none dark:border dark:border-neutral-700">
```

**Do NOT use**:
- Unpaired colors: `bg-white` without `dark:bg-*`
- Other greyscale palettes: `gray-*`, `slate-*`, `zinc-*`, `stone-*` (always use `neutral-*`)
- Pure black in dark mode: `dark:bg-black` (too harsh, use `dark:bg-neutral-900` or `dark:bg-neutral-950`)
- Pure white text in dark mode: `dark:text-white` (too bright, use `dark:text-neutral-100`)
- Arbitrary dark colors: `dark:bg-[#1a1a1a]`
- Inverted opacity for dark mode: don't use `dark:opacity-80` to "fix" contrast

### Stack
- Tailwind CSS defaults
- `cn()` utility (clsx + tailwind-merge)
- motion/react for JS animation
- tw-animate-css for entrance animations

---

## Core Systems

These are the single sources of truth for UI decisions. Every element must map to a defined token from these systems. When auditing multiple pages, check that they all reference the same system values.

---

### Core Spacing Scale

Semantic spacing tokens for consistent rhythm across all UI.

| Token | Value | Classes | Use For |
|-------|-------|---------|---------|
| **None** | 0 | `gap-0` `p-0` `m-0` | Reset, collapsed states |
| **Hairline** | 1px | `gap-px` `p-px` | Borders, dividers |
| **Tight** | 4px | `gap-1` `p-1` `m-1` | Icon-to-text, inline elements |
| **Compact** | 8px | `gap-2` `p-2` `m-2` | Button padding, list items, tight groups |
| **Default** | 12px | `gap-3` `p-3` `m-3` | Input padding, card padding (small) |
| **Comfortable** | 16px | `gap-4` `p-4` `m-4` | Card padding, form groups, standard spacing |
| **Relaxed** | 24px | `gap-6` `p-6` `m-6` | Section padding, large card padding |
| **Spacious** | 32px | `gap-8` `p-8` `m-8` | Page sections, major groups |
| **Section** | 48px | `gap-12` `p-12` `m-12` | Between page sections |
| **Page** | 64px | `gap-16` `p-16` `m-16` | Page-level vertical rhythm |

**Spacing Rules**:
- Pick from the semantic tokens above — don't use arbitrary spacing values
- Maintain consistent rhythm: if cards use `p-4`, all cards should use `p-4`
- Nested spacing should step down: container `p-6` → inner card `p-4` → card content `gap-3`
- Use `gap-*` for flex/grid children, `p-*` for container padding, `m-*` sparingly for external spacing

**Common Patterns**:
```
<!-- Card with consistent spacing -->
<div class="p-4 flex flex-col gap-3">

<!-- Form with field groups -->
<form class="flex flex-col gap-6">
  <div class="flex flex-col gap-2">

<!-- Page sections -->
<main class="py-16 flex flex-col gap-12">
```

---

### Core Elevation Scale

Semantic elevation levels for consistent depth and layering.

| Level | Shadow | Border (Dark Mode) | Z-Index | Use For |
|-------|--------|-------------------|---------|---------|
| **Flat** | `shadow-none` | — | `z-0` | Inline elements, flat cards |
| **Raised** | `shadow-sm` | `dark:border dark:border-neutral-700` | `z-0` | Cards, contained sections |
| **Elevated** | `shadow-md` | `dark:border dark:border-neutral-700` | `z-10` | Dropdown triggers, hovering cards |
| **Overlay** | `shadow-lg` | `dark:border dark:border-neutral-600` | `z-20` | Dropdowns, popovers, tooltips |
| **Modal** | `shadow-xl` | `dark:border dark:border-neutral-600` | `z-40` | Modals, dialogs, sheets |
| **Toast** | `shadow-lg` | `dark:border dark:border-neutral-600` | `z-50` | Toasts, notifications |

**Elevation Rules**:
- Higher elevation = appears closer to user = higher z-index
- Dark mode shadows are less visible — always pair with border
- Only one modal-level element at a time
- Overlays (dropdowns, popovers) should dismiss when clicking outside
- Toast/notification always on top

**Complete Elevation Examples**:
```
<!-- Raised card -->
<div class="bg-white dark:bg-neutral-800 shadow-sm dark:shadow-none dark:border dark:border-neutral-700 rounded-md">

<!-- Dropdown overlay -->
<div class="bg-white dark:bg-neutral-800 shadow-lg dark:border dark:border-neutral-600 rounded-md z-20">

<!-- Modal -->
<div class="bg-white dark:bg-neutral-900 shadow-xl dark:border dark:border-neutral-600 rounded-md z-40">
```

---

### Core Color Roles

Semantic color assignments for consistent meaning across all UI.

#### Surface Colors
| Role | Light Mode | Dark Mode | Use For |
|------|------------|-----------|---------|
| **Page** | `bg-white` | `dark:bg-neutral-900` | Page background |
| **Surface** | `bg-neutral-50` | `dark:bg-neutral-800` | Cards, sections, raised areas |
| **Surface Raised** | `bg-neutral-100` | `dark:bg-neutral-700` | Nested cards, hover states |
| **Inset** | `bg-neutral-100` | `dark:bg-neutral-950` | Input backgrounds, code blocks |

#### Text Colors
| Role | Light Mode | Dark Mode | Use For |
|------|------------|-----------|---------|
| **Primary** | `text-neutral-900` | `dark:text-neutral-100` | Headings, important text |
| **Secondary** | `text-neutral-600` | `dark:text-neutral-400` | Body text, descriptions |
| **Muted** | `text-neutral-500` | `dark:text-neutral-500` | Placeholders, hints, timestamps |
| **Disabled** | `text-neutral-400` | `dark:text-neutral-600` | Disabled states |
| **Inverse** | `text-white` | `dark:text-neutral-900` | Text on accent backgrounds |

#### Border Colors
| Role | Light Mode | Dark Mode | Use For |
|------|------------|-----------|---------|
| **Default** | `border-neutral-200` | `dark:border-neutral-700` | Cards, sections, dividers |
| **Strong** | `border-neutral-300` | `dark:border-neutral-600` | Inputs, interactive elements |
| **Focus (Opt-in)** | `ring-blue-500` | `dark:ring-blue-400` | High-visibility focus style (only when explicitly requested or user setting is enabled) |

#### State Colors
| State | Background | Text | Border | Use For |
|-------|------------|------|--------|---------|
| **Success** | `bg-green-50 dark:bg-green-950` | `text-green-700 dark:text-green-400` | `border-green-200 dark:border-green-800` | Success messages, valid states |
| **Warning** | `bg-amber-50 dark:bg-amber-950` | `text-amber-700 dark:text-amber-400` | `border-amber-200 dark:border-amber-800` | Warnings, caution states |
| **Error** | `bg-red-50 dark:bg-red-950` | `text-red-700 dark:text-red-400` | `border-red-200 dark:border-red-800` | Errors, destructive states |
| **Info** | `bg-blue-50 dark:bg-blue-950` | `text-blue-700 dark:text-blue-400` | `border-blue-200 dark:border-blue-800` | Information, neutral alerts |

#### Accent Colors (Primary Action)
| Role | Classes | Use For |
|------|---------|---------|
| **Accent Background** | `bg-blue-600 dark:bg-blue-500` | Primary buttons, active states |
| **Accent Text** | `text-blue-600 dark:text-blue-400` | Links, interactive text |
| **Accent Hover** | `hover:bg-blue-700 dark:hover:bg-blue-600` | Button hover states |

**Color Rules**:
- Every `bg-*` must have a `dark:bg-*` pair
- Every `text-*` must have a `dark:text-*` pair
- Use semantic roles, not ad-hoc color picking
- One accent color per view maximum
- State colors must be distinguishable (don't rely on color alone — add icons)

---

### Core Container Scale

Semantic container widths for consistent content areas.

| Token | Class | Max Width | Use For |
|-------|-------|-----------|---------|
| **Narrow** | `max-w-md` | 448px | Auth forms, single-column dialogs |
| **Content** | `max-w-xl` | 576px | Article content, focused views |
| **Default** | `max-w-2xl` | 672px | Main content areas, forms |
| **Wide** | `max-w-4xl` | 896px | Dashboards, data tables |
| **Full** | `max-w-6xl` | 1152px | Wide layouts, admin panels |
| **Prose** | `max-w-prose` | 65ch | Long-form text (optimal reading width) |

**Container Rules**:
- Always center containers: `mx-auto`
- Add horizontal padding: `px-4` or `px-6`
- Pick one container width per page/view — don't mix
- Prose content should use `max-w-prose` for readability

**Container Pattern**:
```
<!-- Standard page container -->
<main class="max-w-2xl mx-auto px-4 py-16">

<!-- Wide dashboard -->
<main class="max-w-6xl mx-auto px-6 py-8">

<!-- Prose article -->
<article class="max-w-prose mx-auto px-4 py-12">
```

---

### Core Component Sizes

Consistent sizing tiers for interactive components.

#### Buttons
| Size | Height | Padding | Text | Icon | Use For |
|------|--------|---------|------|------|---------|
| **Small** | `h-8` | `px-3` | `text-sm` | `size-4` | Inline actions, table rows, compact UI |
| **Default** | `h-10` | `px-4` | `text-sm` | `size-4` | Standard buttons, forms |
| **Large** | `h-12` | `px-6` | `text-base` | `size-5` | Primary CTAs, hero sections |

**Button Examples**:
```
<!-- Small button -->
<button class="h-8 px-3 text-sm rounded">

<!-- Default button -->
<button class="h-10 px-4 text-sm rounded-md">

<!-- Large button -->
<button class="h-12 px-6 text-base rounded-md">

<!-- Icon-only button (square, needs aria-label) -->
<button class="size-10 rounded-md" aria-label="Close">
```

#### Inputs
| Size | Height | Padding | Text | Use For |
|------|--------|---------|------|---------|
| **Small** | `h-8` | `px-2` | `text-sm` | Compact forms, filters, table cells |
| **Default** | `h-10` | `px-3` | `text-sm` | Standard forms |
| **Large** | `h-12` | `px-4` | `text-base` | Featured inputs, search bars |

**Input Examples**:
```
<!-- Default input -->
<input class="h-10 px-3 text-sm rounded-md border border-neutral-300 dark:border-neutral-600 bg-white dark:bg-neutral-800">

<!-- Large search input -->
<input class="h-12 px-4 text-base rounded-md border border-neutral-300 dark:border-neutral-600 bg-white dark:bg-neutral-800">
```

#### Avatars
| Size | Classes | Use For |
|------|---------|---------|
| **XS** | `size-6` | Inline mentions, dense lists |
| **Small** | `size-8` | Comments, compact cards |
| **Default** | `size-10` | List items, cards |
| **Large** | `size-12` | Profile headers, featured users |
| **XL** | `size-16` | Profile pages, hero sections |

**Avatar Example**:
```
<img class="size-10 rounded-full" src="..." alt="User name">
```

#### Badges/Tags
| Size | Classes | Use For |
|------|---------|---------|
| **Small** | `px-1.5 py-0.5 text-xs` | Inline status, counts |
| **Default** | `px-2 py-1 text-xs` | Standard tags, categories |

**Badge Example**:
```
<span class="px-2 py-1 text-xs font-medium rounded bg-blue-100 text-blue-700 dark:bg-blue-900 dark:text-blue-300">
  New
</span>
```

---

### Core Icon Sizes

Consistent icon sizing for different contexts.

| Size | Classes | Use For |
|------|---------|---------|
| **Inline** | `size-4` (16px) | Inline with text, small buttons, badges |
| **Default** | `size-5` (20px) | Buttons, list items, navigation |
| **Large** | `size-6` (24px) | Large buttons, feature icons, headers |
| **Feature** | `size-8` (32px) | Feature highlights, empty states |
| **Hero** | `size-12` (48px) | Hero sections, onboarding |

**Icon Rules**:
- Icons must have `aria-hidden="true"` when decorative
- Icon-only buttons must have `aria-label`
- Match icon size to text size: `text-sm` → `size-4`, `text-base` → `size-5`
- Use consistent stroke width (typically 1.5 or 2)

**Icon Pattern**:
```
<!-- Icon with text -->
<button class="h-10 px-4 flex items-center gap-2">
  <svg class="size-4" aria-hidden="true">...</svg>
  <span class="text-sm">Label</span>
</button>

<!-- Icon-only button -->
<button class="size-10 flex items-center justify-center" aria-label="Settings">
  <svg class="size-5" aria-hidden="true">...</svg>
</button>
```

---

## Auto-Fix Policy

Safe to fix automatically:
- Add `alt=""` to decorative images
- Add `aria-label` to icon buttons
- Replace `h-screen` → `h-dvh`
- Add `text-balance` to headings, `text-pretty` to body, `tabular-nums` to numbers
- Replace arbitrary values with nearest Tailwind scale value (font size, spacing, radius, etc.)
- Replace `div onClick` → `button`
- Add `type="button"` to non-submit buttons
- Replace `w-*` + `h-*` with `size-*` for squares
- Replace `font-serif`/`font-mono` → `font-sans` (except in code blocks)
- Remove arbitrary font-family values → use `font-sans`
- Add missing `dark:` variants using standard color pairings
- Replace `dark:bg-black` → `dark:bg-neutral-900`
- Replace `dark:text-white` → `dark:text-neutral-100`
- Replace other greyscales → `neutral-*` (e.g., `bg-gray-100` → `bg-neutral-100`, `text-slate-900` → `text-neutral-900`)
- Normalize typography to Core Type Scale roles
- Normalize spacing to Core Spacing Scale tokens (e.g., `p-5` → `p-4` or `p-6`, `gap-7` → `gap-6` or `gap-8`)
- Normalize elevation to Core Elevation Scale (add missing dark mode borders to shadows)
- Normalize container widths to Core Container Scale (e.g., `max-w-lg` → `max-w-xl` for Content, `max-w-3xl` → `max-w-2xl` or `max-w-4xl`)
- Normalize button/input heights to Core Component Sizes (e.g., `h-9` → `h-8` or `h-10`)
- Normalize icon sizes to Core Icon Sizes (e.g., `size-3` → `size-4`, `size-7` → `size-6` or `size-8`)

Never auto-fix:
- Semantic structure
- Animation removal
- Component library swaps
- Colors or design choices

---

## Output Format

When reviewing, output:

```
**Violation:** {what's wrong}
**Location:** `{file}:{line}`
**Why:** {one sentence}
**Fix:** {code suggestion}
```

When scoring (if asked), output a score out of 100 with breakdown.
